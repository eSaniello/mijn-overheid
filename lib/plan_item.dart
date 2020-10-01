import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlanItem extends StatelessWidget {
  final String title;
  final double widht;
  final double height;
  final String img;
  final Timestamp dateAdded;
  final String description;

  PlanItem({
    this.title,
    this.widht,
    this.height,
    this.img,
    this.dateAdded,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime d = DateTime.parse(dateAdded.toDate().toString());
    String date = DateFormat('yyyy-MM-dd - kk:mm').format(d);

    return SizedBox(
      width: widht,
      height: height,
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
                    imageUrl: img,
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
                    title,
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
                        description,
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
                    'date: $date',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: size.width * 0.01,
                      color: Colors.grey,
                    ),
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
