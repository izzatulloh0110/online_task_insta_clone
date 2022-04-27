import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_task_insta_clone/models/user_model.dart' as model;
import 'package:online_task_insta_clone/pages/signin_page.dart';
import 'package:online_task_insta_clone/services/prefs_service.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  static const String id = "splash_page";

  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}



class _SplashPageState extends State<SplashPage> {

  Widget _startStartPage(){
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context,snapshot){
        if(snapshot.hasData){
          Prefs.store(StorageKeys.UID, snapshot.data!.uid);
          return HomePage();
      }
        else {
          Prefs.remove(StorageKeys.UID);
          return SignInPage();
        }
      },
    );
  }

  Widget starterPage() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          Prefs.store(StorageKeys.UID, snapshot.data!.uid);
          return HomePage();
        } else {
          Prefs.remove(StorageKeys.UID);
          return SignInPage();
        }
      },
    );
  }





void _openSignInPage() =>
    Timer(const Duration(seconds: 2), () =>
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
            starterPage()))
    );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _openSignInPage();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(193, 53, 132, 1),
                  Color.fromRGBO(131, 58, 180, 1),
                ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: Center(
                  child: Text(
                    "Instagram",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 65,
                        fontFamily: "Billabong"),
                  ),
                )),
            Text(
              "All rights reserved",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }}

