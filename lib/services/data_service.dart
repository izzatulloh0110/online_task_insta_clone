import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_task_insta_clone/models/post_model.dart';
import 'package:online_task_insta_clone/models/user_model.dart';
import 'package:online_task_insta_clone/services/prefs_service.dart';
import 'package:online_task_insta_clone/services/utils.dart';


import 'http_service.dart';

class DataService {
  // init
  static final instance = FirebaseFirestore.instance;

  // folder
  static const String folderUsers = "users";
  static const String folderPosts = "posts";
  static const String folderFeeds = "feeds";
  static const String folderFollowing = "following";
  static const String folderFollowers = "followers";

  // User
  static Future<void> storeUser(UserModel userModel) async {
    userModel.uid = (await Prefs.load(StorageKeys.UID))!;

    Map<String, String> params = await Utils.deviceParams();

    userModel.device_id = params["device_id"]!;
    userModel.device_type = params["device_type"]!;
    userModel.device_token = params["device_token"]!;


    return instance.collection(folderUsers).doc(userModel.uid).set(userModel.toJson());
  }

  static Future<UserModel> loadUser() async {
    String uid = (await Prefs.load(StorageKeys.UID))!;
    var value = await instance.collection(folderUsers).doc(uid).get();
    UserModel userModel = UserModel.fromJson(value.data()!);

    var querySnapshot1 = await instance.collection(folderUsers).doc(uid).collection(folderFollowers).get();
    userModel.followersCount = querySnapshot1.docs.length;

    var querySnapshot2 = await instance.collection(folderUsers).doc(uid).collection(folderFollowing).get();
    userModel.followingCount = querySnapshot2.docs.length;

    return userModel;
  }

  static Future<void> updateUser(UserModel userModel) async {
    // String uid = (await Prefs.load(StorageKeys.UID))!;
    return instance.collection(folderUsers).doc(userModel.uid).update(userModel.toJson());
  }

  static Future<List<UserModel>> searchUsers(String keyword) async {
    UserModel userModel = await loadUser();
    List<UserModel> usersModel = [];
    // write request
    var querySnapshot = await instance.collection(folderUsers).orderBy("fullName").startAt([keyword]).endAt([keyword + '\uf8ff']).get();

    for (var element in querySnapshot.docs) {
      usersModel.add(UserModel.fromJson(element.data()));
    }
    usersModel.remove(userModel);

    List<UserModel> following = [];
    var querySnapshot2 = await instance.collection(folderUsers).doc(userModel.uid).collection(folderFollowing).get();

    for (var result in querySnapshot2.docs) {
      following.add(UserModel.fromJson(result.data()));
    }

    for(UserModel userModel in usersModel){
      if(following.contains(userModel)){
        userModel.followed = true;
      }else{
        userModel.followed = false;
      }
    }
    return usersModel;
  }

  // Post
  static Future<Post> storePost(Post post) async {
    // filled post
    UserModel me = await loadUser();
    post.uid = me.uid;
    post.fullName = me.fullName;
    post.imageUser = me.imageUrl;
    post.createDate = DateTime.now().toString();

    String postId = instance.collection(folderUsers).doc(me.uid).collection(folderPosts).doc().id;
    post.id = postId;
    await instance.collection(folderUsers).doc(me.uid).collection(folderPosts).doc(postId).set(post.toJson());
    return post;
  }

  static Future<Post> storeFeed(Post post) async {
    String uid = (await Prefs.load(StorageKeys.UID))!;
    await instance.collection(folderUsers).doc(uid).collection(folderFeeds).doc(post.id).set(post.toJson());
    return post;
  }

  static Future<List<Post>> loadFeeds() async {
    List<Post> posts = [];
    String uid = (await Prefs.load(StorageKeys.UID))!;
    var querySnapshot = await instance.collection(folderUsers).doc(uid).collection(folderFeeds).get();

    for (var element in querySnapshot.docs) {
      Post post = Post.fromJson(element.data());
      if(post.uid == uid) post.isMine = true;
      posts.add(post);
    }

    return posts;
  }

  static Future<List<Post>> loadPosts() async {
    List<Post> posts = [];
    String uid = (await Prefs.load(StorageKeys.UID))!;
    var querySnapshot = await instance.collection(folderUsers).doc(uid).collection(folderPosts).get();

    for (var element in querySnapshot.docs) {
      posts.add(Post.fromJson(element.data()));
    }
    return posts;
  }

  static Future<Post> likePost(Post post, bool liked) async {
    String uid = (await Prefs.load(StorageKeys.UID))!;
    post.isLiked = liked;

    await instance.collection(folderUsers).doc(uid).collection(folderFeeds).doc(post.id).update(post.toJson());

    if(uid == post.uid) {
      await instance.collection(folderUsers).doc(uid).collection(folderPosts).doc(post.id).update(post.toJson());
    }

    return post;
  }

  static Future<List<Post>> loadLikes() async {
    String uid = (await Prefs.load(StorageKeys.UID))!;
    List<Post> posts = [];

    var querySnapshot = await instance.collection(folderUsers).doc(uid).collection(folderFeeds).where("isLiked", isEqualTo: true).get();

    for (var element in querySnapshot.docs) {
      Post post = Post.fromJson(element.data());
      if(post.uid == uid) post.isMine = true;
      posts.add(post);
    }

    return posts;
  }

  // Follower and Following
  static Future<UserModel> followUser(UserModel someone) async {
    UserModel me = await loadUser();

    // I followed to someone
    await instance.collection(folderUsers).doc(me.uid).collection(folderFollowing).doc(someone.uid).set(someone.toJson());

    // I am in someone`s followers
    await instance.collection(folderUsers).doc(someone.uid).collection(folderFollowers).doc(me.uid).set(me.toJson());

    // for notification

    await HttpService.POST(HttpService.paramCreate(someone.device_token, me.fullName, someone.fullName)).then((value) => {
      print("response notification: ${value.toString()}")
    });

    return someone;
  }

  static Future<User> unFollowUser(User someone) async {
    UserModel me = await loadUser();

    // I un followed to someone
    await instance.collection(folderUsers).doc(me.uid).collection(folderFollowing).doc(someone.uid).delete();

    // I am not in someone`s followers
    await instance.collection(folderUsers).doc(someone.uid).collection(folderFollowers).doc(me.uid).delete();

    return someone;
  }

  static Future storePostsToMyFeed(User someone) async {
    // Store someone`s posts to my feed
    List<Post> posts = [];

    var querySnapshot = await instance.collection(folderUsers).doc(someone.uid).collection(folderPosts).get();

    for (var element in querySnapshot.docs) {
      Post post = Post.fromJson(element.data());
      post.isLiked = false;
      posts.add(post);
    }

    for(Post post in posts) {
      storeFeed(post);
    }
  }

  static Future removePostsFromMyFeed(User someone) async {
    // Remove someone`s posts from my feed
    List<Post> posts = [];

    var querySnapshot = await instance.collection(folderUsers).doc(someone.uid).collection(folderPosts).get();
    for (var element in querySnapshot.docs) {
      posts.add(Post.fromJson(element.data()));
    }

    for(Post post in posts){
      removeFeed(post);
    }
  }

  static Future removeFeed(Post post) async {
    String uid = (await Prefs.load(StorageKeys.UID))!;
    return await instance.collection(folderUsers).doc(uid).collection(folderFeeds).doc(post.id).delete();
  }

  static Future removePost(Post post) async {
    String uid = (await Prefs.load(StorageKeys.UID))!;
    await removeFeed(post);
    return await instance.collection(folderUsers).doc(uid).collection(folderPosts).doc(post.id).delete();
  }
}