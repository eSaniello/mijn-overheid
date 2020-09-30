import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:welvaart/mededeling.dart';
import 'package:welvaart/news_content.dart';
import 'package:welvaart/news_item.dart';
import 'package:intl/intl.dart';
import 'package:welvaart/plannen.dart';

import 'regering.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showContent = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String title;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      width: size.width * .20,
                      child: Text(
                          DateFormat('LLL dd, yyyy').format(DateTime.now())),
                    ),
                    Container(
                      width: size.width * .20,
                      child: Text(DateFormat('h:mm a').format(DateTime.now())),
                    ),
                  ],
                ),
                Container(
                  height: size.height * .15,
                  child: Image.network(
                      'https://www.iconfinder.com/data/icons/weather-color-2/500/weather-07-512.png',
                      fit: BoxFit.contain),
                ),
                Text('Good to see you'),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FlatButton(
                        minWidth: size.width * .20,
                        child: Text('Home'),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                          );
                        },
                      ),
                      FlatButton(
                        minWidth: size.width * .20,
                        child: Text('Plannen'),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlanScreen()),
                          );
                        },
                      ),
                      FlatButton(
                        minWidth: size.width * .20,
                        child: Text('Mededelingen'),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MededelingenScreen()),
                          );
                        },
                      ),
                      FlatButton(
                        minWidth: size.width * .20,
                        child: Text('De Regering'),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegeringScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: StreamBuilder(
                        stream: firestore
                            .collection('projects')
                            .orderBy('date_added', descending: true)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: LinearProgressIndicator(),
                            );
                          }
                          return ListView(
                            children: snapshot.data.docs.map((document) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 10,
                                ),
                                child: InkWell(
                                  splashColor: Colors.red,
                                  borderRadius: BorderRadius.circular(25),
                                  hoverColor: Colors.white12,
                                  onTap: () {
                                    setState(() {
                                      showContent = true;
                                      DateTime d = DateTime.parse(document
                                          .data()['date_added']
                                          .toDate()
                                          .toString());
                                      title = DateFormat('yyyy-MM-dd - kk:mm')
                                          .format(d);
                                    });
                                  },
                                  child: NewsItem(
                                    title: document.data()['name'],
                                    widht: size.width * .50,
                                    height: size.height * .20,
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }),
                  ),
                  SizedBox(width: size.width * .01),
                  Column(
                    children: [
                      NewsContent(
                        title: showContent ? '$title' : " ",
                        widht: showContent ? size.width * .30 : 0,
                        height: showContent ? size.height * .90 : 0,
                      ),
                    ],
                  ),
                  SizedBox(width: size.width * .01),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
