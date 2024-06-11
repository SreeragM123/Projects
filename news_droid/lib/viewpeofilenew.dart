
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'editprofile.dart';
import 'editprofilenew.dart';
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
      title: '',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home:  (title: 'Sent Complaint'),
    );
  }
}


class userProfile_new1 extends StatefulWidget {
  const userProfile_new1({super.key, required this.title});


  final String title;

  @override
  State<userProfile_new1> createState() => _userProfile_new1State();
}
class _userProfile_new1State extends State<userProfile_new1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    send_data();
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






  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.push(context, MaterialPageRoute(builder: (context) =>HomeNewPage (title: '',),));

        return false;

      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: 280,
                width: double.infinity,
                child: Image.network(
                  photo_,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16.0, 240.0, 16.0, 16.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.only(top: 16.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(left: 110.0),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            ' $name_',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                          // Text(
                                          //   '$email',
                                          //   style: Theme.of(context)
                                          //       .textTheme
                                          //       .bodyText1,
                                          // ),
                                          SizedBox(
                                            height: 40,
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      CircleAvatar(
                                        backgroundColor: Colors.blueAccent,
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => edit_userfull(),));
                                            },
                                            icon: Icon(
                                              Icons.edit_outlined,
                                              color: Colors.white,
                                              size: 18,
                                            )
                                        ),
                                      )
                                    ],
                                  )),
                              SizedBox(height: 10.0),
                              Row(
                                children: [

                                ],
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => showDialog(context: context, builder: (context) =>
                              Image.network(photo_),),
                          child: Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image:  DecorationImage(
                                    image: NetworkImage(
                                        photo_),
                                    fit: BoxFit.cover)),
                            margin: EdgeInsets.only(left: 20.0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children:  [
                          ListTile(
                            title: Text("Profile Information"),
                          ),
                          Divider(),
                          ListTile(
                            title: Text("Date of Birth"),
                            subtitle: Text('$dob_'),
                            leading: Icon(Icons.calendar_view_day),
                          ),
                          ListTile(
                            title: Text('Adress'),
                            subtitle: Text( '${place_} \n ${city_} \n ${state_} '),
                            leading: Icon(Icons.location_city),
                          ),


                          ListTile(
                            title: Text("Gender"),
                            subtitle: Text('$gender_'),
                            leading: Icon(Icons.male_sharp),
                          ),
                          ListTile(
                            title: Text('Email'),
                            subtitle: Text(email_),
                            leading: Icon(Icons.mail_outline),
                          ),
                          ListTile(
                            title: Text("Phone"),
                            subtitle: Text(phone_),
                            leading: Icon(Icons.phone),
                          ),


                          SizedBox(
                            height: 10,
                          ),


                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Positioned(
              //   top: 60,
              //   left: 20,
              //   child: MaterialButton(
              //     minWidth: 0.2,
              //     elevation: 0.2,
              //     color: Colors.white,
              //     child: const Icon(Icons.arrow_back_ios_outlined,
              //         color: Colors.indigo),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(30.0),
              //     ),
              //     onPressed: () {
              //
              //       Navigator.push(context, MaterialPageRoute(builder: (context) => HomeNewPage(title: '',),));
              //
              //
              //
              //     },
              //   ),
              // ),

            ],

          ),

        ),

      ),
    );
  }


  void send_data() async{



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

}