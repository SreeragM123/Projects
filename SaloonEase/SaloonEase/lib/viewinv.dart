import 'dart:convert';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saloonease/viewsaloontemp.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyInventory());
}

class MyInventory extends StatelessWidget {
  const MyInventory({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyInventoryPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyInventoryPage extends StatefulWidget {
  const MyInventoryPage({super.key, required this.title});


  final String title;

  @override
  State<MyInventoryPage> createState() => _MyInventoryPageState();
}

class _MyInventoryPageState extends State<MyInventoryPage> {
  _MyInventoryPageState(){
    view_notification("");
  }
  final ipController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyViewSaloonPage(title: "Home")),
        );
        return false;
      },
      child: Scaffold(
          appBar: EasySearchBar(
              backgroundColor: Colors.lightBlueAccent,
              title: Text('Inventory'),
              onSearch: (value) => setState(() => view_notification(value))
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
                leading: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(photos_[index]),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Product Name: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${productname_[index]}",
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          "Manufacture Date: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${mandate_[index]}",
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
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Instock: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${instock_[index]}",
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
  List<String> productname_ =<String>[];
  List<String> description_ =<String>[];
  List<String> mandate_ =<String>[];
  List<String> photos_ =<String>[];
  List<String> price_ =<String>[];
  List<String> instock_ =<String>[];

  Future<void> view_notification(value) async {
    List<String> id = <String>[];
    List<String> productname = <String>[];
    List<String> description = <String>[];
    List<String> mandate = <String>[];
    List<String> photos = <String>[];
    List<String> price = <String>[];
    List<String> instock = <String>[];

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String sid = sh.getString('sid').toString();
    String img = sh.getString('imageurl').toString();

    final urls = Uri.parse('$url/User_viewinv/');
    try {
      final response = await http.post(urls, body: {
        'sid': sid,
        'search': value,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          var data = jsonDecode(response.body)['data'];
          for (int i = 0; i < data.length; i++) {
            id.add(data[i]["id"].toString());
            productname.add(data[i]["productname"]);
            description.add(data[i]["description"]);
            photos.add(img + data[i]['photos']);
            mandate.add(data[i]["mandate"].toString());
            price.add(data[i]["price"].toString());
            instock.add(data[i]["instock"]);
          }
          setState(() {
            id_ = id;
            productname_ = productname;
            description_ = description;
            photos_ = photos;
            mandate_ = mandate;
            price_ = price;
            instock_ = instock;
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
