import 'package:flutter/material.dart';
import 'Books.dart';
import 'Books.dart';

class BookCategories extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => BookCategoriesState();
}

class BookCategoriesState extends State<BookCategories> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        InkWell(
          child: Container(
            height: 150,
            width: 150,
            child: Card(
              color: Colors.white,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: const [
                  Image(
                    image: AssetImage("design/images/scientific.png"),
                    width: 50,
                    height: 50,
                  ),
                  Text(
                    "Science",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder:  (context) => Books(type: "Science",)));
          },
        ),
        InkWell(
          child: Container(
            height: 150,
            width: 150,
            child: Card(
              color: Colors.white,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: const [
                  Image(
                    image: AssetImage("design/images/art.png"),
                    width: 50,
                    height: 50,
                  ),
                  Text(
                    "Arts",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder:  (context) => Books(type: "Arts",)));
          },
        ),
        InkWell(
          child: Container(
            height: 150,
            width: 150,
            child: Card(
              color: Colors.white,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: const [
                  Image(
                    image: AssetImage("design/images/novel.png"),
                    width: 50,
                    height: 50,
                  ),
                  Text(
                    "Novels",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder:  (context) => Books(type: "Novel",)));
          },
        ),
        InkWell(
          child: Container(
            height: 150,
            width: 150,
            child: Card(
              color: Colors.white,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: const [
                  Image(
                    image: AssetImage("design/images/history.png"),
                    width: 50,
                    height: 50,
                  ),
                  Text(
                    "History",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder:  (context) => Books(type: "History",)));
          },
        ),

      ],
    );
  }

}




