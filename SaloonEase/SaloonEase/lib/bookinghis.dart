// import 'dart:convert';
// import 'package:easy_search_bar/easy_search_bar.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:saloonease/bookinghismore.dart';
// import 'package:saloonease/reschedule.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(const MyBookingHis());
// }
//
// class MyBookingHis extends StatelessWidget {
//   const MyBookingHis({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyBookingHisPage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyBookingHisPage extends StatefulWidget {
//   const MyBookingHisPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyBookingHisPage> createState() => _MyBookingHisPageState();
// }
//
// class _MyBookingHisPageState extends State<MyBookingHisPage> {
//
//
//   // DateTime _selectedDate;
//   //
//   // Future<void> _selectDate(BuildContext context) async {
//   //   final DateTime picked = await showDatePicker(
//   //     context: context,
//   //     initialDate: _selectedDate ?? DateTime.now(),
//   //     firstDate: DateTime(2015, 8),
//   //     lastDate: DateTime(2101),
//   //   );
//   //   if (picked != null && picked != _selectedDate)
//   //     setState(() {
//   //       _selectedDate = picked;
//   //     });
//   // }
//   late Razorpay _razorpay;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Initializing Razorpay
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//
//   @override
//   void dispose() {
//     // Disposing Razorpay instance to avoid memory leaks
//     _razorpay.clear();
//     super.dispose();
//   }
//
//   Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
//     // Handle successful payment
//

//
//     print("Payment Successful: ${response.paymentId}");
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     // Handle payment failure
//     print("Error in Payment: ${response.code} - ${response.message}");
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     // Handle external wallet
//     print("External Wallet: ${response.walletName}");
//   }
//
//   Future<void> _openCheckout() async {

//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//         appBar:
//         EasySearchBar(
//             backgroundColor: Colors.lightBlueAccent,
//             title: Text('Booking Details'),
//             onSearch: (value) => setState(() => view_notification(value))
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
//               child: ListTile(
//                 title: Column(
//                   children: [
//                     // Row(
//                     //   children: [
//                     //     Text("Name"),
//                     //     Text(name_[index]),
//                     //   ],
//                     // ),
//                     // Row(
//                     //   children: [
//                     //     Text("Service Name"),
//                     //     Text(sername_[index]),
//                     //   ],
//                     // ),
//                     SizedBox(height: 8),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Saloon Name: ",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         Text(salname_[index]),
//                       ],
//                     ),
//                     SizedBox(height: 8),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Booked On:",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//                         Text(bdate_[index]),
//                       ],
//                     ),
//                     SizedBox(height: 8),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Time: ",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         Text(time_[index]),
//                       ],
//                     ),
//                     SizedBox(height: 8),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Total Amount: ",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         Text(totamount_[index]),
//                       ],
//                     ),

//                     SizedBox(height: 8),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Status: ",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         Text(status_[index]),
//                       ],
//                     ),
//                     SizedBox(height: 8),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         IconButton(
//                           onPressed: () async {

//                         ElevatedButton(
//                           onPressed: () async {

//                             style: TextStyle(color: Colors.black),
//                           ),
//                             style: ElevatedButton.styleFrom(
//                               primary: Colors.blue,)
//
//                         ),
//
//                         ElevatedButton(
//                           onPressed: () async {

//                           child: Text(
//                             "Reschedule",
//                             style: TextStyle(color: Colors.black),
//                           ),
//                             style: ElevatedButton.styleFrom(
//                               primary: Colors.orange,)
//                         ),
//                         if (status_[index] == 'approved') ...{
//                           ElevatedButton(
//                             onPressed: () async {

//                             child: Text(
//                               "PAY",
//                               style: TextStyle(color: Colors.black),
//                             ),
//                             style: ElevatedButton.styleFrom(
//                               primary: Colors.green,
//                             ),
//                           ),
//                         }
//
//                       ],
//                     ),
//
//
//                   ],
//                 ),
//               ),
//             );
//           },
//         )
//     ]
//         )
//     );
//   }
//
//   List<String> id_ = <String>[];
//   List<String> bbid_ = <String>[];
//   List<String> salname_ = <String>[];
//   List<String> totamount_ = <String>[];
//   List<String> bdate_ = <String>[];
//   List<String> time_ = <String>[];
//   List<String> status_ = <String>[];
//   void view_notification(value) async {
//     List<String> id = <String>[];
//     List<String> bbid = <String>[];
//     List<String> salname = <String>[];
//     List<String> totamount = <String>[];
//     List<String> bdate = <String>[];
//     List<String> time = <String>[];
//     List<String> statuss = <String>[];
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String lid = sh.getString('lid').toString();
//     String img = sh.getString('imageurl').toString();
//
//     final urls = Uri.parse('$url/User_viewbookinghis/');
//     try {
//       final response = await http.post(urls, body: {
//         'lid': lid,
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           var data = jsonDecode(response.body)['data'];
//           for (int i = 0; i < data.length; i++) {
//             id.add(data[i]["id"].toString());
//             bbid.add(data[i]["bbid"].toString());
//             salname.add(data[i]["salname"].toString());
//             totamount.add(data[i]["totamount"].toString());
//             bdate.add(data[i]["bdate"].toString());
//             time.add(data[i]["time"].toString());
//             statuss.add(data[i]["status"].toString());
//           }
//           setState(() {
//             id_ = id;
//             bbid_ = bbid;
//             salname_ = salname;
//             totamount_ = totamount;
//             bdate_ = bdate;
//             time_ = time;
//             status_ = statuss;
//           });
//         } else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:saloonease/bookinghismore.dart';
import 'package:saloonease/home.dart';
import 'package:saloonease/reschedule.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyBookingHis());
}

class MyBookingHis extends StatelessWidget {
  const MyBookingHis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyBookingHisPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyBookingHisPage extends StatefulWidget {
  const MyBookingHisPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyBookingHisPage> createState() => _MyBookingHisPageState();
}

class _MyBookingHisPageState extends State<MyBookingHisPage> {
  _MyBookingHisPageState() {
    view_notification("");
  }
  late Razorpay _razorpay;
  late DateTime _startDate = DateTime.now();
  late DateTime _endDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String bbid = sh.getString('bbid').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/paid/');
    try {
      final response = await http.post(urls, body: {
        'bbid': bbid,
        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyBookingHisPage(
                        title: 'LOGIN',
                      )));
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    print("Payment Successful: ${response.paymentId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Error in Payment: ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet: ${response.walletName}");
  }

  Future<void> _openCheckout() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    double sm = double.parse(sh.getString("totamount").toString()) * 100;
    var options = {
      'key': 'rzp_test_HKCAwYtLt0rwQe', // Replace with your Razorpay API key
      'amount': sm, // Amount in paise (e.g. 2000 paise = Rs 20)/
      'name': 'Flutter Razorpay Example',
      'description': 'Payment for the product',
      'prefill': {'contact': '9747360170', 'email': 'tlikhil@gmail.com'},
      'external': {
        'wallets': ['paytm'] // List of external wallets
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }

  TextEditingController ipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeNewPage(title: "Home")),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _selectDate(context, true);
                  },
                  child: Text(
                    'Start Date',
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _selectDate(context, false);
                  },
                  child: Text(
                    'End Date',
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    view_notification1();
                  },
                  icon: Icon(Icons.search)),
            ],
          ),
        ),
        body: Stack(
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
                return Card(
                  child: ListTile(
                    title: Column(
                      children: [
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Saloon Name: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(salname_[index]),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Booked On:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(bdate_[index]),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Time: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(time_[index]),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Amount: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(totamount_[index]),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Status: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(status_[index]),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Token: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(token_[index]),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () async {
                                SharedPreferences sh =
                                    await SharedPreferences.getInstance();
                                String url = sh.getString('url').toString();

                                final urls = Uri.parse('$url/User_bookcancel/');
                                try {
                                  final response = await http.post(
                                    urls,
                                    body: {'id': id_[index]},
                                  );
                                  if (response.statusCode == 200) {
                                    String status =
                                        jsonDecode(response.body)['status'];
                                    if (status == 'ok') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MyBookingHisPage(
                                            title: 'Booking Details',
                                          ),
                                        ),
                                      );
                                    } else {
                                      Fluttertoast.showToast(msg: 'Not Found');
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Network Error');
                                  }
                                } catch (e) {
                                  Fluttertoast.showToast(msg: e.toString());
                                }

//
                              },
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                SharedPreferences sh =
                                    await SharedPreferences.getInstance();
                                sh.setString("bid", id_[index].toString());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyBookingHismore(
                                      title: "Booking Details",
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "More",
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                              ),
                            ),
                            if(status_[index]=='pending')...{
                              ElevatedButton(
                                onPressed: () async {
                                  SharedPreferences sh =
                                  await SharedPreferences.getInstance();
                                  sh.setString("boid", id_[index].toString());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ReschedulePage(
                                            title: "Reschedule",
                                          ),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Reschedule",
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                ),
                              ),
                            },
                            if (status_[index] == 'approved') ...{
                              ElevatedButton(
                                onPressed: () async {
                                  SharedPreferences sh =
                                      await SharedPreferences.getInstance();
                                  sh.setString("totamount",
                                      totamount_[index].toString());
                                  sh.setString("bbid", bbid_[index].toString());

                                  _openCheckout();
                                },
                                child: Text(
                                  "PAY",
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                ),
                              ),
                            }
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
    );
  }

  List<String> id_ = <String>[];
  List<String> bbid_ = <String>[];
  List<String> salname_ = <String>[];
  List<String> totamount_ = <String>[];
  List<String> bdate_ = <String>[];
  List<String> time_ = <String>[];
  List<String> status_ = <String>[];
  List<String> token_ = <String>[];

  Future<void> view_notification(value) async {
    List<String> id = <String>[];
    List<String> bbid = <String>[];
    List<String> salname = <String>[];
    List<String> totamount = <String>[];
    List<String> bdate = <String>[];
    List<String> time = <String>[];
    List<String> statuss = <String>[];
    List<String> token = <String>[];

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferences sh = await SharedPreferences.getInstance();

    String? lid = prefs.getString("lid");
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/User_viewbookinghis/');
    // final urls = Uri.parse('$url/User_viewbookinghis/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          var data = jsonDecode(response.body)['data'];
          for (int i = 0; i < data.length; i++) {
            // Filter data based on the selected date range

            id.add(data[i]["id"].toString());
            bbid.add(data[i]["bbid"].toString());
            salname.add(data[i]["salname"].toString());
            totamount.add(data[i]["totamount"].toString());
            bdate.add(data[i]["bdate"].toString());
            time.add(data[i]["time"].toString());
            statuss.add(data[i]["status"].toString());
            token.add(data[i]["token"].toString());
          }
        }
        setState(() {
          id_ = id;
          bbid_ = bbid;
          salname_ = salname;
          totamount_ = totamount;
          bdate_ = bdate;
          time_ = time;
          status_ = statuss;
          token_ = token;
        });
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> view_notification1() async {
    List<String> id = <String>[];
    List<String> bbid = <String>[];
    List<String> salname = <String>[];
    List<String> totamount = <String>[];
    List<String> bdate = <String>[];
    List<String> time = <String>[];
    List<String> statuss = <String>[];

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferences sh = await SharedPreferences.getInstance();

    String? lid = prefs.getString("lid");
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/User_searchbook/');
    // final url = 'http://example.com';
    // final urls = Uri.parse('$url/User_searchbook/');
    try {
      final response = await http.post(urls, body: {
        'from': _startDate.toString().toString(),
        'to': _endDate.toString().toString(),
        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          var data = jsonDecode(response.body)['data'];
          for (int i = 0; i < data.length; i++) {
            // Filter data based on the selected date range
            DateTime bookingDate = DateTime.parse(data[i]["bdate"]);
            if (bookingDate.isAfter(_startDate) &&
                bookingDate.isBefore(_endDate)) {
              id.add(data[i]["id"].toString());
              bbid.add(data[i]["bbid"].toString());
              salname.add(data[i]["salname"].toString());
              totamount.add(data[i]["totamount"].toString());
              bdate.add(data[i]["bdate"].toString());
              time.add(data[i]["time"].toString());
              statuss.add(data[i]["status"].toString());
            }
          }
          setState(() {
            id_ = id;
            bbid_ = bbid;
            salname_ = salname;
            totamount_ = totamount;
            bdate_ = bdate;
            time_ = time;
            status_ = statuss;
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

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
        view_notification1();
      });
    }
  }
}
