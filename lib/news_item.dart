import 'package:flutter/material.dart';

class NewsItem extends StatelessWidget {
  final String title;
  final double widht;
  final double height;
  final String img;

  NewsItem({this.title, this.widht, this.height, this.img});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: widht,
      height: height,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        shadowColor: Colors.grey[400],
        elevation: 5,
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
                  child: Image.network(
                    img == null
                        ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/60/Flag_of_Suriname.svg/1200px-Flag_of_Suriname.svg.png"
                        : img,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.05),
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
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: size.width * 0.013,
                      letterSpacing: 3,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'Budget: \$$title    date: 22-01-2020 - 22:39',
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
