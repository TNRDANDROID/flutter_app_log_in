import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_log_in/TabBarActivityView.dart';
import 'package:flutter_aes_ecb_pkcs5_fork/flutter_aes_ecb_pkcs5_fork.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_app_log_in/VillageList.dart';

import 'Post.dart';

void main(){
  runApp(MaterialApp(
    home : MyApp() ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {

  @override
  void initState() {
    //callMe();
    super.initState();
  }

  static final CREATE_POST_URL = 'http://10.163.19.140/rdweb/project/webservices_forms/login_service/login_services.php';
  TextEditingController user_name =TextEditingController();
  TextEditingController user_password =TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map<String,dynamic> map;
  String enc_data;
  static const encryptionChannel = const MethodChannel('enc/dec');
  String decryptedData = '';
  List<VillageList> listModel = [];
  String dropdownValue = 'One';
  List<String> values=[];
  VillageList _villageList;

  List <String> spinnerItems = [
    'One',
    'Two',
    'Three',
    'Four',
    'Five'
  ] ;
  void _showScaffold(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message,
      style: TextStyle(color: Colors.red ),),
    ));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'TutorialKart',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: user_name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: user_password,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            FlatButton(
              onPressed: (){
                //forgot password screen
              },
              textColor: Colors.blue,
              child: Text('Forgot Password'),
            ),
            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text('Login'),
                  onPressed: () {
                    print(user_name.text);
                    print(user_password.text);
                    checkCondtion();
                  },
                )),
            Container(
                child: Row(
                  children: <Widget>[
                    Text('Does not have account?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //signup screen

                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
          ],
        ),
      ),

       );
  }
  void checkCondtion(){
    if(!user_name.text.isEmpty){
      if(!user_password.text.isEmpty){
        callMe();
      }
      else{
        _showScaffold('Please Enter User Password');
      }
    }
    else{
      _showScaffold('Please Enter User Name');

    }

  }

  void gotoNextClass(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }


  Future<http.Response> callMe() async {
    final param = {
      "user_name": "maedemo",
      "data_content":"PRnDGjZjfmtdXpuUNdy0tQGbt82ZMv\/vYLUJvhDws6oB5Dy+W+k8GDR+V+8nq+25ev\/5qbeBXEpU\neoxmuzuKbCWnbjlfsZC6bY5ULdXipbw=\n:MlNOMjJTa0pHRHlPQVhVVQ==\n",
    };
    final response = await http.post(
      "http://10.163.19.140:8080/rdweb/project/webservices_forms/master_services/master_services.php",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },// change with your url
      body: jsonEncode(<String, String>{
        'user_name': "maedemo",
        "data_content":"PRnDGjZjfmtdXpuUNdy0tQGbt82ZMv/vYLUJvhDws6oB5Dy+W+k8GDR+V+8nq+25ev/5qbeBXEpUeoxmuzuKbCWnbjlfsZC6bY5ULdXipbw=:MlNOMjJTa0pHRHlPQVhVVQ==",
      }),
    );

    print('Error!');

    if (response.statusCode == 200) {
      print("OK!");
      print(json.decode(response.body));
      Map mapRes = json.decode(response.body);
      print('Response from server: $mapRes');
      var listRoute;
      setState(() {
        listRoute = mapRes['enc_data'];
      });
      print("Result"+listRoute);



      decryption(listRoute,"ef922c543091668960fee277a4488361");

      _showScaffold('successful login');
    }
    else {
      print('Error!');
    }
    return response;
  }
  String decryption(String plainText, String key_new) {
    final dateList = plainText.split(":");
    final key = encrypt.Key.fromUtf8(fixKey(key_new));
    final iv = encrypt.IV.fromBase64(dateList[1]);

    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));
    final decrypted = encrypter.decrypt(encrypt.Encrypted.from64(dateList[0]), iv: iv);
    print("Final Result: "+decrypted);
    getVillage(decrypted);
    return decrypted;
  }
  String fixKey(String key) {

    if (key.length < 16) {
      int numPad = 16 - key.length;

      for (int i = 0; i < numPad; i++) {
        key += "0"; //0 pad to len 16 bytes
      }

      return key;

    }

    if (key.length > 16) {
      return key.substring(0, 16); //truncate to 16 bytes
    }

    return key;
  }
  void getVillage(String resul){
    Map mapRes = json.decode(resul);
    var status;
    var response;
    var JSON_DATA;

    setState(() {
      status = mapRes['STATUS'];
      response = mapRes['RESPONSE'];
      if(status=="OK"&& response=="OK"){
        JSON_DATA = mapRes['JSON_DATA'];
        gotoNextClass();
      }
    });
    if(JSON_DATA.toString().length>0){
      for(int i=0;i<JSON_DATA.toString().length;i++){
        setState(() {
          for(Map i in JSON_DATA){
            listModel.add(VillageList.fromJson(i));
          }
        });
      }
     //print(""+listModel.toString());

    }
  }

}


