import 'package:flutter/material.dart';
import 'package:expandable_group/expandable_group_widget.dart';

// used https://pub.dev/packages/expandable_group/example

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("test"),),
        body: ListItemsExpandable(
          data: _generateData(),
        ),
      ),

    );
  }
  List<List<String>> _generateData() {
    int numberOfGroups = 3;
    List<List<String>> results = <List<String>>[];
    for (int i = 0; i < numberOfGroups; i++) {
      List<String> items = <String>[];
      for (int j = 0; j < numberOfGroups * 2 + i; j++) {
        items.add("Item $j in group $i");
      }
      results.add(items);
    }
    return results;
  }
}

class ListItemsExpandable extends StatefulWidget {
  final List<List<String>> data;
  const ListItemsExpandable({Key? key, required this.data }) : super(key: key);

  @override
  State<ListItemsExpandable> createState() => _ListItemsExpandableState();
}

class _ListItemsExpandableState extends State<ListItemsExpandable> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          children: widget.data.map((group) {
            int index = widget.data.indexOf(group);
            return ExpandableGroup(
              isExpanded: index == 0,
              header: _header('Group $index'),
              items: _buildItems(context, group),
              headerEdgeInsets: EdgeInsets.only(left: 16.0, right: 16.0),
            );
          }).toList(),
        )
      ],
    );
  }
  Widget _header(String name) => Text(name,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ));

  List<ListTile> _buildItems(BuildContext context, List<String> items) => items
      .map((e) => ListTile(
    title: Text(e),
  ))
      .toList();
}
