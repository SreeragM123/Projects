import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saloonease/Template/ui/screens/login_screen.dart';
import 'package:saloonease/home.dart';
import 'package:saloonease/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ForgPass());
}

class ForgPass extends StatelessWidget {
  const ForgPass({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ForgPassPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class ForgPassPage extends StatefulWidget {
  const ForgPassPage({super.key, required this.title});


  final String title;

  @override
  State<ForgPassPage> createState() => _ForgPassPageState();
}

class _ForgPassPageState extends State<ForgPassPage> {
  final emailcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.lightBlueAccent,

        title: Text(widget.title),
      ),
      body: Stack(
          children: [
            Image.asset(
              "assets/images/vector-3.png",
              width: 428,
              height: 1000,
              fit: BoxFit.cover, // Adjust this to fit your needs
            ),
            Center(
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: emailcontroller,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF090909),
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Color(0xFF090909),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color(0xFF090909),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 1,
                          color:Color(0xFF090909),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                    width: 10,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: SizedBox(
                      width: 200,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          _send_data();

                          // widget.controller.animateToPage(2,
                          //     duration: const Duration(milliseconds: 500),
                          //     curve: Curves.ease);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFC8D00),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]
      )
    );
  }
  void _send_data() async{

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String img = sh.getString('imageurl').toString();

    final urls = Uri.parse('$url/forget_password_post/');
    try {
      final response = await http.post(urls, body: {
        'em_add':emailcontroller.text,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];

        if (status=='ok') {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(title: '',)));


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
