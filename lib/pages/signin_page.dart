import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_task_insta_clone/pages/signup_page.dart';
import 'package:online_task_insta_clone/services/auth_service.dart';
import 'package:online_task_insta_clone/services/prefs_service.dart';

import '../services/utils.dart';
import 'home_page.dart';

class SignInPage extends StatefulWidget {
  static const String id = "signin_page";

  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _callSignUpPage() {
    Navigator.pushReplacementNamed(context, SignUpPage.id);
  }

  // _callHomePage() {
  //   Navigator.pushReplacementNamed(context, HomePage.id);
  // }

  _doSignInPage() async {
    String email = emailController.text.trim().toString();
    String password = passwordController.text.trim().toString();
    if (email.isEmpty || password.isEmpty) {
      Utils.fireSnackBar("please complete all the fields ", context);
      return;
    }
    setState(() {
      isLoading = true;
    });
    await AuthService.signInUser(email, password).then((response) {
      _getFirebaseUser(response);
    });
  }

  void _getFirebaseUser(Map<String, User?> map) async {
    setState(() {
      isLoading = false;
    });

    if (map.containsKey("SUCCESS")) {
      if (map.containsKey("user-not-found"))
        Utils.fireSnackBar("No user found for that email.", context);
      if (map.containsKey("wrong-password"))
        Utils.fireSnackBar("Wrong password provided for that user.", context);
      if (map.containsKey("ERROR"))
        Utils.fireSnackBar("Check Your Information.", context);
      return;
    }
    User? user = map["SUCCES"];
    if (user == null) return;
    await Prefs.store(StorageKeys.UID, user.uid);
    Navigator.pushReplacementNamed(context, HomePage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                        child: Stack(
                      children: [
                        Column(
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
                            //#eamil
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
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade200)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //#password
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
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade300)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 2, color: Colors.white24)),
                              child: MaterialButton(
                                elevation: 1,
                                disabledElevation: 1,
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () {
                                  _doSignInPage();
                                },
                              ),
                            ),
                          ],
                        ),
                        isLoading
                            ? Center(
                                child: CupertinoActivityIndicator(),
                              )
                            : SizedBox.shrink(),
                      ],
                    )),
                    //# on tap  SignUPPage
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an accaount? ",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: _callSignUpPage,
                            child: Text(
                              "Sign Up",
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
                isLoading
                    ? Center(child: CircularProgressIndicator.adaptive())
                    : SizedBox.shrink(),
              ],
            )),
      ),
    );
  }
}
