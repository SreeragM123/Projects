import 'dart:convert';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
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
      home:  signup_new2ful(),
    );
  }
}


class signup_new2ful extends StatefulWidget {


  signup_new2ful({
    Key? key,
  }) : super(key: key);

  @override
  State<signup_new2ful> createState() => _LoginState();
}

class _LoginState extends State<signup_new2ful> {

  // final FocusNode _focusNodePassword = FocusNode();
  // final TextEditingController _controllerUsername = TextEditingController();
  // final TextEditingController _controllerPassword = TextEditingController();
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

  String gender="Male";


  final _formkey=GlobalKey<FormState>();


  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => login_new_full(),));

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
                    FadeInUp(duration: Duration(milliseconds: 1000), child: Text("Signup", style: TextStyle(color: Colors.white, fontSize: 40),)),
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
                                  controller: nameController,
                                  decoration: InputDecoration(
                                      hintText: "Name",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter your Name.";
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
                                  onTap: () async {
                                    // Set an initial date
                                    DateTime initialDate = dobController.text.isEmpty
                                        ? DateTime.now()
                                        : DateTime.parse(dobController.text);

                                    // Open a date picker with the initial date
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: initialDate,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                    );

                                    if (pickedDate != null) {
                                      dobController.text = "${pickedDate.toLocal()}".split(' ')[0];
                                    }
                                  },

                                  keyboardType: TextInputType.datetime,
                                  controller: dobController,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "YYYY-MM-DD",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter your date of birth  .";
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
                                  keyboardType: TextInputType.phone,
                                  controller: phoneController,
                                  decoration: InputDecoration(
                                      hintText: "Phone",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter your phone number .";
                                    }

                                    return null;
                                  },
                                ),
                              ),





                              SizedBox(height: 15, width: 10,),

                              Padding(
                                padding: EdgeInsets.all(7),
                                child: Row(
                                  children: [
                                    Text(" "),
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
                                    Text("Others"),

                                  ],
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
                                      return "Enter your place.";
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
                                      return "Enter your city.";
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
                                      return "Enter your state.";
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
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "Email",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter your email.";
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
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: passwordController,
                                  obscureText: _obscurePassword,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter your password.";
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
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: conpasswordController,
                                  obscureText: _obscurePassword,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "Confirm Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter your password.";
                                    }

                                    return null;
                                  },
                                ),
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
                            child: Text("Signup", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
          Navigator.push(context, MaterialPageRoute(builder: (context)=>login_new_full()));


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

  String? validateUsername(String value){
    if(value.isEmpty){
      return 'Please enter a User Name';
    }
    return null;

  }
  String? validatePassword(String value){
    if(value.isEmpty){
      return 'Please enter a Password';
    }
    return null;

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