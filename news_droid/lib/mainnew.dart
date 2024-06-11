import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
final _formkey=GlobalKey<FormState>();



class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(32, 63, 129, 1.0),
        ),
      ),
      home:  MyIpPagefull(),
    );
  }
}


class MyIpPagefull extends StatefulWidget {


  MyIpPagefull({
    Key? key,
  }) : super(key: key);

  @override
  State<MyIpPagefull> createState() => _LoginState();
}

class _LoginState extends State<MyIpPagefull> {

  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController ipController = TextEditingController();



  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
         SystemNavigator.pop();
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
                      FadeInUp(duration: Duration(milliseconds: 1000), child: Text("IP Page", style: TextStyle(color: Colors.white, fontSize: 40),)),
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
                                    controller: ipController,
                                    decoration: InputDecoration(
                                        hintText: "Enter the IP Address",
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none
                                    ),
                                    onEditingComplete: () => _focusNodePassword.requestFocus(),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please fill";
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
                            onPressed: () async {
                              if(_formkey.currentState!.validate()){
                                String ip=ipController.text;
                                SharedPreferences sh = await SharedPreferences.getInstance();
                                sh.setString("ip", ipController.text);
                                sh.setString("url", "http://" + ip + ":8000/MyAPP");
                                sh.setString("imageurl", "http://" + ip + ":8000");
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>login_new_full()));
                              }

                            },
                            height: 50,
                            // margin: EdgeInsets.symmetric(horizontal: 50),
                            color: Colors.orange[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),

                            ),
                            child: Center(
                              child: Text("Submit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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

  String? validateip(String value){
    if(value.isEmpty){
      return 'Please enter a valid ip';
    }
    return null;

  }


}