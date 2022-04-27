import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyUploadPage extends StatefulWidget {
  const MyUploadPage({Key? key}) : super(key: key);

  @override
  _MyUploadPageState createState() => _MyUploadPageState();
}

class _MyUploadPageState extends State<MyUploadPage> {
  TextEditingController captionController = TextEditingController();
bool isLoading =false;
  File? _image;

  //#from camera
  _imageFromCamera()async{
    XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
      imageQuality: 50
    );
    setState(() {
      _image = File(image!.path);
    });
  }
  //#from gallery
  _imageFromGallery() async{
    XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
    imageQuality: 50
    );
    setState(() {
      _image =  File(image!.path);
    });
   }
  uploadNewPost() {
  String caption = captionController.text.trim().toString();
  if(caption.isEmpty || _image==null) return;

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Icon(Icons.post_add_rounded,color: Color.fromRGBO(193, 53, 132, 1),size: 30,)

        ],
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Upload",
            style: TextStyle(
                color: Color.fromRGBO(193, 53, 132, 1),
                fontSize:37,
                fontFamily: "Billabong"),
            ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              //# pick Image
              GestureDetector(
                onTap: (){
                  _bottomSheet();
                  },
                child:
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: _image ==null ?Center(
                    child: Icon(
                      Icons.add_a_photo,size: 85,color: Color.fromRGBO(193, 53, 132, 1)),
                    )
                      :
                      Stack(
                        children: [
                          Image.file(
                            _image!,
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,

                          )
                        ],
                      )

                  ),
              ),
              //#caption
              Container(
                margin: EdgeInsets.only(left: 20,right: 10,bottom: 20),
                child: TextField(
                  controller: captionController,
                  style: TextStyle(color: Color.fromRGBO(193, 53, 132, 1)),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Caption",
                    hintStyle: TextStyle(fontSize: 17,color: Colors.grey.shade700)
                  ),
                ),
              )

            ],
          ),
        ),

      ));


  }
  void _bottomSheet(){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)
            ),
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              //#pick photo
              GestureDetector(
                onTap: (){
                  _imageFromGallery();
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.image),
                    SizedBox(width: 15,),
                    Text("Pick Photo",style: TextStyle(fontSize: 20,color: Colors.black),),

                  ],
                ),
              ),
              SizedBox(height: 20,),
              //#take photo
              GestureDetector(
                onTap: (){
                  _imageFromCamera();
                },
                child: Row(
                  children: [
                    Icon(Icons.camera_alt),
                    SizedBox(width: 15,),
                    Text("Take Photo",style: TextStyle(fontSize: 20,color: Colors.black),),

                  ],
                ),
              ),



            ],),
          );
        });

  }
}
