import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saloonease/Template/ui/screens/login_screen.dart';
import 'package:saloonease/bookingcart.dart';
import 'package:saloonease/home.dart';
import 'package:saloonease/report.dart';
import 'package:saloonease/viewservices.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyViewCart());
}

class MyViewCart extends StatelessWidget {
  const MyViewCart({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyViewCartPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyViewCartPage extends StatefulWidget {
  const MyViewCartPage({super.key, required this.title});


  final String title;

  @override
  State<MyViewCartPage> createState() => _MyViewCartPageState();
}

class _MyViewCartPageState extends State<MyViewCartPage> {

  _MyViewCartPageState(){
    view_notification();
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
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " Saloon Name: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${salname_[index]}",
                        ),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " Service Name: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${sername_[index]}",
                        ),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " Duration: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${duration_[index]}",
                        ),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " Price: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${price_[index]}",
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () async {
                            _send_data(id_[index]);

                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red, // Set the color to red
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        ]
      ),

          floatingActionButton: FloatingActionButton(onPressed: () async {

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyBookingPageHistory(title: 'Book',)));

          },
            backgroundColor: Colors.lightGreenAccent,
            child: Text("Book Now", textAlign: TextAlign.center,),),

      ),
    );
  }
  List<String> id_ =<String>[];
  List<String> sid_ =<String>[];
  List<String> salname_ =<String>[];
  List<String> sername_ =<String>[];
  List<String> duration_ =<String>[];
  List<String> price_ =<String>[];
  // List<String> date_ =<String>[];
  // List<String> time_ =<String>[];

  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> sid = <String>[];
    List<String> salname = <String>[];
    List<String> sername = <String>[];
    List<String> duration = <String>[];
    List<String> price = <String>[];
    // List<String> date = <String>[];
    // List<String> time = <String>[];
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String pid = sh.getString('sid').toString();
    String lid = sh.getString('lid').toString();
    String img = sh.getString('imageurl').toString();

    final urls = Uri.parse('$url/User_viewcart/');
    try {
      final response = await http.post(urls, body: {
        'pid': pid,
        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          var data = jsonDecode(response.body)['data'];
          for (int i = 0; i < data.length; i++) {
            id.add(data[i]["id"].toString());
            sid.add(data[i]["sid"].toString());
            salname.add(data[i]["salname"]);
            sername.add(data[i]["sername"]);
            duration.add(data[i]['duration'].toString());
            price.add(data[i]["price"].toString());
            // date.add(data[i]["date"].toString());
            // time.add(data[i]["time"].toString());
          }
          setState(() {
            id_ = id;
            sid_ = sid;
            sername_ = sername;
            salname_ = salname;
            duration_ = duration;
            price_ = price;
            // date_ = date;
            // time_ = time;
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


  void _send_data(cid) async{

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    // String aid = sh.getString('cid').toString();

    final urls = Uri.parse('$url/User_cartdel/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid,
        'cid':cid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyViewCartPage(title: '',)));


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
