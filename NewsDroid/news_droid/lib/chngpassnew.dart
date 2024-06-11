import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_droid/signup.dart';
import 'package:news_droid/signupnew2.dart';
import 'package:news_droid/ui/main_view.dart';
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
      home:  changepassword_new_full(),
    );
  }
}


class changepassword_new_full extends StatefulWidget {


  changepassword_new_full({
    Key? key,
  }) : super(key: key);

  @override
  State<changepassword_new_full> createState() => _LoginState();
}

class _LoginState extends State<changepassword_new_full> {

  final FocusNode _focusNodePassword = FocusNode();
  TextEditingController oldpasswordController= TextEditingController();
  TextEditingController newpasswordController= TextEditingController();
  TextEditingController confpasswordController= TextEditingController();
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
      body: SingleChildScrollView(
        child: Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 80,),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeInUp(duration: Duration(milliseconds: 1000), child: Text("Add News", style: TextStyle(color: Colors.white, fontSize: 40),)),
                      SizedBox(height: 10,),
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
                                    controller: oldpasswordController ,
                                    decoration: InputDecoration(
                                        hintText: "Old Password",
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none
                                    ),
                                    onEditingComplete: () => _focusNodePassword.requestFocus(),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter Old password.";
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
                                    controller: newpasswordController,
                                    focusNode: _focusNodePassword,
                                    obscureText: _obscurePassword,
                                    // obscureText: true,
                                    decoration: InputDecoration(
                                        hintText: "New Password",
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter new password.";
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
                                    controller: confpasswordController,
                                    obscureText: _obscurePassword,
                                    // obscureText: true,
                                    decoration: InputDecoration(
                                        hintText: "Confirm Password",
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter confirm password.";
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
                            color: Colors.teal[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),

                            ),
                            // decoration: BoxDecoration(
                            // ),
                            child: Center(
                              child: Text("Change", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
    ),
    );
  }


  @override
  void dispose() {

    super.dispose();
  }


  void _send_data() async{

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/User_chngpass_post/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid,
        'textfield':oldpasswordController.text,
        'textfield2':newpasswordController.text,
        'textfield3':confpasswordController.text,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>changepassword_new_full()));
          Navigator.push(context, MaterialPageRoute(builder: (context)=>login_new_full()));


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

}