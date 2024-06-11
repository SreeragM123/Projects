import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_droid/viewnews.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
      home: const ReportNewsPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class ReportNewsPage extends StatefulWidget {
  const ReportNewsPage({super.key, required this.title});



  final String title;

  @override
  State<ReportNewsPage> createState() => _ReportNewsPageState();
}

class _ReportNewsPageState extends State<ReportNewsPage> {

  TextEditingController messageController= TextEditingController();



  void _incrementCounter() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()async{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewNewsPage(title: 'VIEW NEWS',)));
        return false;},
      child: Scaffold(
        appBar: AppBar(

          backgroundColor: Theme.of(context).colorScheme.inversePrimary,

          title: Text(widget.title),
        ),
        body: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SizedBox(height: 15,width: 10,),

            TextField(decoration: InputDecoration(labelText: "Report"),
              maxLines: 4,
              controller: messageController,),

            SizedBox(height: 15,width: 10,),


            ElevatedButton(onPressed: (){
              _send_data();
            }, child: Text("Send")),

          ],
        ),
      ),
    );
  }
  void _send_data() async{

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/User_reportnews_post/');
    try {
      final response = await http.post(urls, body: {
        'nid':sh.getString('nid'),
        'lid':lid,
        'textarea':messageController.text,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Fluttertoast.showToast(msg: 'Report send successfully');
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewNewsPage(title: '',)));

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
