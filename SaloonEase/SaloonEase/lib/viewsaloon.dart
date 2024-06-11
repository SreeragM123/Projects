// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:saloonease/report.dart';
// import 'package:saloonease/viewinv.dart';
// import 'package:saloonease/viewservices.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(const MyViewSaloon());
// }
//
// class MyViewSaloon extends StatelessWidget {
//   const MyViewSaloon({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyViewSaloonPage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyViewSaloonPage extends StatefulWidget {
//   const MyViewSaloonPage({super.key, required this.title});
//
//
//   final String title;
//
//   @override
//   State<MyViewSaloonPage> createState() => _MyViewSaloonPageState();
// }
//
// class _MyViewSaloonPageState extends State<MyViewSaloonPage> {
//
//   _MyViewSaloonPageState(){
//     view_notification("");
//   }
//   final ipController=TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//
//         title: Text(widget.title),
//       ),
//       body:ListView.builder(
//         itemCount: id_.length,
//         itemBuilder: (context, index) {
//           return Card(
//             child: ListTile(
//               title: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Text("Name: "),
//                       Text(name_[index]),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text("Owner Name: "),
//                       Text(ownername_[index]),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text("Phone: "),
//                       Text(phone_[index]),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text("Images: "),
//                       CircleAvatar(backgroundImage: NetworkImage(photo_[index]),)
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text("Place: "),
//                       Text(place_[index]),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text("Post: "),
//                       Text(post_[index]),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text("Pincode: "),
//                       Text(pin_[index]),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text("District: "),
//                       Text(district_[index]),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text("State: "),
//                       Text(state_[index]),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text("Email: "),
//                       Text(email_[index]),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       ElevatedButton(
//                           onPressed: () async {
//                             SharedPreferences sh=await SharedPreferences.getInstance();
//                             sh.setString("sid", id_[index]);
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>MyViewServicesPage(title: "Services",)));
//                           },
//                           child: Text("Services")),
//                       ElevatedButton(
//                           onPressed: () async {
//                             SharedPreferences sh=await SharedPreferences.getInstance();
//                             sh.setString("sid", id_[index]);
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>MyInventoryPage(title: "Inventory",)));
//                           },
//                           child: Text("Inventory")),
//
//                     ],
//                   ),
//
//                 ],
//               ),
//             ),
//           );
//         },
//       )
//     );
//   }
//
//   List<String> id_ =<String>[];
//   List<String> name_ =<String>[];
//   List<String> ownername_ =<String>[];
//   List<String> phone_ =<String>[];
//   List<String> photo_ =<String>[];
//   List<String> place_ =<String>[];
//   List<String> post_ =<String>[];
//   List<String> pin_ =<String>[];
//   List<String> district_ =<String>[];
//   List<String> state_ =<String>[];
//   List<String> email_ =<String>[];
//
//   Future<void> view_notification(value) async {
//     List<String> id = <String>[];
//     List<String> name = <String>[];
//     List<String> ownername = <String>[];
//     List<String> phone = <String>[];
//     List<String> photo = <String>[];
//     List<String> place = <String>[];
//     List<String> post = <String>[];
//     List<String> pin = <String>[];
//     List<String> district = <String>[];
//     List<String> state = <String>[];
//     List<String> email = <String>[];
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String sid = sh.getString('sid').toString();
//     String img = sh.getString('imageurl').toString();
//
//     final urls = Uri.parse('$url/User_viewsaloon/');
//     try {
//       final response = await http.post(urls, body: {
//         'sid': sid,
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           var data = jsonDecode(response.body)['data'];
//           for (int i = 0; i < data.length; i++) {
//             id.add(data[i]["id"].toString());
//             name.add(data[i]["name"]);
//             ownername.add(data[i]["ownername"]);
//             phone.add(data[i]['phone'].toString());
//             photo.add(img + data[i]['image']);
//             place.add(data[i]["place"]);
//             post.add(data[i]["post"]);
//             pin.add(data[i]["pin"]);
//             district.add(data[i]["district"]);
//             state.add(data[i]["state"]);
//             email.add(data[i]["email"]);
//           }
//           setState(() {
//             id_ = id;
//             name_ = name;
//             ownername_ = ownername;
//             phone_ = phone;
//             photo_=photo;
//             place_ = place;
//             post_ = post;
//             pin_ = pin;
//             district_ = district;
//             state_ = state;
//             email_ = email;
//           });
//         } else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       }
//       else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     }
//     catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
// }
