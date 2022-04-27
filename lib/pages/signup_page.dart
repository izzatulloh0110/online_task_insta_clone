import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_task_insta_clone/pages/signin_page.dart';

import 'package:online_task_insta_clone/models/user_model.dart' as model;
import 'package:online_task_insta_clone/services/auth_service.dart';
import 'package:online_task_insta_clone/services/prefs_service.dart';
import '../services/utils.dart';

class SignUpPage extends StatefulWidget {
  static const String id = "signup_page";

  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void _openSignInPage() async {
    String fullName = fullNameController.text.trim().toString();
    String email = emailController.text.trim().toString();
    String password = passwordController.text.trim().toString();
    String confirmPassword = confirmPasswordController.text.trim().toString();

    if (fullName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Utils.fireSnackBar("Please complete all the fields", context);
      return;
    }
    setState(() {
      isLoading = true;
    });
    var modelUser = model.UserModel(
      password: password,
      fullName: fullName,
      email: email,
    );
    await AuthService.signUpUser(modelUser).then((response) {
      _getFirebaseUser(modelUser, response);
    });
  }

  void _getFirebaseUser(model.UserModel modelUser, Map<String, User?> map) async{
    setState(() {
      isLoading = false;
    });

    if (!map.containsKey("SUCCES")) {
      if (map.containsKey("weak-password")) Utils.fireSnackBar(
          "The password provided is too weak", context);
      if (map.containsKey("email-already-in-use")) Utils.fireSnackBar(
          "That account already exists that eamil", context);
      if (map.containsKey("ERROR")) Utils.fireSnackBar(
          "Check your information", context);
      return;
    }

    User? user = map["SUCCES"];
    if(user == null)
      return;
await Prefs.store(StorageKeys.UID, user.uid);
modelUser.uid =user.uid;



  }
  // _callSignUpPage() {
  //   Navigator.pushReplacementNamed(context, SignInPage.id);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Instagram",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Billabong",
                      fontSize: 45),
                ),
                SizedBox(
                  height: 10,
                ),
                //#fullname
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: TextField(
                    controller: fullNameController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Fulname",
                        hintStyle: TextStyle(color: Colors.grey.shade300)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //#email
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.grey.shade300)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //#Password
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.grey.shade300)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //#confirm Password
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: TextField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Confirem Password",
                        hintStyle: TextStyle(color: Colors.grey.shade300)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //#sign up
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: Colors.white54)),
                  child: MaterialButton(
                    height: MediaQuery.of(context).size.height * 0.05,
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () {},
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                )
              ],
            )),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an accaount? ",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: _openSignInPage,
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
