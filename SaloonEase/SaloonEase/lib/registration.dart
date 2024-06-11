import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saloonease/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyRegistration());
}

class MyRegistration extends StatelessWidget {
  const MyRegistration({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyRegistrationPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyRegistrationPage extends StatefulWidget {
  const MyRegistrationPage({super.key, required this.title});


  final String title;

  @override
  State<MyRegistrationPage> createState() => _MyRegistrationPageState();
}

class _MyRegistrationPageState extends State<MyRegistrationPage> {
  final nameController=TextEditingController();
  final ageController=TextEditingController();
  final phoneController=TextEditingController();
  final placeController=TextEditingController();
  final postController=TextEditingController();
  final pinController=TextEditingController();
  final districtController=TextEditingController();
  final stateController=TextEditingController();
  final emailController=TextEditingController();
  final passController=TextEditingController();
  final conpassController=TextEditingController();
  String gender='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

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
            TextField(
              decoration: InputDecoration(labelText: "Name"),
              controller: nameController,
            ),
            SizedBox(
              height: 15,
              width: 10,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Age"),
              controller: ageController,
            ),
            SizedBox(
              height: 15,
              width: 10,
            ),
            RadioListTile(value: "Male", groupValue: gender, onChanged: (value) { setState(() {gender="Male";}); },title: Text("Male"),),
            RadioListTile(value: "Female", groupValue: gender, onChanged: (value) { setState(() {gender="Female";}); },title: Text("Female"),),
            RadioListTile(value: "Other", groupValue: gender, onChanged: (value) { setState(() {gender="Other";}); },title: Text("Other"),),
            TextField(
              decoration: InputDecoration(labelText: "Phone"),
              controller: phoneController,
            ),
            SizedBox(
              height: 15,
              width: 10,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Place"),
              controller: placeController,
            ),
            SizedBox(
              height: 15,
              width: 10,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Post"),
              controller: postController,
            ),
            SizedBox(
              height: 15,
              width: 10,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Pincode"),
              controller: pinController,
            ),
            SizedBox(
              height: 15,
              width: 10,
            ),
            TextField(
              decoration: InputDecoration(labelText: "District"),
              controller: districtController,
            ),
            SizedBox(
              height: 15,
              width: 10,
            ),
            TextField(
              decoration: InputDecoration(labelText: "State"),
              controller: stateController,
            ),
            SizedBox(
              height: 15,
              width: 10,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Email"),
              controller: emailController,
            ),
            SizedBox(
              height: 15,
              width: 10,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Password"),
              controller: passController,
            ),
            SizedBox(
              height: 15,
              width: 10,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Confirm Password"),
              controller: conpassController,
            ),
            SizedBox(
              height: 15,
              width: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  _send_data();
                },
                child: Text("Submit"))
          ],
        ),
      )
    );
  }
  void _send_data() async{

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/User_signup_post/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid,
        'name':nameController.text,
        'age':ageController.text,
        'gender':gender,
        'photo' :photo,
        'phone':phoneController.text,
        'place':placeController.text,
        'post':postController.text,
        'pin':pinController.text,
        'district':districtController.text,
        'state':stateController.text,
        'email':emailController.text,
        'password':passController.text,
        'conpassword':conpassController.text,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyLoginPage(title: 'LOGIN',)));


        }else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }
  String photo = '';
  File? uploadimage;
  File ?_selectedImage;
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
