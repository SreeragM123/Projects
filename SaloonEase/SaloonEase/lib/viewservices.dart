// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:saloonease/booking.dart';
// import 'package:saloonease/bookingcart.dart';
// import 'package:saloonease/home.dart';
// import 'package:saloonease/viewcart.dart';
// import 'package:saloonease/viewsaloontemp.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(const MyViewServices());
// }
//
// class MyViewServices extends StatelessWidget {
//   const MyViewServices({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyViewServicesPage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyViewServicesPage extends StatefulWidget {
//   const MyViewServicesPage({super.key, required this.title});
//
//
//   final String title;
//
//   @override
//   State<MyViewServicesPage> createState() => _MyViewServicesPageState();
// }
//
// class _MyViewServicesPageState extends State<MyViewServicesPage> {
//   _MyViewServicesPageState(){
//     view_notification();
//   }
//   final ipController=TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: ()async{
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => MyViewSaloonPage(title: "Saloons")),
//         );
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//
//           backgroundColor: Colors.lightBlueAccent,
//
//           title: Text(widget.title),
//         ),
//         body:Stack(
//           children: [
//           Image.asset(
//           "assets/images/vector-3.png",
//           width: 428,
//           height: 1000,
//           fit: BoxFit.cover, // Adjust this to fit your needs
//         ),
//         ListView.builder(
//           itemCount: id_.length,
//           itemBuilder: (context, index) {
//             return Card(
//               elevation: 4,
//               margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Text(
//                     //   "Service Name: ${sername_[index]}",
//                     //   style: TextStyle(fontWeight: FontWeight.bold),
//                     //
//                     // ),
//
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Service Name: ",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             "${sername_[index]}",
//                           ),
//                         ],
//                     ),
//
//                     SizedBox(height: 8),
//
//                     Row(
//
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Description: ",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             "${description_[index]}",
//                           ),
//                         ],
//                     ),
//                     SizedBox(height: 8),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Duration: ",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             "${duration_[index]}",
//                           ),
//                         ],
//                     ),
//
//                     SizedBox(height: 8),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//
//                             "Price: ",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//
//                           ),
//                           Text(
//                             "${price_[index]}",
//                           ),
//                         ],
//                     ),                  SizedBox(height: 16),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () async {
//                               SharedPreferences sh = await SharedPreferences.getInstance();
//                               sh.setString("sid", id_[index]);
//                               sh.setString("amt", price_[index]);
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => MyBookingPage(title: "Book")),
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                               primary: Colors.green,
//                             ),
//                             child: Text("Book",style: TextStyle(color: Colors.black),),
//                           ),
//                         ),
//                         SizedBox(width: 16),
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () async {
//                               SharedPreferences sh = await SharedPreferences.getInstance();
//                               String url = sh.getString('url').toString();
//                               String lid = sh.getString('lid').toString();
//                               String sid = sh.getString('sid').toString();
//
//                               final urls = Uri.parse('$url/User_addcart/');
//                               try {
//                                 final response = await http.post(urls, body: {
//                                   'sid': id_[index],
//                                   'lid': lid,
//                                 });
//                                 if (response.statusCode == 200) {
//                                   String status = jsonDecode(response.body)['status'];
//                                   if (status == 'ok') {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(builder: (context) => MyViewCartPage(title: 'Cart')),
//                                     );
//                                   } else {
//                                     Fluttertoast.showToast(msg: 'Not Found');
//                                   }
//                                 } else {
//                                   Fluttertoast.showToast(msg: 'Network Error');
//                                 }
//                               } catch (e) {
//                                 Fluttertoast.showToast(msg: e.toString());
//                               }
//                             },
//                             style: ElevatedButton.styleFrom(
//                               primary: Colors.blue,
//                             ),
//                             child: Text("Add to Cart",style: TextStyle(color: Colors.black),),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         )
//           ]
//         )
//       ),
//     );
//   }
//   List<String> id_ =<String>[];
//   List<String> sername_ =<String>[];
//   List<String> description_ =<String>[];
//   List<String> duration_ =<String>[];
//   List<String> price_ =<String>[];
//
//   Future<void> view_notification() async {
//     List<String> id = <String>[];
//     List<String> sername = <String>[];
//     List<String> description = <String>[];
//     List<String> duration = <String>[];
//     List<String> price = <String>[];
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String pid = sh.getString('sid').toString();
//     String img = sh.getString('imageurl').toString();
//
//     final urls = Uri.parse('$url/User_viewser/');
//     try {
//       final response = await http.post(urls, body: {
//         'pid': pid,
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           var data = jsonDecode(response.body)['data'];
//           for (int i = 0; i < data.length; i++) {
//             id.add(data[i]["id"].toString());
//             sername.add(data[i]["sername"]);
//             description.add(data[i]["description"]);
//             duration.add(data[i]['duration'].toString());
//             price.add(data[i]["price"].toString());
//           }
//           setState(() {
//             id_ = id;
//             sername_ = sername;
//             description_ = description;
//             duration_ = duration;
//             price_ = price;
//           });
//         } else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       }
//       else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     }
//     catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
// }
//


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saloonease/booking.dart';
import 'package:saloonease/bookingcart.dart';
import 'package:saloonease/home.dart';
import 'package:saloonease/viewcart.dart';
import 'package:saloonease/viewsaloontemp.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyViewServices());
}

class MyViewServices extends StatelessWidget {
  const MyViewServices({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyViewServicesPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyViewServicesPage extends StatefulWidget {
  const MyViewServicesPage({Key? key, required this.title});

  final String title;

  @override
  State<MyViewServicesPage> createState() => _MyViewServicesPageState();
}
List<String> list = <String>[];

class _MyViewServicesPageState extends State<MyViewServicesPage> {
  // late String _selectedCategory;
  List<int> cat_id_ = <int>[];
  List<String> cat_name_ = <String>[];
  String dropdownValue1 ="";
  @override
  void initState() {
    super.initState();
    getdata();
    viewNotification();
  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
        onWillPop: ()async{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeNewPage(title: "Home")),
      );
      return true;
    },

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text(widget.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Select Service Category:         ',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                DropdownButton<String>(
                  value: dropdownValue1,
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue1 = value!;
                      // Filter services based on the selected category
                      // filteredServices = services.where((service) => service.category == value).toList();
                    });
                  },
                  items: cat_name_.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: GestureDetector(
                        onTap: () async{

                            List<String> id = [];
                            List<String> sername = [];
                            List<String> description = [];
                            List<String> duration = [];
                            List<String> price = [];
                            SharedPreferences sh = await SharedPreferences.getInstance();
                            String url = sh.getString('url').toString();
                            String pid = sh.getString('sid').toString();
                            String img = sh.getString('imageurl').toString();

                            final urls = Uri.parse('$url/User_viewserbycat/');
                            try {
                              final response = await http.post(urls, body: {
                                'sid': pid,
                                'cid':cat_id_[ cat_name_.indexOf(dropdownValue1)].toString()
                              });
                              if (response.statusCode == 200) {
                                String status = jsonDecode(response.body)['status'];
                                if (status == 'ok') {
                                  var data = jsonDecode(response.body)['data'];
                                  for (int i = 0; i < data.length; i++) {
                                    id.add(data[i]["id"].toString());
                                    sername.add(data[i]["sername"].toString());
                                    description.add(data[i]["description"].toString());
                                    duration.add(data[i]['duration'].toString());
                                    price.add(data[i]["price"].toString());
                                  }
                                  setState(() {
                                    id_ = id;
                                    sername_ = sername;
                                    description_ = description;
                                    duration_ = duration;
                                    price_ = price;
                                  });
                                } else {
                                  Fluttertoast.showToast(msg: 'Not Found');
                                }
                              } else {
                                Fluttertoast.showToast(msg: 'Network Error');
                              }
                            } catch (e) {
                              Fluttertoast.showToast(msg: e.toString());
                            }


                          print('Selected category: $value');
                        },
                        child: Text(
                          value,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                IconButton(onPressed: ()async{


                    List<String> id = [];
                    List<String> sername = [];
                    List<String> description = [];
                    List<String> duration = [];
                    List<String> price = [];
                    SharedPreferences sh = await SharedPreferences.getInstance();
                    String url = sh.getString('url').toString();
                    String pid = sh.getString('sid').toString();
                    String img = sh.getString('imageurl').toString();

                    final urls = Uri.parse('$url/User_viewserbycat/');
                    try {
                      final response = await http.post(urls, body: {
                        'sid': pid,
                        'cid':cat_id_[ cat_name_.indexOf(dropdownValue1)].toString()
                      });
                      if (response.statusCode == 200) {
                        String status = jsonDecode(response.body)['status'];
                        if (status == 'ok') {
                          var data = jsonDecode(response.body)['data'];
                          for (int i = 0; i < data.length; i++) {
                            id.add(data[i]["id"].toString());
                            sername.add(data[i]["sername"].toString());
                            description.add(data[i]["description"].toString());
                            duration.add(data[i]['duration'].toString());
                            price.add(data[i]["price"].toString());
                          }
                          setState(() {
                            id_ = id;
                            sername_ = sername;
                            description_ = description;
                            duration_ = duration;
                            price_ = price;
                          });
                        } else {
                          Fluttertoast.showToast(msg: 'Not Found');
                        }
                      } else {
                        Fluttertoast.showToast(msg: 'Network Error');
                      }
                    } catch (e) {
                      Fluttertoast.showToast(msg: e.toString());
                    }




                }, icon: Icon(Icons.search)),
              ],

            ),


            // Row(
            //
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text('Select Service Category:         ',
            //       style: TextStyle(
            //         fontSize: 15.0,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.black,
            //       ),),
            //     DropdownButton<String>(
            //       // isExpanded: true,
            //       value: dropdownValue1,
            //       onChanged: (String? value) {
            //
            //         print(dropdownValue1);
            //         print("Hiiii");
            //         setState(() {
            //           dropdownValue1 = value!;
            //         });
            //       },
            //       items: cat_name_.map((String value) {
            //         return DropdownMenuItem(
            //
            //           value: value,
            //           child: Text(value,
            //             style: TextStyle(
            //               fontSize: 15.0,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.black,
            //               // backgroundColor: Colors.brown,
            //             ),),
            //         );
            //       }).toList(),
            //     ),
            //
            //   ],
            // ),

            Expanded(
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/vector-3.png",
                    width: 428,
                    height: 1000,
                    fit: BoxFit.cover,
                  ),
                  ListView.builder(
                    itemCount: id_.length,
                    itemBuilder: (context, index) {
                      // Implement logic to filter services based on the selected category
                      // For example, check if the service belongs to the selected category
                      // If it does, display it, otherwise skip it
                      return Card(
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Service Name: ",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${sername_[index]}",
                                  ),
                                ],
                              ),

                              SizedBox(height: 8),

                              Row(

                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Description: ",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      "${description_[index]}",
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Duration: ",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${duration_[index]}",
                                  ),
                                ],
                              ),

                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(

                                    "Price: ",
                                    style: TextStyle(fontWeight: FontWeight.bold),

                                  ),
                                  Text(
                                    "${price_[index]}",
                                  ),
                                ],
                              ),                  SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        SharedPreferences sh = await SharedPreferences.getInstance();
                                        sh.setString("sid", id_[index]);
                                        sh.setString("amt", price_[index]);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => MyBookingPage(title: "Book")),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                      ),
                                      child: Text("Book",style: TextStyle(color: Colors.black),),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        SharedPreferences sh = await SharedPreferences.getInstance();
                                String url = sh.getString('url').toString();
                                String lid = sh.getString('lid').toString();
                                String sid = sh.getString('sid').toString();

                                final urls = Uri.parse('$url/User_addcart/');
                                try {
                                  final response = await http.post(urls, body: {
                                    'sid': id_[index],
                                    'lid': lid,
                                  });
                                  if (response.statusCode == 200) {
                                    String status = jsonDecode(response.body)['status'];
                                    if (status == 'ok') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => MyViewCartPage(title: 'Cart')),
                                      );
                                    } else {
                                      Fluttertoast.showToast(msg: 'Not Found');
                                    }
                                  } else {
                                    Fluttertoast.showToast(msg: 'Network Error');
                                  }
                                } catch (e) {
                                  Fluttertoast.showToast(msg: e.toString());
                                }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.blue,
                                      ),
                                      child: Text("Add to Cart",style: TextStyle(color: Colors.black),),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> id_ = [];
  List<String> sername_ = [];
  List<String> description_ = [];
  List<String> duration_ = [];
  List<String> price_ = [];

  Future<void> viewNotification() async {
    List<String> id = [];
    List<String> sername = [];
    List<String> description = [];
    List<String> duration = [];
    List<String> price = [];
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String pid = sh.getString('sid').toString();
    String img = sh.getString('imageurl').toString();

    final urls = Uri.parse('$url/User_viewser/');
    try {
      final response = await http.post(urls, body: {
        'pid': pid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          var data = jsonDecode(response.body)['data'];
          for (int i = 0; i < data.length; i++) {
            id.add(data[i]["id"].toString());
            sername.add(data[i]["sername"]);
            description.add(data[i]["description"]);
            duration.add(data[i]['duration'].toString());
            price.add(data[i]["price"].toString());
          }
          setState(() {
            id_ = id;
            sername_ = sername;
            description_ = description;
            duration_ = duration;
            price_ = price;
          });
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
  void getdata() async{
    List<int> cat_id = <int>[];
    List<String> cat_name = <String>[];


    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String sid = sh.getString('sid').toString();
    final urls = Uri.parse('$url/User_viewsercat/');


    var data = await http.post(urls, body: {
      'sid':sid,
    });
    var jsondata = json.decode(data.body);
    String status = jsondata['status'];

    var arr = jsondata["data"];


    for (int i = 0; i < arr.length; i++) {
      cat_id.add(arr[i]['id']);
      cat_name.add(arr[i]['category']);
    }
    setState(() {
      cat_id_ = cat_id;
      cat_name_ = cat_name;
      dropdownValue1=  cat_name_.first;
    });
  }


}

