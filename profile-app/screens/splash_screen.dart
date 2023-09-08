import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../models/user.dart';
import '../services.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late List<User> users;
  late bool isOnline;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: splashScreenIcon(),
      ),
    );
  }

  Widget splashScreenIcon() {
    String iconPath = "assets/logo.png";

    return Image.asset(
      iconPath,
      width: 160,
      height: 160,
    );
  }

  void checkOnline() async {
    //isOnline =
    await InternetConnectionChecker().hasConnection.then((isOnline) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
        content: Text(
          isOnline
              ? "Good, You have intenet connection"
              : "No Internet, Check Your Intenet Connection",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ));
      isOnline
          ? fetchUsers({
              'per_page': '30',
            }).then((value) {
              setState(() {
                users = value;
              });
              Future.delayed(
                Duration(seconds: 2),
                () {
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                    builder: (BuildContext context) {
                      return MyHomePage(
                        title: "Tafeel",
                        users: users,
                        isOnline: isOnline,
                      );
                    },
                  ));
                },
              );
            })
          : Future.delayed(
              Duration(seconds: 2),
              () {
                Navigator.of(context).pushReplacement(new MaterialPageRoute(
                  builder: (BuildContext context) {
                    return MyHomePage(
                        title: "Tafeel", users: [], isOnline: isOnline);
                  },
                ));
              },
            );
      return true;
    });
  }

  @override
  void initState() {
    super.initState();
    checkOnline();
  }
}
