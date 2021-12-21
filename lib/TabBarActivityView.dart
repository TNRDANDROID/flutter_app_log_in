import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_log_in/FirstTab.dart';
import 'package:flutter_app_log_in/SeconTab.dart';
import 'package:flutter_app_log_in/ThirdTab.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.android), text: "Tab 1",),
              Tab(icon: Icon(Icons.mouse), text: "Tab 2"),
              Tab(icon: Icon(Icons.insert_photo), text: "Tab 3"),
              Tab(icon: Icon(Icons.phone_iphone), text: "Tab 4"),
            ],
          ),
          title: Text('TutorialKart - TabBar & TabBarView'),
        ),
        body: TabBarView(
          children: [
            Center(

                child: DataTable(
                  columns: [
                    DataColumn(label: Text('RollNo')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Class')),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Arya')),
                      DataCell(Text('6')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('12')),
                      DataCell(Text('John')),
                      DataCell(Text('9')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('42')),
                      DataCell(Text('Tony')),
                      DataCell(Text('8')),
                    ]),
                  ],
                ),
            ),
            FirastTab(),
            SecondTab(),
            ThirdTab(),
          ],
        ),
      ),
    );
  }
}