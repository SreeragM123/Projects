import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saloonease/home.dart';
import 'package:saloonease/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyLogin());
}

class MyLogin extends StatelessWidget {
  const MyLogin({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  final usernameController=TextEditingController();
  final passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Username"),
              controller: usernameController,
            ),

            SizedBox(
              height: 15,
              width: 10,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Password"),
              controller: passwordController,
            ),

            SizedBox(
              height: 15,
              width: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  _send_data();
                },
                child: Text("Submit")),

            ElevatedButton(
                onPressed: () async {

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyRegistrationPage(title: 'Register',)));

                },
                child: Text("SignUp"))
          ],
        ),
      )
    );
  }
  void _send_data() async{

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    // String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/User_login_post/');
    try {
      final response = await http.post(urls, body: {
        // 'lid':lid,
        'username':usernameController.text,
        'password':passwordController.text,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          String lid = jsonDecode(response.body)['lid'];
          sh.setString('lid', lid).toString();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeNewPage(title: 'LOGIN',)));


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
