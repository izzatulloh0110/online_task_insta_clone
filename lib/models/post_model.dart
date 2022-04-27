import 'package:flutter/cupertino.dart';

class Post{
  String uid = "";
  String id = "";
  String fullName = "";
  String createDate = "";
  late String postImage;
   late String caption;
  String? imageUser;
  bool isMine = false;
  bool isLiked = false;

  Post({required this.postImage, required this.caption});

  Post.fromJson(Map<String,dynamic>json){
    uid = json["uid"];
    id = json["id"];
    fullName = json["fullName"];
    createDate = json["createdate"];
    postImage = json["postImage"];
    caption = json["caption"];
    imageUser = json["imageUser"];
    isLiked = json["isLiked"];
    isMine = json["isMine"];
  }

  Map<String, dynamic>toJson() =>{
"uid" : uid,
    "id": id,
    "fullName": fullName,
    "createName": createDate,
    "postImage": postImage,
    "caption": caption,
    "imageUser": imageUser,
    "isLiked": isLiked,
    "isMine": isMine

};

}