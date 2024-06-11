import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AddNewsPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class AddNewsPage extends StatefulWidget {
  const AddNewsPage({super.key, required this.title});



  final String title;

  @override
  State<AddNewsPage> createState() => _AddNewsPageState();
}

class _AddNewsPageState extends State<AddNewsPage> {
  int _counter = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String dropdownValue1 = 'POLITICAL';


  void _incrementCounter() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{return true;},
      child: Scaffold(
        appBar: AppBar(

          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,

          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_selectedImage != null) ...{
                InkWell(
                  child: Image.file(
                    _selectedImage!,
                    height: 200,
                    width: 200,
                  ),
                  radius: 300,
                  onTap: _checkPermissionAndChooseImage,
                  // borderRadius: BorderRadius.all(Radius.circular(200)),
                ),
              } else ...{
                // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
                InkWell(
                  onTap: _checkPermissionAndChooseImage,
                  child: Column(
                    children: [
                      Image(
                        image: NetworkImage(
                            'https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),
                        height: 150,
                        width: 150,
                      ),
                      Text('Select Image', style: TextStyle(color: Colors.cyan))
                    ],
                  ),
                ),
              },
              TextField(decoration: InputDecoration(labelText: "Title"),
                controller: titleController,),

              SizedBox(height: 15, width: 10,),

              TextField(decoration: InputDecoration(labelText: "Description"),
                controller: descController,),

              SizedBox(height: 15, width: 10,),

              TextField(decoration: InputDecoration(labelText: "Place"),
                controller: placeController,),

              SizedBox(height: 15, width: 10,),

              TextField(decoration: InputDecoration(labelText: "City"),
                controller: cityController,),

              SizedBox(height: 15, width: 10,),

              TextField(decoration: InputDecoration(labelText: "State"),
                controller: stateController,),

              SizedBox(height: 15, width: 10,),

              DropdownButton<String>(
                value: dropdownValue1,
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue1 = value!;
                  });
                },
                items: ['POLITICAL','ENTERTAINMENT','BUISNESS','SPORTS'].map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),

              SizedBox(height: 15, width: 10,),

              TextField(
                onTap: () async {
                  // Set an initial date
                  DateTime initialDate = dateController.text.isEmpty
                      ? DateTime.now()
                      : DateTime.parse(dateController.text);

                  // Open a date picker with the initial date
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null) {
                    dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
                  }
                },
                decoration: InputDecoration(labelText: "Date"),
                controller: dateController,),

              SizedBox(height: 15, width: 10,),

              ElevatedButton(onPressed: () {
                _send_data();
              }, child: Text("Add")),

              SizedBox(height: 15, width: 10,),


            ],
          ),
        ),
      ),
    );
  }

  void _send_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/User_addnews_post/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid,
        'date': dateController.text,
        'textfield': titleController.text,
        'textarea' : descController.text,
        'fileField' :photo,
        'textfield2' : placeController.text,
        'textfield3' : cityController.text,
        'textfield4' : stateController.text,
        'category' : dropdownValue1
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeNewPage(title: 'HOME',)));


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

  String photo = '';
  File? uploadimage;
  File? _selectedImage;
  String? _encodedImage;

  Future<void> _chooseAndUploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
        photo = _encodedImage.toString();
      });
    }
  }

  Future<void> _checkPermissionAndChooseImage() async {
    final PermissionStatus status = await Permission.mediaLibrary.request();
    if (status.isGranted) {
      _chooseAndUploadImage();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
            'Please go to app settings and grant permission to choose an image.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

}
