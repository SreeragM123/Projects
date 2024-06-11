// import 'package:evoting/sendcomplaints.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:news_droid/reportnew.dart';
import 'package:readmore/readmore.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'editnewsnew.dart';
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
      home: const view_my_news_full(title: ''),
    );
  }
}

class view_my_news_full extends StatefulWidget {

  const view_my_news_full({super.key, required this.title});

  final String title;

  @override
  State<view_my_news_full> createState() => _view_my_news_fullState();
}

class _view_my_news_fullState extends State<view_my_news_full> {

  _view_my_news_fullState(){
    view_notification();

  }




  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async{
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeNewPage(title: "",),));

        return true; },      child: Scaffold(

      backgroundColor: Color.fromARGB(255, 228, 213, 231),

      appBar: AppBar(


        backgroundColor: Colors.orange.shade900,
        foregroundColor: Colors.black87,          title: Text(widget.title),
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
            //   ),),
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
                                                        width: 100,
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
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: Colors.blue,
                                                  child: IconButton(
                                                      onPressed: () async{
                                                        SharedPreferences sh = await SharedPreferences.getInstance();
                                                        sh.setString("mnid", id_[index]);
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>editnews_full()));

                                                      },
                                                      icon: Icon(
                                                        Icons.edit,
                                                        color: Colors.white,
                                                        size: 18,
                                                      )
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 215),
                                                  child: CircleAvatar(
                                                    backgroundColor: Colors.redAccent,
                                                    child: IconButton(
                                                        onPressed: () async {
                                                          final sh=await SharedPreferences.getInstance();
                                                          sh.setString("mnid", id_[index]);
                                                          _send_data();

                                                        },
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color: Colors.white,
                                                          size: 18,
                                                        )
                                                    ),
                                                  ),
                                                )





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
                        )
                    ),
                  );
                },
              ),
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


  Future<void> view_notification() async {
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

    final urls = Uri.parse('$url/User_viewmynews/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid
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
            photos.add(img+data[i]["photos"]);
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


  void _send_data() async{

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/User_delete_news/');
    try {
      final response = await http.post(urls, body: {
        'mnid':sh.getString('mnid')
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>view_my_news_full(title: 'VIEW MY NEWS',)));

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



