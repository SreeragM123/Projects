// import 'package:evoting/sendcomplaints.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:news_droid/reportnew.dart';
import 'package:readmore/readmore.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'homenew.dart';


// import 'home.dart';

void main() {
  runApp(const viewnews_less());
}

class viewnews_less extends StatelessWidget {
  const viewnews_less({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(
            255, 148, 129, 182)),
        useMaterial3: true,
      ),
      home: const viewnews_full1(title: ''),
    );
  }
}

class viewnews_full1 extends StatefulWidget {

  const viewnews_full1({super.key, required this.title});

  final String title;

  @override
  State<viewnews_full1> createState() => _viewnews_full1State();
}

class _viewnews_full1State extends State<viewnews_full1> {

  _viewnews_full1State(){
    view_notification("");

  }




  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async{
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeNewPage(title: "",),));

        return true; },      child: Scaffold(

      backgroundColor: Color.fromARGB(255, 228, 213, 231),

      appBar: AppBar(
        actions: [

          SizedBox(
            width: 250,
            child: Container(
              decoration: BoxDecoration(color: Colors.white),

              child: TextField(


          onChanged: (value)=>view_notification(value.toString()),
                decoration: InputDecoration(labelText: "search"),






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

        backgroundColor: Colors.brown,
        foregroundColor: Colors.orange[700],          title: Text(widget.title),
      ),
      body:
      Container(
        

        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage('https://img.freepik.com/free-vector/global-technology-earth-news-bulletin-background_1017-33687.jpg?w=1380&t=st=1700822206~exp=1700822806~hmac=44e2db1e6d0c3abe08384b976ee3fc4da14176e9c63fa771f9b257e8f7fe149d'), fit: BoxFit.cover),
        ),
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

                      Card(

                        elevation: 4.0,
                        shadowColor: Colors.black,
                        color: Color.fromARGB(132, 45, 22, 103),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0), // Rounded corners
                        ),

                        child:
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(

                                children: [

                                  InkWell(
                                    onTap: () => showDialog(context: context, builder: (context) => Image.network(photos_[index]),),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(photos_[index]),
                                      radius: 50,

                                    ),
                                  ),

                                  SizedBox(height: 20,),
                                  SizedBox(width: 20,),
                                ],
                              ),
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(""+title_[index],
                                      textAlign: TextAlign.center,

                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                        color: Colors.white

                                        ,
                                      ),),
                                  ),

                                  Container(
                                    height: 50,
                                    // width: 50,
                                    width: MediaQuery.of(context).size.width-210,
                                    child: ReadMoreText(
                                      "Category   :   "+category_[index]
                                      ,
                                      style: const TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
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


                                  SizedBox(height: 20,),
                                  Container(
                                    height: 50,
                                    // width: 50,
                                    width: MediaQuery.of(context).size.width-210,
                                    child: ReadMoreText(
                                      "Description  :"+description_[index]
                                      ,
                                      style: const TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
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
                                          color: Colors.white,
                                          // fontWeight: FontWeight.bold,
                                        ),

                                      ),
                                      Text(
                                        place_[index],
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.white,
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
                                          color: Colors.white,
                                          // fontWeight: FontWeight.bold,
                                        ),

                                      ),
                                      Text(
                                        city_[index],
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.white,
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
                                          color: Colors.white,
                                          // fontWeight: FontWeight.bold,
                                        ),

                                      ),
                                      Text(
                                        state_[index],
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.white,
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
                                        color: Colors.white,
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


                                  SizedBox(height: 40,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 40,),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,

                                            foregroundColor: Color.fromARGB(
                                                234, 63, 36, 93),
                                          ),
                                          // onPressed: (){
                                          //   if(_formKey.currentState!.validate()){
                                          //     sendata();}
                                          //   },
                                          onPressed: () async{
                                            SharedPreferences sh = await SharedPreferences.getInstance();
                                            sh.setString("nid", id_[index]);
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>report_full()));

                                          },
                                          child: Text('Report')),
                                      SizedBox(width: 50,),

                                    ],
                                  ),





                                ],
                              ),

                            ]
                        ),

                        margin: EdgeInsets.all(10),
                      ),
                    ],
                  )),
            );
          },
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



}