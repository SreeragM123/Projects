//
// import 'package:clinicpharma/signUpmain.dart';
// import 'package:clinicpharma/signup.dart';
// import 'package:clinicpharma/viewschedule.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:saloonease/Template/ui/screens/login_screen.dart';
import 'package:saloonease/bookinghis.dart';
import 'package:saloonease/changepass.dart';
import 'package:saloonease/feedback.dart';
import 'package:saloonease/login.dart';
import 'package:saloonease/paymenthis.dart';
import 'package:saloonease/report.dart';
import 'package:saloonease/viewcart.dart';
import 'package:saloonease/viewinv.dart';
import 'package:saloonease/viewprofile.dart';
import 'package:saloonease/viewprofiletemp.dart';
import 'package:saloonease/viewreportreply.dart';
import 'package:saloonease/viewsaloontemp.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// import 'Viewbookingdetails.dart';
// import 'changepassword.dart';
// import 'home_drawer.dart';
// import 'profile main.dart';
// import 'sam/login_screen.dart';
// import 'sendcomplaint.dart';
// import 'viewcart.dart';
// import 'viewdoctors.dart';
// import 'viewmedicineorder.dart';
// import 'viewpharmacy.dart';
// import 'viewprescription.dart';
// import 'viewreply.dart';
// import 'viewtestdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(const HomeNew());
}

class HomeNew extends StatelessWidget {
  const HomeNew({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(
            255, 169, 80, 204)),
        useMaterial3: true,
      ),
      home: const HomeNewPage(title: 'Home'),
    );
  }
}

class HomeNewPage extends StatefulWidget {
  const HomeNewPage({super.key, required this.title});

  final String title;

  @override
  State<HomeNewPage> createState() => _HomeNewPageState();
}

class _HomeNewPageState extends State<HomeNewPage> {


  _HomeNewPageState() {
    _send_data();
  }

  // List<String> id_ = <String>[];
  // List<String> name_= <String>[];
  // List<String> department_= <String>[];
  // List<String> gender_= <String>[];
  // List<String> place_= <String>[];
  // List<String> phone_= <String>[];
  // List<String> photo_= <String>[];
  //
  //
  // Future<void> view_notification() async {
  //   List<String> id = <String>[];
  //   List<String> name = <String>[];
  //   List<String> department = <String>[];
  //   List<String> gender = <String>[];
  //   List<String> place = <String>[];
  //   List<String> phone = <String>[];
  //   List<String> photo = <String>[];
  //
  //
  //   try {
  //     SharedPreferences sh = await SharedPreferences.getInstance();
  //     String urls = sh.getString('url').toString();
  //     String url = '$urls/myapp/user_viewdoctors/';
  //
  //     var data = await http.post(Uri.parse(url), body: {
  //
  //
  //     });
  //     var jsondata = json.decode(data.body);
  //     String statuss = jsondata['status'];
  //
  //     var arr = jsondata["data"];
  //
  //     print(arr.length);
  //
  //     for (int i = 0; i < arr.length; i++) {
  //       id.add(arr[i]['id'].toString());
  //       name.add(arr[i]['name']);
  //       department.add(arr[i]['department']);
  //       gender.add(arr[i]['gender']);
  //       place.add(arr[i]['place']);
  //       phone.add(arr[i]['phone']);
  //       photo.add(urls+ arr[i]['photo']);
  //
  //     }
  //
  //     setState(() {
  //       id_ = id;
  //       name_ = name;
  //       department_ = department;
  //       gender_ = gender;
  //       place_ = place;
  //       phone_ = phone;
  //       photo_ =  photo;
  //     });
  //
  //     print(statuss);
  //   } catch (e) {
  //     print("Error ------------------- " + e.toString());
  //     //there is error during converting file image to base64 encoding.
  //   }
  // }








  TextEditingController unameController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async{
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeNewPage(title: "Home")),
        );
        return true; },
      child: Scaffold(
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
        GridView(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 210,
                childAspectRatio: 10/10,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,

            ),
            padding: const EdgeInsets.all(8.0),
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  SizedBox(height: 50.0),
                  InkWell(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => userProfile_new1(title: "Profile",)),
                      );
                    },
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/Home img/user.png"),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(1),
                        child: Text("Profile",style: TextStyle(color: Colors.black87,fontSize: 18)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(15)),
                child:  Column(
                    children: [
                      SizedBox(height: 50.0),
                      InkWell(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyViewSaloonPage(title: 'Saloon',)),);
                        },
                        child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage("assets/Home img/saloon.png")),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: Text("Saloon",style: TextStyle(color: Colors.black87,fontSize: 18)),
                          ),],
                      ),
                      //     // Padding(
                      //     //   padding: EdgeInsets.all(5),
                      //     //   child:  ElevatedButton(
                      //     //     onPressed: () async {
                      //     //
                      //     //       final pref =await SharedPreferences.getInstance();
                      //     //       pref.setString("did", id_[index]);
                      //     //
                      //     //       Navigator.push(
                      //     //         context,
                      //     //         MaterialPageRoute(builder: (context) => ViewSchedule()),
                      //     //       );
                      //     //
                      //     //
                      //     //
                      //     //
                      //     //     },
                      //     //     child: Text("Schedule"),
                      //     //   ),
                      //     // ),
                      //   ],
                      // ),

                    ]
                )
            ),
            Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color:Colors.white60,
                    borderRadius: BorderRadius.circular(15)),
                child:  Column(
                    children: [
                      SizedBox(height: 50.0),
                      InkWell(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyBookingHisPage(title: 'Bookings',)),);
                        },
                        child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage("assets/Home img/booking.png")),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: Text("Booking Details",style: TextStyle(color: Colors.black87,fontSize: 18)),
                          ),],
                      ),
                      //     // Padding(
                      //     //   padding: EdgeInsets.all(5),
                      //     //   child:  ElevatedButton(
                      //     //     onPressed: () async {
                      //     //
                      //     //       final pref =await SharedPreferences.getInstance();
                      //     //       pref.setString("did", id_[index]);
                      //     //
                      //     //       Navigator.push(
                      //     //         context,
                      //     //         MaterialPageRoute(builder: (context) => ViewSchedule()),
                      //     //       );
                      //     //
                      //     //
                      //     //
                      //     //
                      //     //     },
                      //     //     child: Text("Schedule"),
                      //     //   ),
                      //     // ),
                      //   ],
                      // ),

                    ]
                )
            ),
            Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(15)),
                child:  Column(
                    children: [
                      SizedBox(height: 50.0),
                      InkWell(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyViewCartPage(title: "Cart",)),);
                        },
                        child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage("assets/Home img/shopping-cart.png")),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: Text(" Cart",style: TextStyle(color: Colors.black87,fontSize: 18)),
                          ),],
                      ),
                      //     // Padding(
                      //     //   padding: EdgeInsets.all(5),
                      //     //   child:  ElevatedButton(
                      //     //     onPressed: () async {
                      //     //
                      //     //       final pref =await SharedPreferences.getInstance();
                      //     //       pref.setString("did", id_[index]);
                      //     //
                      //     //       Navigator.push(
                      //     //         context,
                      //     //         MaterialPageRoute(builder: (context) => ViewSchedule()),
                      //     //       );
                      //     //
                      //     //
                      //     //
                      //     //
                      //     //     },
                      //     //     child: Text("Schedule"),
                      //     //   ),
                      //     // ),
                      //   ],
                      // ),

                    ]
                )
            ),
            Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(15)),
                child:  Column(
                    children: [
                      SizedBox(height: 50.0),
                      InkWell(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PaymentHisPage(title: "Payment",)),);
                        },
                        child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage("assets/Home img/payment-method.png")),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: Text(" Payment History",style: TextStyle(color: Colors.black87,fontSize: 18)),
                          ),],
                      ),
                      //     // Padding(
                      //     //   padding: EdgeInsets.all(5),
                      //     //   child:  ElevatedButton(
                      //     //     onPressed: () async {
                      //     //
                      //     //       final pref =await SharedPreferences.getInstance();
                      //     //       pref.setString("did", id_[index]);
                      //     //
                      //     //       Navigator.push(
                      //     //         context,
                      //     //         MaterialPageRoute(builder: (context) => ViewSchedule()),
                      //     //       );
                      //     //
                      //     //
                      //     //
                      //     //
                      //     //     },
                      //     //     child: Text("Schedule"),
                      //     //   ),
                      //     // ),
                      //   ],
                      // ),

                    ]
                )
            ),
            Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(15)),
                child:  Column(
                    children: [
                      SizedBox(height: 50.0),
                      InkWell(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyReportReplyPage(title: "Replies",)),);
                        },
                        child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage("assets/Home img/report.png")),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: Text(" Report Replies",style: TextStyle(color: Colors.black87,fontSize: 18)),
                          ),],
                      ),
                      //     // Padding(
                      //     //   padding: EdgeInsets.all(5),
                      //     //   child:  ElevatedButton(
                      //     //     onPressed: () async {
                      //     //
                      //     //       final pref =await SharedPreferences.getInstance();
                      //     //       pref.setString("did", id_[index]);
                      //     //
                      //     //       Navigator.push(
                      //     //         context,
                      //     //         MaterialPageRoute(builder: (context) => ViewSchedule()),
                      //     //       );
                      //     //
                      //     //
                      //     //
                      //     //
                      //     //     },
                      //     //     child: Text("Schedule"),
                      //     //   ),
                      //     // ),
                      //   ],
                      // ),

                    ]
                )
            ),
            // Container(
            //     alignment: Alignment.center,
            //     decoration: BoxDecoration(
            //         color: Colors.white60,
            //         borderRadius: BorderRadius.circular(15)),
            //     child:  Column(
            //         children: [
            //           SizedBox(height: 50.0),
            //           InkWell(
            //             onTap: () async {
            //               Navigator.push(
            //                 context,
            //                 MaterialPageRoute(builder: (context) => MyFeedbackPage(title: "Feedback",)),);
            //             },
            //             child: CircleAvatar(
            //                 radius: 35,
            //                 backgroundColor: Colors.transparent,
            //                 backgroundImage: AssetImage("assets/Home img/feedback.png")),
            //           ),
            //           Column(
            //             children: [
            //               Padding(
            //                 padding: EdgeInsets.all(1),
            //                 child: Text("Feedback",style: TextStyle(color: Colors.black87,fontSize: 18)),
            //               ),],
            //           ),
            //           //     // Padding(
            //           //     //   padding: EdgeInsets.all(5),
            //           //     //   child:  ElevatedButton(
            //           //     //     onPressed: () async {
            //           //     //
            //           //     //       final pref =await SharedPreferences.getInstance();
            //           //     //       pref.setString("did", id_[index]);
            //           //     //
            //           //     //       Navigator.push(
            //           //     //         context,
            //           //     //         MaterialPageRoute(builder: (context) => ViewSchedule()),
            //           //     //       );
            //           //     //
            //           //     //
            //           //     //
            //           //     //
            //           //     //     },
            //           //     //     child: Text("Schedule"),
            //           //     //   ),
            //           //     // ),
            //           //   ],
            //           // ),
            //
            //         ]
            //     )
            // ),
            Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(15)),
                child:  Column(
                    children: [
                      SizedBox(height: 50.0),
                      InkWell(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyChangePassPage(title: "Change Password",)),);
                        },
                        child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage("assets/Home img/reset-password.png")),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: Text("Change Password",style: TextStyle(color: Colors.black87,fontSize: 18)),
                          ),],
                      ),
                      //     // Padding(
                      //     //   padding: EdgeInsets.all(5),
                      //     //   child:  ElevatedButton(
                      //     //     onPressed: () async {
                      //     //
                      //     //       final pref =await SharedPreferences.getInstance();
                      //     //       pref.setString("did", id_[index]);
                      //     //
                      //     //       Navigator.push(
                      //     //         context,
                      //     //         MaterialPageRoute(builder: (context) => ViewSchedule()),
                      //     //       );
                      //     //
                      //     //
                      //     //
                      //     //
                      //     //     },
                      //     //     child: Text("Schedule"),
                      //     //   ),
                      //     // ),
                      //   ],
                      // ),

                    ]
                )
            ),
            Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(15)),
                child:  Column(
                    children: [
                      SizedBox(height: 50.0),
                      InkWell(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen(title:"")),);
                        },
                        child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage("assets/Home img/logout.png")),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: Text("LogOut",style: TextStyle(color: Colors.black87,fontSize: 18)),
                          ),],
                      ),
                      //     // Padding(
                      //     //   padding: EdgeInsets.all(5),
                      //     //   child:  ElevatedButton(
                      //     //     onPressed: () async {
                      //     //
                      //     //       final pref =await SharedPreferences.getInstance();
                      //     //       pref.setString("did", id_[index]);
                      //     //
                      //     //       Navigator.push(
                      //     //         context,
                      //     //         MaterialPageRoute(builder: (context) => ViewSchedule()),
                      //     //       );
                      //     //
                      //     //
                      //     //
                      //     //
                      //     //     },
                      //     //     child: Text("Schedule"),
                      //     //   ),
                      //     // ),
                      //   ],
                      // ),

                    ]
                )
            ),

          ],

           ),
        ]
      ),

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
               DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                ),
                child:
                Column(children: [

                  Text(
                    'SaloonEase',
                    style: TextStyle(fontSize: 20,color: Colors.black),

                  ),
                  CircleAvatar(radius: 20,backgroundImage: NetworkImage(photo_)),
                  Text(name_,style: TextStyle(color: Colors.black)),
                  Text(email_,style: TextStyle(color: Colors.black)),



                ])


                ,
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeNew(),));
                },
              ),
              ListTile(
                leading: Icon(Icons.person_pin),
                title: const Text(' View Profile '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => userProfile_new1(title: "Profile",)));
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.shop),
              //   title: const Text(' View Saloons '),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => ViewSaloonPage(title: "Saloons",),));
              //   },
              // ),
              ListTile(
                leading: Icon(Icons.book_outlined),
                title: const Text(' View Saloons '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyViewSaloonPage(title: "Saloon Details",),));
                },
              ),ListTile(
                leading: Icon(Icons.book_outlined),
                title: const Text(' View Booking Details '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyBookingHisPage(title: "Booking Details",),));
                },
              ),
              ListTile(
                leading: Icon(Icons.book_outlined),
                title: const Text(' View Payment History'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentHisPage(title: "Payment History",),));
                },
              ),ListTile(
                leading: Icon(Icons.book_outlined),
                title: const Text(' View Cart '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyViewCartPage(title: "Cart",),));
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.report),
              //   title: const Text(' Report '),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => MyReportPage(title: "Report",),));
              //   },
              // ),


              ListTile(
                leading: Icon(Icons.replay),
                title: const Text(' View Report Replies '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyReportReplyPage(title: "Replies",),));
                },

              ),

              ListTile(
                leading: Icon(Icons.feedback),
                title: const Text(' Feedback '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyFeedbackPage(title: "Feedback",),));
                },
              ),
              ListTile(
                leading: Icon(Icons.password),
                title: const Text('Change Password '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyChangePassPage(title: "Change Password",),));
                },
              ), ListTile(
                leading: Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(title:""),));
                },
              ),
            ],
          ),
        ),





      ),
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
