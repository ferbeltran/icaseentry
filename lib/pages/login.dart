import 'package:flutter/material.dart';
import 'package:icaseentry/utils/background_painter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.lerp(
              Alignment.lerp(Alignment.centerRight, Alignment.center, 0.3),
              Alignment.topCenter,
              0.15),
          children: <Widget>[
            CustomPaint(
                painter: BackgroundPainter(),
                child: Container(height: deviceHeight)),
            Column(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(80.0, 80.0, 80.0, 30.0),
                    child: Image.asset("assets/logo.png"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 10.0),
                  child: _createLoginField(Icons.person, false),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 10.0),
                  child: _createPasswordField(Icons.vpn_key, true),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
                      child: _createLoginButton(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: _createForgotPassword(),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 130.0),
                          child: _createPrivacyText(),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

_createLoginField(IconData icon, bool isObscure) {
  return TextField(
    obscureText: isObscure,
    style: TextStyle(fontSize: 15.0),
    decoration: InputDecoration(
      icon: Icon(icon, color: Colors.deepPurpleAccent),
    ),
  );
}

_createPasswordField(IconData icon, bool isObscure) {
  return TextField(
    obscureText: isObscure,
    style: TextStyle(fontSize: 15.0),
    decoration: InputDecoration(
      icon: Icon(icon, color: Colors.deepPurpleAccent),
    ),
  );
}

_createLoginButton(BuildContext context) {
  return FlatButton(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    onPressed: () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLogged', true);
      Navigator.of(context).pushReplacementNamed('/home');
    },
    child: Text(
      "LOGIN",
      style: const TextStyle(
        color: Colors.deepPurpleAccent,
        fontSize: 20.0,
      ),
    ),
  );
}

_createForgotPassword() {
  return new FlatButton(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    onPressed: () {},
    child: new Text(
      "FORGOT PASSWORD?",
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 10.0,
      ),
    ),
  );
}

_createPrivacyText() {
  return FlatButton(
    onPressed: () {},
    child: Column(
      children: <Widget>[
        Text(
          "By logging in you agree to our",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11.0,
          ),
        ),
        Text(
          "privacy policy & terms of service",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11.0,
          ),
        ),
      ],
    ),
  );
}
