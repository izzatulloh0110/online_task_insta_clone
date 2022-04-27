import 'package:flutter/material.dart';

import '../models/user_model.dart';

class MySearchPage extends StatefulWidget {
  const MySearchPage({Key? key}) : super(key: key);

  @override
  _MySearchPageState createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  List<UserModel> itemOfList = [];

  @override
  void initState() {
    // TODO: implement initState
    itemOfList.add(UserModel(fullName: "Izzatulloh", email: "ikn0110", password: ''));
    itemOfList.add(UserModel(fullName: "Izzatulloh", email: "ikn0110", password: ''));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "SearCh",
          style: TextStyle(
              color: Color.fromRGBO(193, 53, 132, 1),
              fontSize:37,
              fontFamily: "Billabong"),
        ),

      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                  hintText: "Search"
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                  itemCount: itemOfList.length,
                    itemBuilder: (ctx ,index)=> _itemOfUser(itemOfList[index]),
                ),)
          ],
        ),
      ),

    );
  }
  Widget _itemOfUser(UserModel user){
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 80,
child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Row(children: [
      Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 1.5,
              color: Color.fromRGBO(193, 53, 132, 1 )
          ),
        ),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/ic_person.png"),
              fit: BoxFit.cover
            ),
              borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      SizedBox(width: 15,),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(user.fullName,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
        SizedBox(height: 5,),
        Text(user.email,style: TextStyle(color: Colors.black,fontSize: 15),)
      ],)
    ],),
    Container(
      height: 30,
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(width: 1,color: Colors.grey)
      ),
      child: Center(
        child: Text("Follow"),
      ),
    )
],),
    );

  }
}
