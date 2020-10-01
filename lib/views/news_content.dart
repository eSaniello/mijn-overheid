import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class NewsContent extends StatelessWidget {
  final String title;
  final String img;
  final String budget;
  final String description;
  final String ministerie;
  final double progress;
  final String startDate;
  final String endDate;

  NewsContent({
    this.title,
    this.img,
    this.budget,
    this.description,
    this.ministerie,
    this.progress,
    this.startDate,
    this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        shadowColor: Colors.grey[400],
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: size.height * .40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        fit: BoxFit.fitHeight,
                        imageUrl: img,
                        placeholder: (context, url) => Image.asset('su.png'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.015,
                      letterSpacing: 5,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                Divider(color: Colors.grey),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    description,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.01,
                      letterSpacing: 2,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Divider(color: Colors.grey),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Budget: $budget\nMinisterie: $ministerie\nStart datum: $startDate\nEind datum: $endDate',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.01,
                      letterSpacing: 2,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Divider(color: Colors.grey),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Huidige status:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.01,
                      letterSpacing: 2,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LinearPercentIndicator(
                    width: size.width * .20,
                    lineHeight: size.height * .01,
                    percent: progress,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
