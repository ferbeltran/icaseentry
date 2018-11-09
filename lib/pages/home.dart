import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:icaseentry/pages/case_info.dart';
import 'package:icaseentry/utils/themes.dart';
import 'package:icaseentry/widgets/drawer.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icaseentry/models/case.dart';
import 'package:icaseentry/pages/settings.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final ThemeBloc themeBloc;
  HomePage({Key key, this.themeBloc}) : super(key: key);

  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<Case> cases = [];
  bool _isLoading = true;
  bool _firstTime = true;
  Brightness brightness;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future<Null> getData() async {
    this.setState(() {
      _isLoading = true;
    });
    var response = await http.get(
        'https://csp2.isolvetech.net:44302/caseentrymobile.svc/GetCaseEntries?nFrom=0&nCount=10&readType=Bottom&caseEntryNo=&login=gsaquelares&customerCode=',
        headers: {
          "Authorization":
              "Basic QjFHSG55STdXQ2pUdHlTa1JHeURqTVRwZnh3SWRpcHNhb1lNVUdqU2JrcUlYMXBBTzg=",
          "Content-Type": "application/json"
        });

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);

      this.setState(() {
        cases = jsonData.map<Case>((c) => new Case.fromJson(c)).toList();
        cases.sort((a, b) => int.tryParse(b.date) - int.tryParse(a.date));

        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure(
      onLaunch: (message) {}, 
      onMessage: (message) {
        var jsonData = json.encode(message);
        var map = json.decode(jsonData);
        _showSnack(map['aps']['alert']['body']);
      },
    );

    Future.delayed(const Duration(seconds: 1))
        //.then((_) => _showSnack("No olvides poner el WHERE en el DELETE FROM"))
        .then((_) => _firstTime = false);
    super.initState();
    _isLoading = true;
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerMenu(),
      bottomNavigationBar: _buildBottomAppBar(context),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: Text('New Case', style: TextStyle(color: Colors.white)),
        elevation: 4.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.settings),
                  tooltip: 'Search',
                  onPressed: () {
                    //_searchPressed();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            SettingsPage(themeBloc: widget.themeBloc)));
                  },
                ),
              ],
              expandedHeight: 200.0,
              elevation: 0.0,
              floating: false,
              pinned: true,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/grecia.jpg'),
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  title: Text("Case Entry"),
                  background: Image.asset(
                    "assets/support4.gif",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: _createCasesList(context),
      ),
    );
  }

  _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      elevation: 4.0,
      color: Colors.grey[900],
      child: Container(
        height: 25.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              width: 15.0,
            ),
            cases.length > 0
                ? Text(
                    "Cases: ${cases.length}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  _showSnack(String textToDisplay) {
    final snackBar = SnackBar(
      content: Text(textToDisplay),
      duration: Duration(seconds: 2),
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _createCasesList(BuildContext context) {
    return RefreshIndicator(
      onRefresh: getData,
      color: Theme.of(context).accentColor,
      backgroundColor: Colors.white,
      child: _isLoading == true && _firstTime == true
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: cases.length,
              itemBuilder: (BuildContext context, int index) {
                var formatter = new DateFormat('MMM/dd');

                return Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                CaseInfo(caso: cases[index])));
                      },
                      isThreeLine: true,
                      title: Row(
                        children: <Widget>[
                          Text(cases[index].caseNumber),
                          Text(" · "),
                          Expanded(child: Text(cases[index].status)),
                        ],
                      ),
                      subtitle: Text(cases[index].description),
                      trailing: Column(
                        children: <Widget>[
                          Icon(Icons.event),
                          Text(formatter
                              .format(DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(cases[index].date)))
                              .toString()),
                          Text(
                            '${cases[index].minutes}m',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).accentColor),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      indent: 15.0,
                      height: 1.0,
                    )
                  ],
                );
              }),
    );
  }
}
