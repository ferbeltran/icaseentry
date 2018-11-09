import 'package:flutter/material.dart';
import 'package:icaseentry/models/case.dart';
import 'package:intl/intl.dart';

class CaseInfo extends StatefulWidget {
  final Case caso;
  CaseInfo({this.caso});

  @override
  CaseInfoState createState() {
    return new CaseInfoState();
  }
}

class CaseInfoState extends State<CaseInfo> {
  List<String> _types = ["System Error", "Special Request", "Support"];
  List<DropdownMenuItem<String>> _dropDownMenuTypeItems;

  TextEditingController dateController = TextEditingController();
  TextEditingController caseController = TextEditingController();
  TextEditingController customerController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController databaseController = TextEditingController();
  TextEditingController assignedUserController = TextEditingController();
    TextEditingController userController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  var formatter = new DateFormat('yyyy/MM/dd');

  @override
  void initState() {
    _dropDownMenuTypeItems = getDropdownMenuItems();

    dateController.text = formatter.format(
    DateTime.fromMillisecondsSinceEpoch(int.tryParse(widget.caso.date)));
    caseController.text = widget.caso.caseNumber;
    customerController.text = widget.caso.customer;
    typeController.text = widget.caso.type;
    databaseController.text = widget.caso.database;
    assignedUserController.text = widget.caso.assignedUser;
    userController.text = widget.caso.user;
    subjectController.text = widget.caso.subject;

    super.initState();
  }

  List<DropdownMenuItem<String>> getDropdownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String type in _types) {
      items.add(new DropdownMenuItem(child: Text(type), value: type));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: const Text("Case Info"),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Case'),
              trailing: Container(
                width: 100.0,
                child: TextField(
                  textAlign: TextAlign.end,
                  controller: caseController,
                ),
              ),
            ),
            ListTile(
              title: Text('Date'),
              trailing: Container(
                width: 120.0,
                child: TextField(
                  textAlign: TextAlign.end,
                  controller: dateController,
                ),
              ),
            ),
            ListTile(
              title: Text('Customer'),
              trailing: Container(
                width: 160.0,
                child: TextField(
                  textAlign: TextAlign.end,
                  controller: customerController,
                ),
              ),
            ),
            ListTile(
              title: Text('Type'),
              trailing: DropdownButton(
                items: _dropDownMenuTypeItems,
                value: widget.caso.type,
                onChanged: (type) {},
              ),
            ),
            ListTile(
              title: Text('Database'),
              trailing: Container(
                width: 160.0,
                child: TextField(
                  textAlign: TextAlign.end,
                  controller: databaseController,
                ),
              ),
            ),
            ListTile(
              title: Text('Assigned User'),
              trailing: Container(
                width: 160.0,
                child: TextField(
                  textAlign: TextAlign.end,
                  controller: assignedUserController,
                ),
              ),
            ),
             ListTile(
              title: Text('User'),
              trailing: Container(
                width: 160.0,
                child: TextField(
                  textAlign: TextAlign.end,
                  controller: userController,
                ),
              ),
            ),
             ListTile(
              title: Text('Subject'),
              trailing: Container(
                width: 160.0,
                child: TextField(
                  textAlign: TextAlign.end,
                  controller: subjectController,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.caso.description,
                style: TextStyle(fontSize: 14.0),
              ),
            )
          ],
        ));
  }
}
