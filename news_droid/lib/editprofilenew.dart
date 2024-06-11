import 'dart:io';



import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:news_droid/viewpeofilenew.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart ';
import 'package:permission_handler/permission_handler.dart';

import 'homenew.dart';


void main() {
  runApp(const MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(32, 63, 129, 1.0),
        ),
      ),
      home:  edit_userfull(),
    );
  }
}


class edit_userfull extends StatefulWidget {


  edit_userfull({
    Key? key,
  }) : super(key: key);

  @override
  State<edit_userfull> createState() => _LoginState();
}

class _LoginState extends State<edit_userfull> {
  @override

  TextEditingController nameController= TextEditingController();
  TextEditingController dobController= TextEditingController();
  TextEditingController genderController= TextEditingController();
  TextEditingController phoneController= TextEditingController();
  TextEditingController placeController= TextEditingController();
  TextEditingController cityController= TextEditingController();
  TextEditingController stateController= TextEditingController();
  TextEditingController emailController= TextEditingController();

  String gender="";
  String uphoto="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   view_data ();
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.push(context, MaterialPageRoute(builder: (context) =>userProfile_new1 (title: '',),));

        return false;

      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,

        body: Form(
          autovalidateMode: AutovalidateMode.always,

          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                if (_selectedImage != null) ...{
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey[200],
                    child: InkWell(
                      onTap: _checkPermissionAndChooseImage,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                            height: 140,
                            width: 140,
                          ),
                        ),
                      ),
                    ),
                  )
                } else ...{
                  // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
                  InkWell(
                    onTap: _checkPermissionAndChooseImage,
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(uphoto),
                          radius: 80,
                        ),
                        // Image(
                        //
                        //   image: NetworkImage(
                        //       'https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),
                        //   height: 150,
                        //   width: 150,
                        //
                        // ),
                        Text('Select Image', style: TextStyle(color: Colors.cyan))
                      ],
                    ),
                  ),
                },
                // Text(
                //   "",
                //   style: Theme.of(context).textTheme.headlineLarge,
                // ),
                // const SizedBox(height: 10),
                // Text(
                //   "",
                //   style: Theme.of(context).textTheme.bodyMedium,
                // ),


                const SizedBox(height: 40),
                TextFormField(

                  controller: nameController,

                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Name",
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Name";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller:dobController,
                  keyboardType: TextInputType.name,
                  onTap: () async {
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
                      Fluttertoast.showToast(msg: '${formattedDate}');
                      setState(() {
                        dobController.text=sh.getString('date').toString();
                      });
                      // You can perform actions with the selected date here
                    }
                  },

                  decoration: InputDecoration(
                    labelText:"Date of Birth",
                    prefixIcon: const Icon(Icons.calendar_month),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Date of Birth";
                    }

                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(0),
                  child: RadioListTile(
                    title: Text('Male'),
                    value: 'Male',groupValue: gender,onChanged: (value){
                    setState(() {
                      gender=value.toString();
                    });

                  },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(0),
                  child: RadioListTile(
                    title: Text('Female'),
                    value: 'Female',groupValue: gender,onChanged: (value){
                    setState(() {
                      gender=value.toString();
                    });
                  },
                  ),),
                Padding(
                  padding: EdgeInsets.all(0),
                  child: RadioListTile(
                    title: Text('Others'),value: 'Others',groupValue: gender,onChanged: (value){
                    setState(() {
                      gender=value.toString();
                    });
                  },
                  ),
                ),



                const SizedBox(height: 10),
                TextFormField(
                  controller: phoneController,




                  decoration: InputDecoration(
                    labelText: "Phone",
                    prefixIcon: const Icon(Icons.phone),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                ),


                const SizedBox(height: 10),
                TextFormField(
                  controller: emailController,

                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: placeController,

                  decoration: InputDecoration(
                    labelText: "Place",
                    prefixIcon: const Icon(Icons.place),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                TextFormField(
                  controller:cityController,

                  decoration: InputDecoration(
                    labelText: "City",
                    prefixIcon: const Icon(Icons.location_city_rounded),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller:stateController,

                  decoration: InputDecoration(
                    labelText: "State",
                    prefixIcon: const Icon(Icons.location_city),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),


















                const SizedBox(height: 60),
                Column(
                  children: [

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        send_data();();

                      },
                      child: const Text("Update"),
                    ),



                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void send_data() async{

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/User_editprofile_post/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid,
        'photo':photo,
        'gender':gender,
        'name':nameController.text,
        'date':dobController.text,
        'phone':phoneController.text,
        'place':placeController.text,
        'city':cityController.text,
        'state':stateController.text,
        'email':emailController.text,

      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>userProfile_new1(title: 'PROFILE',)));


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

  String id_ = "";





  void view_data() async{



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String img = sh.getString('imageurl').toString();

    final urls = Uri.parse('$url/User_view_profile/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid



      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          String id=jsonDecode(response.body)['id'].toString();
          String name=jsonDecode(response.body)['name'];
          String dob=jsonDecode(response.body)['dob'].toString();
          String genderr=jsonDecode(response.body)['gender'];
          String email=jsonDecode(response.body)['email'];
          String phone=jsonDecode(response.body)['phone'].toString();
          String place=jsonDecode(response.body)['place'];
          String city=jsonDecode(response.body)['city'];
          String state=jsonDecode(response.body)['state'];
          String photoo=img+jsonDecode(response.body)['photos'];

          setState(() {

            id_= id;
            nameController.text=name;
            dobController.text=dob;
            emailController.text=email;
            phoneController.text=phone;
            placeController.text=place;
            cityController.text=city;
            stateController.text=state;
            uphoto=photoo;
            gender=genderr;

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

  String photo= '';
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



