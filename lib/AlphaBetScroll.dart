import 'dart:js';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_log_in/TabBarActivityView.dart';
import 'package:grouped_list/grouped_list.dart';

void main() => runApp(aLPHA());

List _elements = [
  {'name': 'John', 'age' : '21','group': 'Team A'},
  {'name': 'Will', 'age' : '22','group': 'Team B'},
  {'name': 'Beth', 'age' : '22','group': 'Team A'},
  {'name': 'Miranda','age' : '22', 'group': 'Team B'},
  {'name': 'Mike', 'age' : '22','group': 'Team C'},
  {'name': 'Danny','age' : '22', 'group': 'Team C'},
  {'name': 'Mike','age' : '22', 'group': 'Team D'},
  {'name': 'Danny','age' : '22', 'group': 'Team D'},
  {'name': 'Mike','age' : '22', 'group': 'Team E'},
  {'name': 'Danny','age' : '22', 'group': 'Team E'},
  {'name': 'Mike', 'age' : '22','group': 'Team F'},
  {'name': 'Danny','age' : '22', 'group': 'Team F'},
  {'name': 'Mike', 'age' : '22','group': 'Team G'},
  {'name': 'Danny', 'age' : '22','group': 'Team G'},
  {'name': 'Mike','age' : '22', 'group': 'Team H'},
  {'name': 'Danny','age' : '22', 'group': 'Team H'},
  {'name': 'Mike','age' : '22', 'group': 'Team J'},
  {'name': 'Danny','age' : '22', 'group': 'Team J'},
];

class aLPHA extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(

        body: GroupedListView<dynamic, String>(
          elements: _elements,
          groupBy: (element) => element['group'],
          groupComparator: (value1, value2) => value2.compareTo(value1),
          itemComparator: (item1, item2) =>
              item1['name'].compareTo(item2['name']),
          order: GroupedListOrder.DESC,
          useStickyGroupSeparators: true,
          groupSeparatorBuilder: (String value) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          itemBuilder: (c, element) {
            return Card(
              elevation: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                child: ListTile(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Icon(Icons.account_circle) ,
                  title: Text(element['name']+'\n'),
                  subtitle: Text(element['age']+"\n"+"\n"+element['name']),
                  trailing: Icon(Icons.arrow_forward),
                ),

              ),
            );
            },
        ),
      ),
    );
  }

}