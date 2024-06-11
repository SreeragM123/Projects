import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_droid/editprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'homenew.dart';

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
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ViewProfilePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ViewProfilePage> createState() => ViewProfilePageState();
}

class ViewProfilePageState extends State<ViewProfilePage> {

  ViewProfilePageState(){
    _send_data();
  }

  String id_ = "";
  String photo_ = "";
  String name_ = "";
  String dob_ = "";
  String gender_ = "";
  String phone_ = "";
  String place_ = "";
  String city_ = "";
  String state_ = "";
  String email_ = "";


  void _send_data() async{



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String img = sh.getString('imageurl').toString();

    final urls = Uri.parse('$url/User_view_profile/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid



      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          String id=jsonDecode(response.body)['id'].toString();
          String name=jsonDecode(response.body)['name'];
          String dob=jsonDecode(response.body)['dob'].toString();
          String gender=jsonDecode(response.body)['gender'];
          String email=jsonDecode(response.body)['email'];
          String phone=jsonDecode(response.body)['phone'].toString();
          String place=jsonDecode(response.body)['place'];
          String city=jsonDecode(response.body)['city'];
          String state=jsonDecode(response.body)['state'];
          String photo=img+jsonDecode(response.body)['photos'];

          setState(() {

            id_= id;
            name_= name;
            dob_= dob;
            gender_= gender;
            email_= email;
            phone_= phone;
            place_= place;
            photo_= photo;
            city_=city;
            state_=state;
          });





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
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeNewPage(title: "HOME",)));

        return false;},
      child: Scaffold(
        appBar: AppBar(

          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,

          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[


                  CircleAvatar(radius: 50,),
                  Image(image: NetworkImage(photo_), height: 200, width: 200,),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Text(name_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(dob_),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(gender_),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(phone_),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(place_),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(city_),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(state_),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(email_),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfilePage(title: "EDIT",)));
                    },
                    child: Text("Edit"),
                  ),


                ]
            )
        ),),
    );
  }
}
