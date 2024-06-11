import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saloonease/login.dart';
import 'package:saloonease/viewreportreply.dart';
import 'package:saloonease/viewsaloon.dart';
import 'package:shared_preferences/shared_preferences.dart';
var _formKey = GlobalKey<FormState>();
void main() {
  runApp(const MyReport());
}

class MyReport extends StatelessWidget {
  const MyReport({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyReportPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyReportPage extends StatefulWidget {
  const MyReportPage({super.key, required this.title});


  final String title;

  @override
  State<MyReportPage> createState() => _MyReportPageState();
}

class _MyReportPageState extends State<MyReportPage> {
  final reportController=TextEditingController();

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
                controller: reportController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF090909),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Report Message',
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
    String salid = sh.getString('salid').toString();

    final urls = Uri.parse('$url/User_report_post/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid,
        'salid':salid,
        'textfield':reportController.text,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyReportReplyPage(title: 'Report',)));


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
