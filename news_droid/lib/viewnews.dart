import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:news_droid/report.dart';
import 'package:news_droid/reportnew.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ViewNewsPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class ViewNewsPage extends StatefulWidget {
  const ViewNewsPage({super.key, required this.title});



  final String title;

  @override
  State<ViewNewsPage> createState() => ViewNewsPageState();
}

class ViewNewsPageState extends State<ViewNewsPage> {
  ViewNewsPageState(){
    view_notification("");
  }


  void _incrementCounter() {
    setState(() {

    });
  }
  List<String> id_ = <String>[];
  List<String> photos_ = <String>[];
  List<String> title_ = <String>[];
  List<String> date_ = <String>[];
  List<String> description_ = <String>[];
  List<String> place_ = <String>[];
  List<String> city_ = <String>[];
  List<String> state_ = <String>[];
  List<String> category_ = <String>[];


  Future<void> view_notification2() async {
    List<String> id = <String>[];
    List<String> photos = <String>[];
    List<String> title = <String>[];
    List<String> date = <String>[];
    List<String> description = <String>[];
    List<String> place = <String>[];
    List<String> city = <String>[];
    List<String> state = <String>[];
    List<String> category = <String>[];

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String img = sh.getString('imageurl').toString();

    final urls = Uri.parse('$url/User_viewnews_date/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid,
        'date':sh.getString("date").toString(),
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          var data=jsonDecode(response.body)['data'];
          for(int i=0;i<data.length;i++)
          {
            id.add(data[i]["id"].toString());
            title.add(data[i]["title"]);
            description.add(data[i]["description"]);
            photos.add(img+ data[i]['photos']);
            place.add(data[i]["place"]);
            city.add(data[i]["city"]);
            state.add(data[i]["state"]);
            date.add(data[i]["date"]);
            category.add(data[i]["category"]);
          }
          setState(() {
            id_ = id;
            title_=title;
            description_=description;
            photos_=photos;
            place_=place;
            city_=city;
            state_=state;
            date_=date;
            category_=category;

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

  Future<void> view_notification(value) async {
    List<String> id = <String>[];
    List<String> photos = <String>[];
    List<String> title = <String>[];
    List<String> date = <String>[];
    List<String> description = <String>[];
    List<String> place = <String>[];
    List<String> city = <String>[];
    List<String> state = <String>[];
    List<String> category = <String>[];

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String img = sh.getString('imageurl').toString();

    final urls = Uri.parse('$url/User_viewnews/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid,
        'Search':value
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          var data=jsonDecode(response.body)['data'];
          for(int i=0;i<data.length;i++)
            {
              id.add(data[i]["id"].toString());
              title.add(data[i]["title"]);
              description.add(data[i]["description"]);
              photos.add(img+ data[i]['photos']);
              place.add(data[i]["place"]);
              city.add(data[i]["city"]);
              state.add(data[i]["state"]);
              date.add(data[i]["date"]);
              category.add(data[i]["category"]);
            }
          setState(() {
            id_ = id;
            title_=title;
            description_=description;
            photos_=photos;
            place_=place;
            city_=city;
            state_=state;
            date_=date;
            category_=category;

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
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()async{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeNewPage(title: 'HOME',)));
        return false;
        },
      child: Scaffold(
        appBar: AppBar(

          backgroundColor: Theme.of(context).colorScheme.inversePrimary,

          title: Text(widget.title),
          actions: [
            IconButton(
              onPressed: () async {
                // Set an initial date
                DateTime initialDate = DateTime.now();

                // Open a date picker with the initial date
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: initialDate,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );

                // Handle the selected date as needed
                if (pickedDate != null) {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  print('Selected Date: ${formattedDate}');
                  final sh =await SharedPreferences.getInstance();
                  sh.setString("date", formattedDate);
                  view_notification2();

                  Fluttertoast.showToast(msg: '${formattedDate}');
                  // You can perform actions with the selected date here
                }
              },
              splashRadius: 1.0,
              icon: Icon(
                Icons.calendar_month,
                color: Colors.black,
                size: 34.0,
              ),
            ),
          ],
        ),
        body:
        Column(
          children: [
            TextField(
              onChanged: (value)=>view_notification(value.toString()),
              decoration: InputDecoration(labelText: "search"),
             ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: id_.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      onLongPress: () {
                        print("long press" + index.toString());
                      },
                      title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                          Card(
                          child:
                          Row(
                          children: [
                            // CircleAvatar(radius: 10,),
                            // Image(image: NetworkImage(photos_[index]), height: 50, width: 50,),
                            CircleAvatar(radius: 20,backgroundImage:
                             NetworkImage(photos_[index])),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        children: [

                                          Text('Title:'),
                                          Text(title_[index]),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          Text('Date:'),
                                          Text(date_[index]),
                                        ],
                                      ),
                                    ), Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          Text('Description:'),
                                          Text(description_[index]),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          Text('Place:'),
                                          Text(place_[index]),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          Text('City:'),
                                          Text(city_[index]),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          Text('State:'),
                                          Text(state_[index]),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          Text('Category:'),
                                          Text(category_[index]),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () async {

                                    final sh=await SharedPreferences.getInstance();
                                    sh.setString("nid", id_[index]);
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>report_full()));





                                  },
                                  child: Text("Report"),
                                ),
                                ]
                            )

                            ,
                            elevation: 8,
                            margin: EdgeInsets.all(10),
                          ),
                            ],
                          )),
                  );
                },


              ),
            ),
          ],
        ),

      ),
    );
  }

}
