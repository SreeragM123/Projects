import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_droid/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgotpass.dart';
import 'homenew.dart';
import 'logindemo.dart';
import 'main.dart';

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
      home: const MyLoginPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});



  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  int _counter = 0;
  TextEditingController usernameController= TextEditingController();
  TextEditingController passwordController= TextEditingController();

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()async{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyIpPage(title: 'IP',)));
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
              controller: usernameController,),

            SizedBox(height: 15,width: 10,),

            TextField(decoration: InputDecoration(labelText: "Password"),
              controller: passwordController,),

            SizedBox(height: 15,width: 10,),

            ElevatedButton(onPressed: (){
              _send_data();
            }, child: Text("Login")),

            SizedBox(height: 15,width: 10,),

            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MySignupPage(title: 'SIGN UP',)));

            },
                child: Text("Sign UP")),

            SizedBox(height: 15,width: 10,),

            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>login_new_full()));

            }, child: Text("login2")),

            SizedBox(height: 15,width: 10,),

            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MYforgotpass(title: 'SIGN UP',)));

            }, child: Text("Forgot Password"))
          ],
        ),
      ),
    );
  }

  void _send_data() async{

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String img = sh.getString('imageurl').toString();

    final urls = Uri.parse('$url/User_login_post/');
    try {
      final response = await http.post(urls, body: {
        'username':usernameController.text,
        'password':passwordController.text,
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
