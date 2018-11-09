import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icaseentry/utils/themes.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:icaseentry/utils/preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences preferences;

class SettingsPage extends StatefulWidget {
  final ThemeBloc themeBloc;

  SettingsPage({Key key, this.themeBloc}) : super(key: key);

  @override
  SettingsPageState createState() {
    return new SettingsPageState();
  }
}

class SettingsPageState extends State<SettingsPage> {
  bool usesDarkTheme;
  int numberOfCases;
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  loadPreferences() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      usesDarkTheme = (preferences.getBool("usesDarkTheme") ?? false);
      numberOfCases = (preferences.getInt("numberOfCases") ?? 10);
      textController.text = numberOfCases.toString();
    });
  }

  numberOfCasesValidator(String value) {
    if (value == null) {
      return null;
    }
    var number = int.tryParse(value);
    if (number > 10) return true;
  }

  _buildHeader(AsyncSnapshot<bool> snapshot, String headerTitle) {
    if (snapshot.hasData) {
      bool value = snapshot.data;
      return Container(
          height: 40.0,
          color: value ? Colors.grey[700] : Colors.grey[400],
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 5.0),
                child: Text(
                  headerTitle,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700,
                    color: value ? Colors.pink[200] : Colors.black,
                  ),
                ),
              )));
    } else {
      return Container(height: 40.0, color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Settings"),
      ),
      body: ListView(
        children: <Widget>[
          FutureBuilder<bool>(
              future: PreferencesHelper.getUsesDarkTheme(),
              initialData: false,
              builder: (context, snapshot) {
                return _buildHeader(snapshot, "GENERAL");
              }),
          ListTile(
            title: Text("Number of Cases to show"),
            trailing: Container(
                width: 40.0,
                child: TextFormField(
                  textAlign: TextAlign.end,
                  keyboardType: TextInputType.number,
                  controller: textController,
                  //validator: numberOfCasesValidator,
                  //initialValue: "10",
                )),
          ),
          ListTile(
            title: Text("Dark Theme"),
            trailing: CupertinoSwitch(
                activeColor: Theme.of(context).accentColor,
                value: usesDarkTheme != null ? usesDarkTheme : false,
                onChanged: (bool value) async {
                  setState(() {
                    usesDarkTheme = value;
                  });

                  if (value) {
                    widget.themeBloc.selectedTheme
                        .add(widget.themeBloc.darkTheme());
                  } else {
                    widget.themeBloc.selectedTheme
                        .add(widget.themeBloc.lightTheme());
                  }
                  
                  await PreferencesHelper.setUsesDarkTheme(value);
                }),
          ),
        ],
      ),
    );
  }
}
