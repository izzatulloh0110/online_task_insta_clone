import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/post_model.dart';

class MyFeedPage extends StatefulWidget {
  PageController pageController;

  MyFeedPage({required this.pageController});


  @override
  _MyFeedPageState createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {
  bool isLoading = false;
  PageController pageController = PageController();
  List<Post> items = [];
  String post_img1 = "https://cdn.britannica.com/86/135986-050-FECFA37E/Islam-Karimov-2002.jpg";
  String post_img2 = "http://ndelo.ru/media/posts/2019/4/20/daavat-priglasheni/nyeBWYhfxDRiQSVD-lg_1.thumb.jpg";

  @override
  void initState() {
    // TODO: implement initState
    items.add(Post(
        postImage: post_img1,
        caption: "Didcover more great images on our sponsors site"));
    items.add(Post(
        postImage: post_img2,
        caption: "Didcover more great images on our sponsors site"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Instagram",
          style: TextStyle(
              color: Color.fromRGBO(193, 53, 132, 1),
              fontSize: 40,
              fontFamily: "Billabong"),
        ),
        actions: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child:  IconButton(
                color: Color.fromRGBO(193, 53, 132, 1),
                onPressed: () {
                  widget.pageController.animateToPage(2,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeIn);
                },
                icon: Icon(
                  Icons.camera_alt,
                  size: 30,
                ),
              )),
        ],
      ),
      body: Container(
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => _itemOfPost(items[index])),
      ),
    );
  }

  Widget _itemOfPost(Post post) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 15),
      // margin: EdgeInsets.symmetric(vertical: 15),
      // width: double.infinity,
      // height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(

                      borderRadius: BorderRadius.circular(40),
                      child: Image(
                        image: AssetImage("assets/images/ic_person.png"),
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      )
                    ),
                    SizedBox(width: 20,),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("UserName"),
                      Text("February 29, 2022")
                    ],)
                  ],
                ),
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.more_horiz,size: 30,))
              ],
            ),

          ),
          //#PostImage
          // CachedNetworkImage(
          //   height: MediaQuery.of(context).size.width,
          //   width: MediaQuery.of(context).size.width,
          //     imageUrl: post.postImage,
          //     placeholder: (context,url) =>CupertinoActivityIndicator(),
          //   errorWidget: (context,url, error)=> Icon(Icons.error)
          // ),
         Image.network(post.postImage,fit: BoxFit.cover,),
          //#Like and share
          Row(children:<Widget> [
            IconButton(
                onPressed: (){},
                icon: Icon(Icons.favorite_border,size: 27,),
            ),
            IconButton(onPressed: (){},
                icon: Icon(Icons.send,size: 27,))
          ],)
        ],
      ),
    );
  }

}
