import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saloonease/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyReportReply());
}

class MyReportReply extends StatelessWidget {
  const MyReportReply({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyReportReplyPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyReportReplyPage extends StatefulWidget {
  const MyReportReplyPage({super.key, required this.title});


  final String title;

  @override
  State<MyReportReplyPage> createState() => _MyReportReplyPageState();
}

class _MyReportReplyPageState extends State<MyReportReplyPage> {
  _MyReportReplyPageState(){
    view_notification("");
  }
  final ipController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeNewPage(title: "Home")),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(

          backgroundColor:Colors.lightBlueAccent,

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
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Date: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(date_[index]),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Reported Message: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(reportmsg_[index]),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Reported On: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(reporton_[index]),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Reply Message: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(replymsg_[index]),
                      ],
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            );
          },
        )
          ]
      )
      ),
    );
  }
  List<String> id_ =<String>[];
  List<String> date_=<String>[];
  List<String> reportmsg_=<String>[];
  List<String> reporton_=<String>[];
  List<String> replymsg_=<String>[];

  Future<void> view_notification(value) async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> reportmsg = <String>[];
    List<String> reporton = <String>[];
    List<String> replymsg = <String>[];

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String img = sh.getString('imageurl').toString();

    final urls = Uri.parse('$url/User_viewreportreply/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
        'Search': value
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          var data = jsonDecode(response.body)['data'];
          for (int i = 0; i < data.length; i++) {
            id.add(data[i]["id"].toString());
            date.add(data[i]["reporteddate"].toString());
            reportmsg.add(data[i]["reportmsg"]);
            reporton.add(data[i]['reporton']);
            replymsg.add(data[i]["replymsg"]);
          }
          setState(() {
            id_ = id;
            date_ = date;
            reportmsg_ = reportmsg;
            reporton_ = reporton;
            replymsg_ = replymsg;
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
