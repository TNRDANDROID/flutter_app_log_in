import 'dart:html';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_app_log_in/TabBarActivityView.dart';
import 'package:flutter_app_log_in/VillageList.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class FirastTab extends StatefulWidget {
  @override
  _FirastTabState createState() => _FirastTabState();
}

class _FirastTabState extends State<FirastTab> {
  String selectval ="Select Village";
  String dropdownValue = 'Select Village';
  List<VillageList> listModel = [];
  List<String> spinnerItem = [];
  VillageList data;
  String _mySelection;
  List<Map> _myJson = [];
  String value;


  @override
  void initState() {
    callMe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body:Center(child: Container(
      width: 300,
      height: 50,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black,width: 1),
        borderRadius: BorderRadius.circular(12)
      ),
      child : DropdownButtonHideUnderline(child: DropdownButton<String>(
        value: value,
        hint: Text(selectval),style: TextStyle(color: Colors.black),
        itemHeight: 50,
        iconSize: 20,
        icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
        isExpanded: true,
        items: spinnerItem.map(buildMenuItems).toList(),
        onChanged: (value)=> setState(()=>this.value = value),
      )),
    )),
  ) ;

  DropdownMenuItem<String> buildMenuItems(String item) =>DropdownMenuItem(
    value: item,
      child: Text(item,
      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),));

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
    Map valueMap = jsonDecode(resul);
    print("JSONDATA"+valueMap.toString());
    var JSON_DATA;
    JSON_DATA = valueMap['JSON_DATA'];
    for(Map i in JSON_DATA){
      listModel.add(VillageList.fromJson(i));
    }
    for(int i=0; i<listModel.length;i++){
      final data = listModel[i];
      //print(data.pvname_ta);
      spinnerItem.add(data.pvname_ta);
    }

    }
}
