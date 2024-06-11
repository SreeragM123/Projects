import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:news_droid/reportnew.dart';
import 'package:news_droid/view_my_news_new.dart';
import 'package:news_droid/viewmynews.dart';
import 'package:news_droid/viewnews.dart';
import 'package:news_droid/viewnewsnew.dart';
import 'package:news_droid/viewpeofilenew.dart';
import 'package:news_droid/viewprofile.dart';
import 'package:readmore/readmore.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addnews.dart';
import 'addnewsnew.dart';
import 'chngpass.dart';
import 'chngpassnew.dart';
import 'login.dart';
import 'logindemo.dart';
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

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
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
  String uname_="";
  String email_="";
  String uphoto_="";


  _HomeNewPageState()
  {
    a();
    view_notification("");
  }

  a() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String name = sh.getString('name').toString();
    String email = sh.getString('email').toString();
    String photo = sh.getString('photo').toString();


    setState(() {
      uname_=name;
      email_=email;
      uphoto_=photo;

    });


  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async{ return false; },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange.shade900,

          title: Text(widget.title),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 6,bottom: 6),
              child: SizedBox(

                width: 270,
                child: Container(
                  decoration: BoxDecoration(color:  Colors.orange.shade900),

                  child: TextField(
                    onChanged: (value)=>view_notification(value.toString()),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search',

                    ),
                  ),
                ),
              ),
            ),
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
        Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage('https://img.freepik.com/free-vector/global-technology-earth-news-bulletin-background_1017-33687.jpg?w=1380&t=st=1700822206~exp=1700822806~hmac=44e2db1e6d0c3abe08384b976ee3fc4da14176e9c63fa771f9b257e8f7fe149d'), fit: BoxFit.cover),
                ),
                child: Column(
                  children: [
                    // TextField(
                    //   onChanged: (value)=>view_notification(value.toString()),
                    //
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    //     filled: true,
                    //     fillColor: Colors.white,
                    //     hintText: 'Search',
                    //
                    //   ),
                    // ),
                    Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        // padding: EdgeInsets.all(5.0),
                        // shrinkWrap: true,
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

                                    InkWell(
                                      onTap: () => showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(50))
                                      ),
                                      height: 500,
                                      width: 500,
                                      // color: Colors.white,
                                      child:   Padding(
                                        padding: const EdgeInsets.only(top: 40,left: 10,right: 10),
                                        child: ReadMoreText("Description  :"+description_[index]
                                          ,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black87,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                          trimLines: 2,
                                          colorClickableText: Colors.blue,
                                          trimMode: TrimMode.Line,
                                          trimCollapsedText: 'Show more',
                                          trimExpandedText: 'Show less',
                                          moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                                      child: Card(
                                        elevation: 4.0,
                                        shadowColor: Colors.black,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12.0), // Rounded corners
                                        ),
                                        child:
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.all(5),
                                                      child: Text(""+title_[index],
                                                        textAlign: TextAlign.center,

                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 20.0,
                                                          color: Colors.black

                                                          ,
                                                        ),),
                                                    ),
                                                    SizedBox(height: 10,),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width-210,
                                                      child:
                                                      ReadMoreText(
                                                        "Category   :   "+category_[index]
                                                        ,
                                                        style: const TextStyle(
                                                          fontSize: 13.0,
                                                          color: Colors.black87,
                                                          // fontWeight: FontWeight.bold,
                                                        ),
                                                        trimLines: 2,
                                                        colorClickableText: Colors.blue,
                                                        trimMode: TrimMode.Line,
                                                        trimCollapsedText: 'Show more',
                                                        trimExpandedText: 'Show less',
                                                        moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.blue),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10,),

                                                    Container(
                                                        width: MediaQuery.of(context).size.width-84,
                                                      child:
                                                          InkWell(
                                                            onTap: () => showDialog(context: context, builder: (context) =>
                                                                Image.network(photos_[index]),),

                                                            child: Image(
                                                                image: NetworkImage(

                                                                    photos_[index]
                                                                )
                                                            )
                                                          )
                                                    ),
                                                    SizedBox(height: 10,),

                                                    Container(
                                                      // height: 50,
                                                      // width: 50,
                                                      width: MediaQuery.of(context).size.width-210,
                                                      child:
                                                      ReadMoreText(
                                                        "Description  :"+description_[index]
                                                        ,
                                                        style: const TextStyle(
                                                          fontSize: 13.0,
                                                          color: Colors.black87,
                                                          // fontWeight: FontWeight.bold,
                                                        ),
                                                        trimLines: 2,
                                                        colorClickableText: Colors.blue,
                                                        trimMode: TrimMode.Line,
                                                        trimCollapsedText: 'Show more',
                                                        trimExpandedText: 'Show less',
                                                        moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.blue),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text('Place: ',
                                                          style: const TextStyle(
                                                            fontSize: 13.0,
                                                            color: Colors.black87,
                                                            // fontWeight: FontWeight.bold,
                                                          ),

                                                        ),
                                                        Text(
                                                          place_[index],
                                                          style: const TextStyle(
                                                            fontSize: 13.0,
                                                            color: Colors.black87,
                                                            // fontWeight: FontWeight.bold,
                                                          ),

                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text('City: ',
                                                          style: const TextStyle(
                                                            fontSize: 13.0,
                                                            color: Colors.black87,
                                                            // fontWeight: FontWeight.bold,
                                                          ),

                                                        ),
                                                        Text(
                                                          city_[index],
                                                          style: const TextStyle(
                                                            fontSize: 13.0,
                                                            color: Colors.black87,
                                                            // fontWeight: FontWeight.bold,
                                                          ),

                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text('State: ',
                                                          style: const TextStyle(
                                                            fontSize: 13.0,
                                                            color: Colors.black87,
                                                            // fontWeight: FontWeight.bold,
                                                          ),

                                                        ),
                                                        Text(
                                                          state_[index],
                                                          style: const TextStyle(
                                                            fontSize: 13.0,
                                                            color: Colors.black87,
                                                            // fontWeight: FontWeight.bold,
                                                          ),

                                                        ),
                                                      ],
                                                    ),

                                                    Container(
                                                      height: 50,
                                                      // width: 50,
                                                      width: MediaQuery.of(context).size.width-210,
                                                      child: ReadMoreText(
                                                        "Date   :   "+date_[index]
                                                        ,
                                                        style: const TextStyle(
                                                          fontSize: 13.0,
                                                          color: Colors.black87,
                                                          // fontWeight: FontWeight.bold,
                                                        ),
                                                        trimLines: 2,
                                                        colorClickableText: Colors.blue,
                                                        trimMode: TrimMode.Line,
                                                        trimCollapsedText: 'Show more',
                                                        trimExpandedText: 'Show less',
                                                        moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.blue),
                                                      ),
                                                    ),


                                                    SizedBox(height: 10,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                              backgroundColor: Colors.orange.shade900,
                                                              foregroundColor: Color.fromARGB(
                                                                  234, 63, 36, 93),
                                                            ),
                                                            onPressed: () async{
                                                              SharedPreferences sh = await SharedPreferences.getInstance();
                                                              sh.setString("nid", id_[index]);
                                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>report_full()));

                                                            },
                                                            child: Text('Report',style: TextStyle(color: Colors.black87),)),
                                                      ],
                                                    ),





                                                  ],
                                                ),

                                              ]
                                          ),
                                        ),

                                        margin: EdgeInsets.all(10),
                                      ),
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
            

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
               DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.orange.shade900,
                ),
                child:
                Column(children: [

                  Text(
                    'NewsDroid',
                    style: TextStyle(fontSize: 20,color: Colors.white),

                  ),
                  CircleAvatar(radius: 29,backgroundImage: NetworkImage(uphoto_)),
                  Text(uname_,style: TextStyle(color: Colors.white)),
                  Text(email_,style: TextStyle(color: Colors.white)),



                ])


                ,
              ),
              ListTile(
                leading: Icon(
                  color: Colors.orange.shade900,
                    Icons.home,
                ),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeNewPage(title: 'HOME',),));
                },
              ),
              ListTile(
                leading: Icon(
                    color: Colors.orange.shade900,
                    Icons.person_pin),
                title: const Text(' View Profile '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => userProfile_new1(title: 'PROFILE',),));
                },
              ),
              ListTile(
                leading: Icon(
                    color: Colors.orange.shade900,
                    Icons.add),
                title: const Text(' Add News '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => addnews_full(),));
                },
              ),
              ListTile(
                leading: Icon(
                    color: Colors.orange.shade900,

                    Icons.newspaper),
                title: const Text(' View My News '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => view_my_news_full(title: 'MY NEWS',),));
                },
              ),
              ListTile(
                leading: Icon(
                    color: Colors.orange.shade900,
                    Icons.password_outlined),
                title: const Text(' Change Password '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => changepassword_new_full(),));
                },
              ),
              ListTile(
                leading: Icon(
                    color: Colors.orange.shade900,
                    Icons.logout),
                title: const Text(' Logout '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => login_new_full(),));
                },
              ),
            ],
          ),
        ),
      ),
    );
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
            title.add(data[i]["title"].toString());
            description.add(data[i]["description"].toString());
            photos.add(img+ data[i]['photos'].toString());
            place.add(data[i]["place"].toString());
            city.add(data[i]["city"].toString());
            state.add(data[i]["state"].toString());
            date.add(data[i]["date"].toString());
            category.add(data[i]["category"].toString());
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
            place.add(data[i]["place"].toString());
            city.add(data[i]["city"]);
            state.add(data[i]["state"]);
            date.add(data[i]["date"].toString());
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

}
