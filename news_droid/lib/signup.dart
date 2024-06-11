import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MySignupPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MySignupPage extends StatefulWidget {
  const MySignupPage({super.key, required this.title});



  final String title;

  @override
  State<MySignupPage> createState() => _MySignupPageState();
}

class _MySignupPageState extends State<MySignupPage> {
  int _counter = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conpasswordController = TextEditingController();


  void _incrementCounter() {
    setState(() {

    });
  }
  String gender="Male";


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{return true;},
      child: Scaffold(
        appBar: AppBar(

          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,

          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              if (_selectedImage != null) ...{
        InkWell(
        child: Image.file(
        _selectedImage!,
        height: 200,
        width: 200,
        ),
        radius: 300,
        onTap: _checkPermissionAndChooseImage,
        // borderRadius: BorderRadius.all(Radius.circular(200)),
        ),
        } else ...{
        // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
        InkWell(
        onTap: _checkPermissionAndChooseImage,
        child: Column(
        children: [
        Image(
        image: NetworkImage(
        'https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),
        height: 150,
        width: 150,
        ),
        Text('Select Image', style: TextStyle(color: Colors.cyan))
        ],
        ),
        ),
        },
              TextField(decoration: InputDecoration(labelText: "Name"),
                controller: nameController,),

              SizedBox(height: 15, width: 10,),

              TextField(decoration: InputDecoration(labelText: "DOB"),
                controller: dobController,),

              SizedBox(height: 15, width: 10,),

              Padding(
                padding: EdgeInsets.all(7),
                child: Row(
                  children: [
                    Text(" Gender:"),
                    SizedBox(width: .5,),
                    Radio(
                        value: "Male",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = "Male";
                          });
                        }),
                    Text("Male"),
                    SizedBox(
                      width: .5,
                    ),
                    Radio(
                        value: "Female",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = "Female";
                          });
                        }),
                    Text("Female"),
                    SizedBox(
                      width: .5,
                    ),
                    Radio(
                        value: "Others",
                        groupValue: gender,
                        // onChanged: (String? value) {
                        //   gender = "Others";
                        onChanged: (value) {
                          setState(() {
                            gender = "Others";
                          });
                        }),
                    Text("Others")
                  ],
                ),
              ),
              SizedBox(height: 15, width: 10,),

              TextField(decoration: InputDecoration(labelText: "Phone"),
                controller: phoneController,),

              SizedBox(height: 15, width: 10,),

              TextField(decoration: InputDecoration(labelText: "Place"),
                controller: placeController,),

              SizedBox(height: 15, width: 10,),

              TextField(decoration: InputDecoration(labelText: "State"),
                controller: stateController,),

              SizedBox(height: 15, width: 10,),

              TextField(decoration: InputDecoration(labelText: "City"),
                controller: cityController,),

              SizedBox(height: 15, width: 10,),

              TextField(decoration: InputDecoration(labelText: "Email"),
                controller: emailController,),

              SizedBox(height: 15, width: 10,),

              TextField(decoration: InputDecoration(labelText: "Password"),
                controller: passwordController,),

              SizedBox(height: 15, width: 10,),

              TextField(decoration: InputDecoration(labelText: "Confirm Password"),
                controller: conpasswordController,),

              SizedBox(height: 15, width: 10,),

              ElevatedButton(onPressed: () {
                _send_data();
              }, child: Text("Sign In")),

              SizedBox(height: 15, width: 10,),


            ],
          ),
        ),
      ),
    );
  }

  void _send_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/User_signup_post/');
    try {
      final response = await http.post(urls, body: {
        'photo': photo,
        'name': nameController.text,
        'date': dobController.text,
        'gender': gender,
        'phone': phoneController.text,
        'place': placeController.text,
        'city': cityController.text,
        'state': stateController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'confpassword': conpasswordController.text
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: "Registered Successfully..");
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyLoginPage(title: 'LOGIN',)));


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