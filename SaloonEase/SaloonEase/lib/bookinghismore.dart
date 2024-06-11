import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saloonease/editprofile.dart';
import 'package:saloonease/report.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const BookingHismore());
}

class BookingHismore extends StatelessWidget {
  const BookingHismore({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyBookingHismore(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyBookingHismore extends StatefulWidget {
  const MyBookingHismore({super.key, required this.title});


  final String title;

  @override
  State<MyBookingHismore> createState() => _MyBookingHismoreState();
}

class _MyBookingHismoreState extends State<MyBookingHismore> {
  _MyBookingHismoreState(){
    view_notification();
  }

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
        ListView.builder(
          itemCount: id_.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Column(
                  children: [
                    // Row(
                    //   children: [
                    //     Text("Name"),
                    //     Text(name_[index]),
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     Text("Service Name"),
                    //     Text(sername_[index]),
                    //   ],
                    // ),
                    SizedBox(height: 8),

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
                        Text(
                          "${description_[index]}",
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
                    ),
                    // Row(
                    //   children: [
                    //     Text("status: "),
                    //     Text(status_[index]),
                    //   ],
                    // ),
                    SizedBox(height: 8),

                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              SharedPreferences sh=await SharedPreferences.getInstance();
                              sh.setString("salid", sid_[index].toString());
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyReportPage(title: "Report",)));
                            },
                            child: Text("Report",style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
              primary: Colors.redAccent,)
                        ),

                    //
                  ],
                ),
              ]
              ),
            ),
            );
          },
        )
        ]
        )
    );
  }
  List<String> id_ =<String>[];
  List<String> sid_ =<String>[];
  List<String> sername_ =<String>[];
  List<String> description_ =<String>[];
  List<String> duration_ =<String>[];
  List<String> price_ =<String>[];

  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> sid = <String>[];
    List<String> sername = <String>[];
    List<String> description = <String>[];
    List<String> duration = <String>[];
    List<String> price = <String>[];
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String pid = sh.getString('bid').toString();
    String img = sh.getString('imageurl').toString();

    final urls = Uri.parse('$url/User_viewbookinghismore/');
    try {
      final response = await http.post(urls, body: {
        'bid': pid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          var data = jsonDecode(response.body)['data'];
          for (int i = 0; i < data.length; i++) {
            id.add(data[i]["id"].toString());
            sid.add(data[i]["sid"].toString());
            sername.add(data[i]["sername"]);
            description.add(data[i]["description"]);
            duration.add(data[i]['duration'].toString());
            price.add(data[i]["price"].toString());
          }
          setState(() {
            id_ = id;
            sid_ = sid;
            sername_ = sername;
            description_ = description;
            duration_ = duration;
            price_ = price;
          });
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

}
