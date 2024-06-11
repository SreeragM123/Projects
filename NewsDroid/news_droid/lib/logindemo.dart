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
import 'mainnew.dart';


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
      home:  login_new_full(),
    );
  }
}


class login_new_full extends StatefulWidget {


  login_new_full({
    Key? key,
  }) : super(key: key);

  @override
  State<login_new_full> createState() => _LoginState();
}

class _LoginState extends State<login_new_full> {

  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final _formkey=GlobalKey<FormState>();


  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyIpPagefull(),));

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
                      FadeInUp(duration: Duration(milliseconds: 1000), child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40),)),
                      SizedBox(height: 10,),
                      FadeInUp(duration: Duration(milliseconds: 1300), child: Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 18),)),
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
                                    controller: _controllerUsername,
                                    decoration: InputDecoration(
                                        hintText: "Email or Phone number",
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none
                                    ),
                                    onEditingComplete: () => _focusNodePassword.requestFocus(),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "Email or Phone number.";
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
                                    controller: _controllerPassword,
                                    focusNode: _focusNodePassword,
                                    obscureText: _obscurePassword,
                                    // obscureText: true,
                                    decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter password.";
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
                              child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          )),
                          // SizedBox(height: 40,),
                          // FadeInUp(duration: Duration(milliseconds: 1500), child: Text("Don't have an account?", style: TextStyle(color: Colors.grey),)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?", style: TextStyle(color: Colors.grey),),
                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => signup_new2ful()));
                              }, child: Text(' Register here')
                              ),



                            ],
                          ), Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("", style: TextStyle(color: Colors.grey),),
                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => forgot_newfull()));
                              }, child: Text('Forgot password? ')
                              ),



                            ],
                          ),


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
    _controllerUsername.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }


  void _send_data() async{

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String img = sh.getString('imageurl').toString();

    final urls = Uri.parse('$url/User_login_post/');
    try {
      final response = await http.post(urls, body: {
        'username':_controllerUsername.text,
        'password':_controllerPassword.text,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        String name = jsonDecode(response.body)['name'];
        String email = jsonDecode(response.body)['email'];
        String lid = jsonDecode(response.body)['lid'].toString();
        String photo=img+jsonDecode(response.body)['photo'];

        if (status=='ok') {
          sh.setString("name", name);
          sh.setString("email", email);
          sh.setString("photo", photo);
          sh.setString("lid", lid);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeNewPage(title: 'HOME',)));
        }else if(status=='bl'){
          Fluttertoast.showToast(msg: 'BLOCKED');
        }
        else {
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