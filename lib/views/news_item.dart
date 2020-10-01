import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:welvaart/models/user.dart';
import 'package:welvaart/services/firebase_auth_service.dart';

class NewsItem extends StatefulWidget {
  final String docId;
  final String title;
  final String budget;
  final double widht;
  final double height;
  final String img;
  final Timestamp dateAdded;
  final String description;

  NewsItem({
    this.docId,
    this.title,
    this.widht,
    this.height,
    this.img,
    this.budget,
    this.dateAdded,
    this.description,
  });

  @override
  _NewsItemState createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  bool liked = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FbUser u;
  int likes = 0;

  @override
  void initState() {
    super.initState();

    context.read<FirebaseAuthService>().currentUser().then((value) {
      u = value;
    });

    firestore.collection('projects').doc(widget.docId).get().then((value) {
      setState(() {
        likes = value.data()['likes'].length;
      });

      if (value.data()['likes'].contains(u.uid)) {
        setState(() {
          liked = true;
        });
      } else {
        setState(() {
          liked = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime d = DateTime.parse(widget.dateAdded.toDate().toString());
    String date = DateFormat('yyyy-MM-dd - kk:mm').format(d);

    return SizedBox(
      width: widget.widht,
      height: widget.height,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        shadowColor: Colors.grey[400],
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: size.width * .20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    fit: BoxFit.fitHeight,
                    imageUrl: widget.img,
                    placeholder: (context, url) => Image.asset('su.png'),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.01),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.015,
                      letterSpacing: 5,
                    ),
                  ),
                  Flexible(
                    child: Container(
                      width: size.width * .20,
                      child: Text(
                        widget.description,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.013,
                          letterSpacing: 3,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'Budget: ${widget.budget}    date: $date',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: size.width * 0.01,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$likes',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: size.width * 0.012,
                    ),
                  ),
                  IconButton(
                    iconSize: size.width * 0.03,
                    icon: Icon(liked ? Icons.favorite : Icons.favorite_border),
                    onPressed: () {
                      setState(() {
                        liked = !liked;
                        if (liked) {
                          likes++;
                          firestore
                              .collection('projects')
                              .doc(widget.docId)
                              .update({
                            'likes': FieldValue.arrayUnion([u.uid]),
                          });
                        } else {
                          likes--;
                          firestore
                              .collection('projects')
                              .doc(widget.docId)
                              .update({
                            'likes': FieldValue.arrayRemove([u.uid]),
                          });
                        }
                      });
                    },
                    color: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
