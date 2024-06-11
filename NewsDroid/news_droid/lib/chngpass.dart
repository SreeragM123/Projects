import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      home: const ChangePassPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key, required this.title});



  final String title;

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  int _counter = 0;
  TextEditingController oldpasswordController= TextEditingController();
  TextEditingController newpasswordController= TextEditingController();
  TextEditingController confpasswordController= TextEditingController();



  void _incrementCounter() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()async{return true;},
      child: Scaffold(
        appBar: AppBar(

          backgroundColor: Theme.of(context).colorScheme.inversePrimary,

          title: Text(widget.title),
        ),
        body: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(decoration: InputDecoration(labelText: "Current Password"),
              controller: oldpasswordController,),

            SizedBox(height: 15,width: 10,),

            TextField(decoration: InputDecoration(labelText: "New Password"),
              controller: newpasswordController,),

            SizedBox(height: 15,width: 10,),

            TextField(decoration: InputDecoration(labelText: "Confirm Password"),
              controller: confpasswordController,),

            SizedBox(height: 15,width: 10,),

            ElevatedButton(onPressed: (){
              _send_data();
            }, child: Text("OK")),


          ],
        ),
      ),
    );
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
}
