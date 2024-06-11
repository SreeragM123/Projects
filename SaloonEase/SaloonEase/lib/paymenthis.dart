import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saloonease/home.dart';
import 'package:saloonease/report.dart';
import 'package:saloonease/viewinv.dart';
import 'package:saloonease/viewservices.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const PaymentHis());
}

class PaymentHis extends StatelessWidget {
  const PaymentHis({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PaymentHisPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class PaymentHisPage extends StatefulWidget {
  const PaymentHisPage({super.key, required this.title});


  final String title;

  @override
  State<PaymentHisPage> createState() => _PaymentHisPageState();
}

class _PaymentHisPageState extends State<PaymentHisPage> {

  _PaymentHisPageState(){
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          date_[index],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Saloon Name: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          salname_[index],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Amount: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          amount_[index],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Booked On: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          bdate_[index],
                        ),
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
  List<String> date_ =<String>[];
  List<String> salname_ =<String>[];
  List<String> amount_ =<String>[];
  List<String> bdate_ =<String>[];

  Future<void> view_notification(value) async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> salname = <String>[];
    List<String> amount = <String>[];
    List<String> bdate = <String>[];

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String img = sh.getString('imageurl').toString();

    final urls = Uri.parse('$url/User_paymenthis/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          var data = jsonDecode(response.body)['data'];
          for (int i = 0; i < data.length; i++) {
            id.add(data[i]["id"].toString());
            date.add(data[i]["date"].toString());
            salname.add(data[i]["salname"].toString());
            amount.add(data[i]['amount'].toString());
            bdate.add(data[i]["bdate"].toString());

          }
          setState(() {
            id_ = id;
            date_ = date;
            salname_ = salname;
            amount_ = amount;
            bdate_=bdate;

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
