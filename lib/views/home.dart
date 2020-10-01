import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:welvaart/services/firebase_auth_service.dart';
import 'news_content.dart';
import 'news_item.dart';
import 'plannen.dart';
import 'regering.dart';
import 'package:provider/provider.dart';
import 'transition.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showContent = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  double itemHeight;

  String title;
  String img;
  String budget;
  String description;
  String ministerie;
  double progress;
  String startDate;
  String endDate;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: size.width * 0.04),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          width: size.width * 0.12,
                          child: CachedNetworkImage(
                            fit: BoxFit.fitHeight,
                            imageUrl: 'https://i.imgur.com/PcLJHqc.png',
                            placeholder: (context, url) =>
                                Image.asset('su.png'),
                          ),
                        ),
                      ),
                      Text(
                        DateFormat('LLL dd, yyyy').format(DateTime.now()),
                        style: TextStyle(
                          fontSize: size.width * 0.01,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        DateFormat('h:mm a').format(DateTime.now()),
                        style: TextStyle(
                          fontSize: size.width * 0.008,
                          fontWeight: FontWeight.w200,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: size.width * 0.05),
                  Container(
                    height: size.height * .15,
                    child: CachedNetworkImage(
                      fit: BoxFit.fitHeight,
                      imageUrl:
                          'https://www.iconfinder.com/data/icons/weather-color-2/500/weather-07-512.png',
                      placeholder: (context, url) => Image.asset('su.png'),
                    ),
                  ),
                  Text(
                    'Good to see you :)',
                    style: TextStyle(
                      fontSize: size.width * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(width: size.width * .35),
                  FlatButton(
                    onPressed: () {
                      context.read<FirebaseAuthService>().signOut();
                    },
                    child: Text(
                      'Uitloggen',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: size.width * .01,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FlatButton(
                          hoverColor: Colors.grey[50],
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: size.width * .01),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.red,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Icon(
                                      Icons.home,
                                      color: Colors.white,
                                      size: size.width * 0.03,
                                    ),
                                  ),
                                ),
                                SizedBox(width: size.width * .02),
                                Text(
                                  'Start',
                                  style: TextStyle(
                                    fontSize: size.width * 0.025,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                SizedBox(width: size.width * .063),
                                CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: size.width * 0.005,
                                ),
                                SizedBox(width: size.width * .01),
                              ],
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              ScaleRoute(page: HomeScreen()),
                            );
                          },
                        ),
                        FlatButton(
                          hoverColor: Colors.grey[50],
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: size.width * .01),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey[50],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Icon(
                                      Icons.calendar_today,
                                      color: Colors.grey[400],
                                      size: size.width * 0.03,
                                    ),
                                  ),
                                ),
                                SizedBox(width: size.width * .02),
                                Text(
                                  'Plannen',
                                  style: TextStyle(
                                    fontSize: size.width * 0.025,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(width: size.width * .025),
                                SizedBox(width: size.width * .005),
                                SizedBox(width: size.width * .01),
                              ],
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              ScaleRoute(page: PlanScreen()),
                            );
                          },
                        ),
                        FlatButton(
                          hoverColor: Colors.grey[50],
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: size.width * .01),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey[50],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Icon(
                                      Icons.account_balance,
                                      color: Colors.grey[400],
                                      size: size.width * 0.03,
                                    ),
                                  ),
                                ),
                                SizedBox(width: size.width * .02),
                                Text(
                                  'Regering',
                                  style: TextStyle(
                                    fontSize: size.width * 0.025,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(width: size.width * .015),
                                SizedBox(width: size.width * 0.005),
                                SizedBox(width: size.width * .01),
                              ],
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              ScaleRoute(page: RegeringScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.009,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                        ),
                        color: Colors.grey[50],
                      ),
                    ),
                  ),
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
                          return Container(
                            color: Colors.grey[50],
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              children: snapshot.data.docs.map((document) {
                                return AnimatedContainer(
                                  curve: Curves.easeIn,
                                  height: itemHeight == null
                                      ? size.height * .25
                                      : itemHeight,
                                  duration: Duration(milliseconds: 300),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: size.height * .015,
                                      horizontal: size.width * .005,
                                    ),
                                    child: InkWell(
                                      splashColor: Colors.red,
                                      borderRadius: BorderRadius.circular(25),
                                      hoverColor: Colors.white12,
                                      onTap: () {
                                        setState(() {
                                          showContent = true;

                                          title = document.data()['name'];
                                          img = document.data()['img'];
                                          budget = document.data()['budget'];
                                          description =
                                              document.data()['description'];
                                          ministerie =
                                              document.data()['ministerie'];
                                          progress =
                                              document.data()['progress'];
                                          startDate =
                                              document.data()['start_date'];
                                          endDate = document.data()['end_date'];
                                        });
                                      },
                                      child: NewsItem(
                                        docId: document.id,
                                        img: document.data()['img'],
                                        title: document.data()['name'],
                                        description:
                                            document.data()['description'],
                                        budget: document.data()['budget'],
                                        dateAdded:
                                            document.data()['date_added'],
                                        widht: size.width * .40,
                                        height: size.height * .25,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    width: size.width * .001,
                    child: Container(
                      color: Colors.grey[50],
                    ),
                  ),
                  Column(
                    children: [
                      AnimatedContainer(
                        curve: Curves.bounceInOut,
                        duration: Duration(milliseconds: 150),
                        width: showContent ? size.width * .30 : 0,
                        height: showContent ? size.height * .80 : 0,
                        color: Colors.grey[50],
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: size.height * .015,
                            bottom: size.height * .02,
                          ),
                          child: NewsContent(
                            title: showContent ? '$title' : " ",
                            budget: showContent ? '$budget' : " ",
                            description: showContent ? '$description' : " ",
                            img: showContent ? '$img' : " ",
                            startDate: showContent ? '$startDate' : " ",
                            endDate: showContent ? '$endDate' : " ",
                            ministerie: showContent ? '$ministerie' : " ",
                            progress: showContent ? progress : 0.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: size.width * .01,
                    child: Container(
                      color: Colors.grey[50],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
