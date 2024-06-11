import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saloonease/bookinghis.dart';
import 'package:saloonease/login.dart';
import 'package:saloonease/viewservices.dart';
import 'package:shared_preferences/shared_preferences.dart';
var _formKey = GlobalKey<FormState>();
void main() {
  runApp(const Reschedule());
}

class Reschedule extends StatelessWidget {
  const Reschedule({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ReschedulePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class ReschedulePage extends StatefulWidget {
  const ReschedulePage({super.key, required this.title});


  final String title;

  @override
  State<ReschedulePage> createState() => _ReschedulePageState();
}

class _ReschedulePageState extends State<ReschedulePage> {
  final dateController=TextEditingController();
  final timeController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor:Colors.lightBlueAccent,

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
      Center(
        child: Form(
          key: _formKey,
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: dateController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF090909),
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date',
                    labelStyle: TextStyle(
                      color: Color(0xFF090909),
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xFF090909),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color:Color(0xFF090909),
                      ),
                    ),
                  ),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Should not be Empty';
      }
      return null;
    },
                  onTap: () async {
                    // Set an initial date
                    DateTime initialDate = dateController.text.isEmpty
                        ? DateTime.now()
                        : DateTime.parse(dateController.text);

                    // Open a date picker with the initial date
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: initialDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(8080),
                    );

                    if (pickedDate != null) {
                      dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
                    }
                  },

                ),
              ),
              // SizedBox(
              //   height: 15,
              //   width: 10,
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextFormField(
              //     controller: timeController,
              //     textAlign: TextAlign.center,
              //     style: const TextStyle(
              //       color: Color(0xFF090909),
              //       fontSize: 13,
              //       fontFamily: 'Poppins',
              //       fontWeight: FontWeight.w400,
              //     ),
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: 'Time',
              //       labelStyle: TextStyle(
              //         color: Color(0xFF090909),
              //         fontSize: 15,
              //         fontFamily: 'Poppins',
              //         fontWeight: FontWeight.w400,
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(10)),
              //         borderSide: BorderSide(
              //           width: 1,
              //           color: Color(0xFF090909),
              //         ),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(10)),
              //         borderSide: BorderSide(
              //           width: 1,
              //           color:Color(0xFF090909),
              //         ),
              //       ),
              //     ),
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return 'Should not be Empty';
              //       }
              //       return null;
              //     },
              //     onTap: () async {
              //       // Set an initial time
              //       TimeOfDay initialTime = timeController.text.isEmpty
              //           ? TimeOfDay.now()
              //           : TimeOfDay.fromDateTime(DateTime.parse(timeController.text));
              //
              //       // Open a time picker with the initial time
              //       TimeOfDay? pickedTime = await showTimePicker(
              //         context: context,
              //         initialTime: initialTime,
              //       );
              //
              //       if (pickedTime != null) {
              //         // Format the picked time and update the text field
              //         timeController.text = "${pickedTime.hour}:${pickedTime.minute}";
              //       }
              //     },
              //
              //   ),
              // ),
              SizedBox(
                height: 15,
                width: 10,
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: SizedBox(
                  width: 200,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate())
                      _send_data();

                      // widget.controller.animateToPage(2,
                      //     duration: const Duration(milliseconds: 500),
                      //     curve: Curves.ease);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFC8D00),
                    ),
                    child: const Text(
                      'Book',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
        ]
      )
    );
  }
  void _send_data() async{

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String bid = sh.getString('boid').toString();

    final urls = Uri.parse('$url/User_reschedule/');
    try {
      final response = await http.post(urls, body: {
        'bid':bid,
        'date':dateController.text,
        'time':"pending",
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyBookingHisPage(title: '',)));


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
