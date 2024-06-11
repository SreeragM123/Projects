import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saloonease/editprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyProfile());
}

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyProfilePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key, required this.title});


  final String title;

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  _MyProfilePageState(){
    _send_data();
  }

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
           Text(name_),
            CircleAvatar(backgroundImage: NetworkImage(photo_),),
            Text(age_),
            Text(gender_),
            Text(phone_),
            Text(place_),
            Text(post_),
            Text(pin_),
            Text(district_),
            Text(state_),
            Text(email_),
            ElevatedButton(
                onPressed: () async {
                  // String ip=ipController.text;
                  // SharedPreferences sh = await SharedPreferences.getInstance();
                  // sh.setString("ip", ipController.text);
                  // sh.setString("url", "http://" + ip + ":8000/User_view_profile");
                  // sh.setString("imageurl", "http://" + ip + ":8000");
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyEditProfPage(title: "Edit Profile", )));
                },
                child: Text("Edit"))
          ],
        ),
      )
    );
  }
  String name_="";
  String age_="";
  String gender_="";
  String phone_="";
  String place_="";
  String post_="";
  String pin_="";
  String district_="";
  String state_="";
  String email_="";
  String photo_="";


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

          String name=jsonDecode(response.body)['name'].toString();
          String age=jsonDecode(response.body)['age'].toString();
          String gender=jsonDecode(response.body)['gender'].toString();
          String phone=jsonDecode(response.body)['phone'].toString();
          String place=jsonDecode(response.body)['place'].toString();
          String post=jsonDecode(response.body)['post'].toString();
          String pin=jsonDecode(response.body)['pin'].toString();
          String district=jsonDecode(response.body)['district'].toString();
          String state=jsonDecode(response.body)['state'].toString();
          String email=jsonDecode(response.body)['email'].toString();
          String photo=img+jsonDecode(response.body)['photo'].toString();

          setState(() {
            name_= name;
            age_= age;
            gender_= gender;
            email_= email;
            phone_= phone;
            place_= place;
            photo_= photo;
            post_=post;
            state_=state;
            pin_=pin;
            district_=district;
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
      print(e);
    }
  }

}
