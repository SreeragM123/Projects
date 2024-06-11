import 'dart:convert';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:news_droid/signup.dart';
import 'package:news_droid/ui/main_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'forgotpass.dart';
import 'forgotpassnew.dart';
import 'homenew.dart';
import 'logindemo.dart';


void main() {
  runApp(const MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(32, 63, 129, 1.0),
        ),
      ),
      home:  addnews_full(),
    );
  }
}


class addnews_full extends StatefulWidget {


  addnews_full({
    Key? key,
  }) : super(key: key);

  @override
  State<addnews_full> createState() => _LoginState();
}

class _LoginState extends State<addnews_full> {

  // final FocusNode _focusNodePassword = FocusNode();
  // final TextEditingController _controllerUsername = TextEditingController();
  // final TextEditingController _controllerPassword = TextEditingController();


  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String dropdownValue1 = 'POLITICAL';


  final _formkey=GlobalKey<FormState>();


  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomeNewPage(title: '',),));

        return false;
      },      child: Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.orange.shade900,
                  Colors.orange.shade800,
                  Colors.orange.shade400
                ]
            )
        ),
        child: Form(
          key: _formkey,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 80,),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeInUp(duration: Duration(milliseconds: 1000), child: Text("Add News", style: TextStyle(color: Colors.white, fontSize: 40),)),
                    SizedBox(height: 10,),
                    // FadeInUp(duration: Duration(milliseconds: 1300), child: Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 18),)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        if (_selectedImage != null) ...{
                          CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.grey[200],
                            child: InkWell(
                              onTap: _checkPermissionAndChooseImage,
                              child: CircleAvatar(
                                radius: 80,
                                backgroundColor: Colors.white,
                                child: ClipOval(
                                  child: Image.file(
                                    _selectedImage!,
                                    fit: BoxFit.cover,
                                    height: 140,
                                    width: 140,
                                  ),
                                ),
                              ),
                            ),
                          )
                        } else ...{
                          // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
                          InkWell(
                            onTap: _checkPermissionAndChooseImage,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),
                                  radius: 80,
                                ),
                                // Image(
                                //
                                //   image: NetworkImage(
                                //       'https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),
                                //   height: 150,
                                //   width: 150,
                                //
                                // ),
                                Text('Select Image', style: TextStyle(color: Colors.cyan))
                              ],
                            ),
                          ),
                        },


                        SizedBox(height: 60,),
                        FadeInUp(duration: Duration(milliseconds: 1400), child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(
                                  color: Color.fromRGBO(225, 95, 27, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10)
                              )]
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  controller: titleController,
                                  decoration: InputDecoration(
                                      hintText: "Title",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter the title.";
                                    }

                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  controller: descController,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "Description",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter the description.";
                                    }

                                    return null;
                                  },
                                ),
                              ),

                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  controller: placeController,

                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "Place",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter the place.";
                                    }

                                    return null;
                                  },
                                ),
                              ),

                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  controller: cityController,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "City",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter the city.";
                                    }

                                    return null;
                                  },
                                ),
                              ),

                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  controller: stateController,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "State",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter the state.";
                                    }

                                    return null;
                                  },
                                ),
                              ),

                              SizedBox(height: 15, width: 10,),

                              DropdownButton<String>(
                                isExpanded: true,

                                value: dropdownValue1,
                                onChanged: (String? value) {
                                  setState(() {
                                    dropdownValue1 = value!;
                                  });
                                },
                                items: ['POLITICAL','ENTERTAINMENT','BUISNESS','SPORTS'].map((String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),


                            ],
                          ),
                        )),

                        SizedBox(height: 40,),
                        FadeInUp(duration: Duration(milliseconds: 1600), child: MaterialButton(
                          onPressed: () {
                            if(_formkey.currentState!.validate()){
                              _send_data();
                            }

                          },
                          height: 50,
                          // margin: EdgeInsets.symmetric(horizontal: 50),
                          color: Colors.orange[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),

                          ),
                          // decoration: BoxDecoration(
                          // ),
                          child: Center(
                            child: Text("Send", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                        )),
                        // SizedBox(height: 40,),
                        // FadeInUp(duration: Duration(milliseconds: 1500), child: Text("Don't have an account?", style: TextStyle(color: Colors.grey),)),



                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
    );
  }


  @override
  void dispose() {

    super.dispose();
  }



  void _send_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/User_addnews_post/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid,
        'textfield': titleController.text,
        'textarea' : descController.text,
        'fileField' :photo,
        'textfield2' : placeController.text,
        'textfield3' : cityController.text,
        'textfield4' : stateController.text,
        'category' : dropdownValue1
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'Done');

          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeNewPage(title: 'HOME',)));


        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  String photo = '';
  File? uploadimage;
  File? _selectedImage;
  String? _encodedImage;

  Future<void> _chooseAndUploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
        photo = _encodedImage.toString();
      });
    }
  }

  Future<void> _checkPermissionAndChooseImage() async {
    final PermissionStatus status = await Permission.mediaLibrary.request();
    if (status.isGranted) {
      _chooseAndUploadImage();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
            'Please go to app settings and grant permission to choose an image.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}