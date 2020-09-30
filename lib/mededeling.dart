import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:welvaart/home.dart';
import 'package:welvaart/news_content.dart';
import 'package:welvaart/news_item.dart';
import 'package:intl/intl.dart';
import 'package:welvaart/plannen.dart';

import 'regering.dart';

class MededelingenScreen extends StatefulWidget {
  @override
  MededelingenScreenState createState() => MededelingenScreenState();
}

class MededelingenScreenState extends State<MededelingenScreen> {
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
              children: [
                Container(
                  height: size.height * 0.1,
                  child: Text('MEDEDELINGEN'),
                )
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 10),
                      Container(
                        width: size.width * .20,
                        child: Text(DateTime.now().toString()),
                      ),
                      SizedBox(height: 10),
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
                      SizedBox(height: 10),
                      FlatButton(
                        minWidth: size.width * .20,
                        child: Text('Plannen'),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlanScreen()),
                          );
                          // setState(() {
                          //   firestore.collection('projects').add({
                          //     'name': 'random1221',
                          //     'description':
                          //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ornare auctor libero, vitae tempus enim venenatis in. Mauris posuere id nibh sed accumsan. Maecenas non eros sed odio euismod suscipit. Praesent et imperdiet eros, vel elementum libero. Ut tristique metus id mi viverra, nec sollicitudin nunc faucibus. Maecenas sit amet rhoncus ipsum. Vestibulum malesuada neque eget neque dictum iaculis. Ut mollis rutrum luctus. Cras pharetra velit sed orci eleifend pharetra.',
                          //     'budget': '\$10 mill',
                          //     'ministerie': "Min van Financien",
                          //     'progress': 7,
                          //     'start_date': '02-03-2019',
                          //     'end_date': '02-07-2022',
                          //     'date_added': DateTime.now()
                          //   });
                          // });
                        },
                      ),
                      SizedBox(height: 10),
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
                      SizedBox(height: 10),
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
                            .collection('mededelingen')
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
                              return InkWell(
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
                                  title: document.data()['title'],
                                  widht: size.width * .50,
                                  height: size.height * .20,
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
