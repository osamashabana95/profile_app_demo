import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../models/user.dart';
import 'details_screen.dart';
import 'splash_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key,
      required this.title,
      required this.users,
      required this.isOnline});

  final String title;
  final List<User> users;
  final bool isOnline;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    setState(() {});
  }

  void checkOnline(int id) async {
    await InternetConnectionChecker().hasConnection.then((isOnline) {
      if (isOnline) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) {
            return DetailsScreen(id);
          },
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
          content: Text(
            "No Internet, Check Your Intenet Connection",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ));
      }

      return true;
    });
  }

  Widget getBody() {
    return ListView.builder(
      itemCount: widget.users.length,
      shrinkWrap: true,
      itemBuilder: (context, position) {
        return InkResponse(
          onTap: () {
            checkOnline(widget.users[position].id);
          },
          child: Card(
              surfaceTintColor: Colors.white,
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: const EdgeInsets.all(16),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.users[position].avatar,
                  ),
                  radius: 32.0,
                ),
                title: Text(
                    '${widget.users[position].first_name} ${widget.users[position].last_name}'),
                subtitle: Text(widget.users[position].email),
              )),
        );
      },
    );
  }

  Widget getOffline() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('No Internet Connection ',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )),
          TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return SplashScreen();
                  },
                ));
              },
              child: const Row(
                children: [
                  Icon(Icons.refresh, color: Colors.white),
                  Text(
                    "Reload",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget getNoData() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('There Is A Problem, No Data',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )),
          TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return SplashScreen();
                  },
                ));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh, color: Colors.white),
                  Text(
                    "Reload",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.black,
        elevation: 8.0,
        title: Center(
          child: Text(widget.title),
        ),
      ),
      body: Center(
        child: !widget.isOnline
            ? getOffline()
            : widget.users.isEmpty
                ? getNoData()
                : getBody(),
      ),
    );
  }
}
