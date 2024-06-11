import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_droid/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homenew.dart';
import 'login.dart';
import 'logindemo.dart';
import 'main.dart';

void main() {
  runApp(const forgotpass());
}

class forgotpass extends StatelessWidget {
  const forgotpass({super.key});

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
      home: const MYforgotpass(title: 'Flutter Demo Home Page'),
    );
  }
}

class MYforgotpass extends StatefulWidget {
  const MYforgotpass({super.key, required this.title});



  final String title;

  @override
  State<MYforgotpass> createState() => _MYforgotpassState();
}

class _MYforgotpassState extends State<MYforgotpass> {
  int _counter = 0;
  TextEditingController usernameController= TextEditingController();

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()async{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>login_new_full()));
        return false;},
      child: Scaffold(
        appBar: AppBar(

          backgroundColor: Theme.of(context).colorScheme.inversePrimary,

          title: Text(widget.title),
        ),
        body: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(decoration: InputDecoration(labelText: "Username"),
              controller: usernameController,
            ),

            SizedBox(height: 15,width: 10,),

            ElevatedButton(onPressed: (){
              _send_data();
            }, child: Text("SEND")),

            SizedBox(height: 15,width: 10,),

            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyLoginPage(title: '',)));

            }, child: Text("LOGIN")),

          ],
        ),
      ),
    );
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
}
