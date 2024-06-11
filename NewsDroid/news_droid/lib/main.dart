import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'logindemo.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyIpPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyIpPage extends StatefulWidget {
  const MyIpPage({super.key, required this.title});

  final String title;

  @override
  State<MyIpPage> createState() => _MyIpPageState();
}

class _MyIpPageState extends State<MyIpPage> {
  int _counter = 0;
  TextEditingController ipController = TextEditingController();

  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{return true;},
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "IpAddress"),
              controller: ipController,
            ),
            SizedBox(
              height: 15,
              width: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  String ip=ipController.text;
                  SharedPreferences sh = await SharedPreferences.getInstance();
                  sh.setString("ip", ipController.text);
                  sh.setString("url", "http://" + ip + ":8000/MyAPP");
                  sh.setString("imageurl", "http://" + ip + ":8000");
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>login_new_full()));
                },
                child: Text("Submit"))
            // const Text(
            //   'You have pushed the button this many times:',
            // ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: _incrementCounter,
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
