import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage("assets/grecia.jpg"),
                  radius: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    "Grecia Saquelares",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Text(
                  "gsaquelares@isolveproduce.com",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            curve: Curves.easeIn,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'iCaseEntry v.1.0.0',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Container(
              child: Center(
                child: FlatButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  label: const Text("Logout",
                      style: TextStyle(color: Colors.white)),
                  color: Colors.red,
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('isLogged', false);
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
