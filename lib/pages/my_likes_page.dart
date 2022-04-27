import 'package:flutter/material.dart';

class MyLikesPage extends StatefulWidget {
  const MyLikesPage({Key? key}) : super(key: key);

  @override
  _MyLikesPageState createState() => _MyLikesPageState();
}

class _MyLikesPageState extends State<MyLikesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "likE",
          style: TextStyle(
              color: Color.fromRGBO(193, 53, 132, 1),
              fontSize:37,
              fontFamily: "Billabong"),
        ),

      ),

      backgroundColor: Colors.white,
      body: Container(),

    );
  }
}
