import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_droid/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'forgotpass.dart';
import 'homenew.dart';
import 'login.dart';
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
      home:  forgot_newfull(),
    );
  }
}


class forgot_newfull extends StatefulWidget {


  forgot_newfull({
    Key? key,
  }) : super(key: key);

  @override
  State<forgot_newfull> createState() => _LoginState();
}

class _LoginState extends State<forgot_newfull> {

  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
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
                                    controller: usernameController,
                                    decoration: InputDecoration(
                                        hintText: "Enter Valid Email Address",
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none
                                    ),
                                    onEditingComplete: () => _focusNodePassword.requestFocus(),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "Email .";
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
                            child: Center(
                              child: Text("Send", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                            // decoration: BoxDecoration(
                            // ),

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
    _focusNodePassword.dispose();
    usernameController.dispose();
    super.dispose();
  }


  void _send_data() async{

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String img = sh.getString('imageurl').toString();

    final urls = Uri.parse('$url/forgot_pass_post/');
    try {
      final response = await http.post(urls, body: {
        'em_add':usernameController.text,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];

        if (status=='ok') {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyLoginPage(title: '',)));


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