import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../models/user.dart';
import '../services.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(
    this.id,
  );

  final int id;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Future<User> futureUser;

  @override
  void initState() {
    futureUser = fetchSingleUser(widget.id);
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
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Center(
          child: Text('Tafeel'),
        ),
        actions: [
          const SizedBox(
            width: 48.0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
              width: double.maxFinite,
              child: FutureBuilder<User>(
                future: futureUser,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Card(
                      surfaceTintColor: Colors.white,
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      margin: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              snapshot.data!.avatar,
                            ),
                            radius: 72.0,
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 16.0,
                            ),
                            child: Text(
                              '${snapshot.data!.first_name} ${snapshot.data!.last_name}',
                              style: const TextStyle(
                                fontSize: 18,
                                height: 1,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(snapshot.data!.email,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                )),
                          )
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Card(
                      surfaceTintColor: Colors.white,
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      margin: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          shimmerLoadingWidget(CircleAvatar(
                            radius: 72.0,
                          )),
                          shimmerLoadingWidget(Container(
                            color: Colors.white,
                            margin: const EdgeInsets.only(
                              top: 16.0,
                            ),
                            width: 80,
                            height: 16,
                          )),
                          shimmerLoadingWidget(Container(
                            color: Colors.white,
                            margin: const EdgeInsets.symmetric(vertical: 16.0),
                            width: 120,
                            height: 12,
                          )),
                        ],
                      ),
                    );
                  }
                  return Card(
                    surfaceTintColor: Colors.white,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        shimmerLoadingWidget(CircleAvatar(
                          radius: 72.0,
                        )),
                        shimmerLoadingWidget(Container(
                          color: Colors.white,
                          margin: const EdgeInsets.only(
                            top: 16.0,
                          ),
                          width: 80,
                          height: 16,
                        )),
                        shimmerLoadingWidget(Container(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(vertical: 16.0),
                          width: 120,
                          height: 12,
                        )),
                      ],
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }

  Shimmer shimmerLoadingWidget(Widget widget) {
    return Shimmer(
      gradient: const LinearGradient(
        colors: [Color(0xFFFAFAFA), Color(0xFFE0E0E0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: widget,
    );
  }
}
