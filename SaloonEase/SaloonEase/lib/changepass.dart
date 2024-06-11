import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saloonease/Template/ui/screens/login_screen.dart';
import 'package:saloonease/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
var _formKey = GlobalKey<FormState>();
void main() {
  runApp(const MyChangePass());
}

class MyChangePass extends StatelessWidget {
  const MyChangePass({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyChangePassPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyChangePassPage extends StatefulWidget {
  const MyChangePassPage({super.key, required this.title});


  final String title;

  @override
  State<MyChangePassPage> createState() => _MyChangePassPageState();
}

class _MyChangePassPageState extends State<MyChangePassPage> {
  final currpassController=TextEditingController();
  final newpassController=TextEditingController();
  final conpassController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.lightBlueAccent,

        title: Text(widget.title),
      ),
      body:Stack(
        children: [
        Image.asset(
        "assets/images/vector-3.png",
        width: 428,
        height: 1000,
        fit: BoxFit.cover, // Adjust this to fit your needs
      ),
      Center(
        child: Form(
          key: _formKey,
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: currpassController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF090909),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Current Password',
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
                validator: (value) {
                  if (value!.isEmpty){
                    return 'Should not be Empty';
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 15,
                width: 10,
              ),
              TextFormField(
                controller: newpassController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF090909),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'New Password',
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
                validator: (value) {
                  if (value!.isEmpty){
                    return 'Should not be Empty';
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 15,
                width: 10,
              ),
              TextFormField(
                controller: conpassController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF090909),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password',
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
                validator: (value) {
                  if (value!.isEmpty){
                    return 'Should not be Empty';
                  }

                  return null;
                },
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
                      if (_formKey.currentState!.validate())
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
        ),
      )
        ]
    )
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
        'textfield':currpassController.text,
        'textfield2':newpassController.text,
        'textfield3':conpassController.text,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(title: 'LOGIN',)));


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
