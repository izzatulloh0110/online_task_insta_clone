import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_task_insta_clone/models/post_model.dart';

import '../models/user_model.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  UserModel? user;
  List<Post> _itemsOfList = [];
  String post_img1 = "https://cdn.britannica.com/86/135986-050-FECFA37E/Islam-Karimov-2002.jpg";
  String post_img2 = "https://img.championat.com/s/735x490/news/big/y/c/islam-mahachev-voshyol-v-top-5-rejtinga-ufc_1626869736554460287.jpg";
@override
  void initState() {
    // TODO: implement initState
    _itemsOfList.add(Post(caption: 'Didcover more great images on our sponsors site',
        postImage: post_img1));
    _itemsOfList.add(Post(caption: 'Didcover more great images on our sponsors site',
        postImage: post_img2));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyle(
              color: Color.fromRGBO(193, 53, 132, 1),
              fontSize: 40,
              fontFamily: "Billabong"),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          //#profile image
          Container(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                    width: 1.5, color: Color.fromRGBO(193, 53, 132, 1)),
              ),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/ic_person.png"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        (Icons.add_circle),
                        size: 25,
                        color: Colors.purple.shade700,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          //#userName
          Text("khaliljonov0110",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
          SizedBox(height: 5,),
          Text("ikn0110",style: TextStyle(fontSize: 18,color: Colors.grey.shade600),),
          SizedBox(height: 10,),
          Container(
            height: 80,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("0",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                    Text("Posts")
                  ],
                ),

                Container(
                  height: 30,
                  width: 1,
                  color: Colors.grey,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("0",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                    Text("Followers")
                  ],
                ),
                Container(
                  height: 30,
                  width: 1,
                  color: Colors.grey,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("0",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                    Text("Following")
                  ],
                ),

              ],
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.check_box_outline_blank_sharp,size: 35,)),
              SizedBox(width: 100,),
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.check_box_outline_blank_sharp,size: 35,))
            ],
          ),
          SizedBox(height: 10,),
          Expanded(
              child: GridView.builder(
                itemCount: _itemsOfList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (ctx,index){
                return itemOfPost(_itemsOfList[index]);
                  }))

        ],
      ),
    );
  }
  Widget itemOfPost(Post post){
  return Container(
    padding: EdgeInsets.all(15),
    child: Column(
      children: [
        Expanded(
          child:
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
                // child: Image.network(post.postImage))
           child: CachedNetworkImage(
              width: double.infinity,
              imageUrl: post.postImage,
              placeholder: (context,url) =>CircularProgressIndicator(),
              errorWidget: (context,url,error)=>Icon(Icons.error),
              fit: BoxFit.cover,

            ),
  
        ) ,

        ),
        SizedBox(height: 10,),
        Text(post.caption,style: TextStyle(fontSize: 18),)
      ],
    ),
  );
  }
}
