import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class rating extends StatefulWidget {
  const rating({Key? key}) : super(key: key);
  @override
  State<rating> createState() => _ratingState();}

class _ratingState extends State<rating> {
  bool _isVertical = false;
   double _rating=0;

  @override
  Widget build(BuildContext context) {
var rating=0;

    return MaterialApp(

        home: Scaffold(

            body:Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RatingBar.builder(
                    initialRating: 0,
                    direction: _isVertical ? Axis.vertical : Axis.horizontal,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return Icon(
                            Icons.sentiment_very_dissatisfied,
                            color: Colors.red,
                          );
                        case 1:
                          return Icon(
                            Icons.sentiment_dissatisfied,
                            color: Colors.redAccent,
                          );
                        case 2:
                          return Icon(
                            Icons.sentiment_neutral,
                            color: Colors.amber,
                          );
                        case 3:
                          return Icon(
                            Icons.sentiment_satisfied,
                            color: Colors.lightGreen,
                          );
                        case 4:
                          return Icon(
                            Icons.sentiment_very_satisfied,
                            color: Colors.green,
                          );
                        default:
                          return Container();
                      }
                    },
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                        //   print(_rating);

                      });
                    },
                    updateOnDrag: true,
                  ),
                  SizedBox(height: 10,),
                  Text("your rating is ${_rating}")
                ],
              )

            )
            ),
    );

  }
}