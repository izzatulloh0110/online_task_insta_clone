import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_task_insta_clone/pages/my_feed_page.dart';
import 'package:online_task_insta_clone/pages/my_likes_page.dart';
import 'package:online_task_insta_clone/pages/my_profile_page.dart';
import 'package:online_task_insta_clone/pages/my_search_page.dart';
import 'package:online_task_insta_clone/pages/my_upload_page.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController? _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          MyFeedPage(pageController: _pageController!,),
          MySearchPage(),
          MyUploadPage(),
          MyLikesPage(),
          MyProfilePage()
        ],
        onPageChanged: (int index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        onTap: (int index){
          setState(() {
            _currentIndex = index;
            _pageController?.animateToPage(
                index, duration: Duration(microseconds: 200),
                curve: Curves.easeIn);
          });
        },
        activeColor: Color.fromRGBO(193, 53, 132, 1),
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
            Icons.home_filled,
            size: 33,
          )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 33,
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_box,
                size: 33,
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                size: 33,
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_pin,
                size: 38,
              )),

        ],
      ),
    );
  }
}
