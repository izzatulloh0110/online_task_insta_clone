import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_task_insta_clone/pages/home_page.dart';
import 'package:online_task_insta_clone/pages/signin_page.dart';
import 'package:online_task_insta_clone/pages/signup_page.dart';
import 'package:online_task_insta_clone/pages/splash_page.dart';
import 'package:online_task_insta_clone/services/prefs_service.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
      routes: {
        SplashPage.id: (context)=> SplashPage(),
        SignInPage.id: (context)=> SignInPage(),
        SignUpPage.id: (context)=> SignUpPage(),
        HomePage.id: (context)=> HomePage(),

      },
    );
  }
}
