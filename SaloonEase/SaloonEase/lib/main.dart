import 'package:flutter/material.dart';
import 'package:saloonease/Template/ui/screens/login_screen.dart';
import 'package:saloonease/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ipController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),

      ),
      body: Center(

        child: Column(

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
                  sh.setString("url", "http://" + ip + ":8000/MyApp");
                  sh.setString("imageurl", "http://" + ip + ":8000");
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(title: 'Login')));
                },
                child: Text("Submit"))
          ],
        ),
      )
    );
  }
}
