import 'dart:convert';
import 'package:cat_login/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialGetSaved();
  }

  void initialGetSaved() async {
    sharedPreferences = await SharedPreferences.getInstance();

    Map<String, dynamic> jsondatais =
        jsonDecode(sharedPreferences.getString('userdata')!);
    var user = User.fromJson(jsondatais);
    if (jsondatais.isNotEmpty) {
      print(user.name);
      print(user.email);
      _name.value = TextEditingValue(text: user.name);
      _email.value = TextEditingValue(text: user.email);
      _phone.value = TextEditingValue(text: user.phone);
    }
  }

  void storeUserData() {
    User user1 = new User(_name.text, _email.text, _phone.text);
    String user = jsonEncode(user1);
    print(user);
    sharedPreferences.setString('userdata', user);
  }

  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save DataModel Data JSON'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Full Form',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 50,
                  child: TextField(
                    controller: _name,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Enter name'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 50,
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Enter Email'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 50,
                  child: TextField(
                    controller: _phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Enter Phone'),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    storeUserData();
                  },
                  child: Text('SAVE')),
              ElevatedButton(
                  onPressed: () {
                    _name.value = TextEditingValue(text: '');
                    _email.value = TextEditingValue(text: '');
                    _phone.value = TextEditingValue(text: '');
                    sharedPreferences.remove('userdata');
                  },
                  child: Text('SUBMIT'))
            ],
          ),
        ),
      ),
    );
  }
}
