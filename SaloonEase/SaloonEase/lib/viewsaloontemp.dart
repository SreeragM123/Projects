import 'dart:convert';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saloonease/feedback.dart';
import 'package:saloonease/home.dart';
import 'package:saloonease/report.dart';
import 'package:saloonease/viewinv.dart';
import 'package:saloonease/viewservices.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyViewSaloon());
}

class MyViewSaloon extends StatelessWidget {
  const MyViewSaloon({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyViewSaloonPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyViewSaloonPage extends StatefulWidget {
  const MyViewSaloonPage({super.key, required this.title});


  final String title;

  @override
  State<MyViewSaloonPage> createState() => _MyViewSaloonPageState();
}

class _MyViewSaloonPageState extends State<MyViewSaloonPage> {

  _MyViewSaloonPageState(){
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
        appBar:
        EasySearchBar(
            backgroundColor: Colors.lightBlueAccent,
            title: Text('Saloons'),
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: MediaQuery.of(context).size.height * 0.8,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(photo_[index]),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(photo_[index]),
                          radius: 50, // adjust the radius as needed
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " Saloon Name: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${name_[index]}",
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " Owner Name: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${ownername_[index]}",
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " Phone: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${phone_[index]}",
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " Place: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${place_[index]}",
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " Post: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${post_[index]}",
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " Pin: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${pin_[index]}",
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " District: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${district_[index]}",
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " State: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${state_[index]}",
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " Email: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${email_[index]}",
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            SharedPreferences sh =
                            await SharedPreferences.getInstance();
                            sh.setString("sid", id_[index]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyViewServicesPage(title: "Services"),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue, // Change button color here
                          ),
                          child: Text("Services",style: TextStyle(color: Colors.black),),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            SharedPreferences sh =
                            await SharedPreferences.getInstance();
                            sh.setString("sid", id_[index]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyInventoryPage(title: "Inventory"),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green, // Change button color here
                          ),
                          child: Text("Inventory",style: TextStyle(color: Colors.black),),
                        ),
                        IconButton(onPressed: ()async {
                          SharedPreferences sh =
                          await SharedPreferences.getInstance();
                          sh.setString("fid", id_[index]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyFeedbackPage(title: ""),
                            ),
                          );
                        }, icon: Icon(Icons.feedback))
                      ],
                    ),
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
  List<String> name_ =<String>[];
  List<String> ownername_ =<String>[];
  List<String> phone_ =<String>[];
  List<String> photo_ =<String>[];
  List<String> place_ =<String>[];
  List<String> post_ =<String>[];
  List<String> pin_ =<String>[];
  List<String> district_ =<String>[];
  List<String> state_ =<String>[];
  List<String> email_ =<String>[];

  Future<void> view_notification(value) async {
    List<String> id = <String>[];
    List<String> name = <String>[];
    List<String> ownername = <String>[];
    List<String> phone = <String>[];
    List<String> photo = <String>[];
    List<String> place = <String>[];
    List<String> post = <String>[];
    List<String> pin = <String>[];
    List<String> district = <String>[];
    List<String> state = <String>[];
    List<String> email = <String>[];

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String sid = sh.getString('sid').toString();
    String img = sh.getString('imageurl').toString();

    final urls = Uri.parse('$url/User_viewsaloon/');
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
            name.add(data[i]["name"]);
            ownername.add(data[i]["ownername"]);
            phone.add(data[i]['phone'].toString());
            photo.add(img + data[i]['image']);
            place.add(data[i]["place"]);
            post.add(data[i]["post"]);
            pin.add(data[i]["pin"]);
            district.add(data[i]["district"]);
            state.add(data[i]["state"]);
            email.add(data[i]["email"]);
          }
          setState(() {
            id_ = id;
            name_ = name;
            ownername_ = ownername;
            phone_ = phone;
            photo_=photo;
            place_ = place;
            post_ = post;
            pin_ = pin;
            district_ = district;
            state_ = state;
            email_ = email;
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
