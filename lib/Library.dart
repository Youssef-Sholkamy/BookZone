
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'bookViewer.dart';




class Book{
  late String name;
  late String price;
  late String numberOfPages;
  late String imagePath;
  late String type;
  late String pdfPath;
  late String rate;
  late String auth;

  Book(this.name, this.price, this.numberOfPages, this.imagePath, this.pdfPath, this.type, this.rate , this.auth);
}



class Library extends StatefulWidget {
  int? numberOfItems;

  Library({Key? key, this.numberOfItems}) : super(key: key);
  @override
  State<Library> createState() => LibraryState();
}
class LibraryState extends State<Library> {
  List<Book> books = [];
  late Map<String, dynamic> temp;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final LibraryRef = FirebaseFirestore.instance.collection("library");

  getLibraryItems() async {
    await LibraryRef.doc(auth.currentUser!.uid).get().then((DocumentSnapshot snapshot) {
      Map<String, dynamic> Library = snapshot.data() as Map<String, dynamic>;
      for(int i = 0; i < Library["numberOfItems"]; i++){
        temp = Library["Item $i"] as Map<String, dynamic>;
        books.add(Book(temp["name"], temp["price"].toString(), temp["numberOfPages"].toString(),
            "design/bookCovers/${temp["name"]}.png", "books/sample.pdf", temp["type"], temp["rate"].toString(), temp["auth"]));
      }
      print(books.length);
    });
  }


  @override
  void initState() {
    super.initState();
    setState(() {
      books.clear();
      getLibraryItems();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(

      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.75,
       child: ListView.builder(itemExtent: 200,itemCount: books.length,itemBuilder: (context, index) {
         return Padding(
           padding: const EdgeInsets.all(8.0),
           child: InkWell(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => bookViewer(),));
             },
             child: Container(

               margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03 ,right: MediaQuery.of(context).size.width * 0.03),
               decoration: BoxDecoration(
                 color: Colors.white,
                 border: Border.all(color: Colors.grey , width: 2.5),
                 borderRadius: BorderRadius.all(Radius.circular(10)),
               ),
               child: Row(
                 children: [
                   Container(
                       padding: EdgeInsets.only(
                           left: MediaQuery.of(context).size.width * 0.03),
                       width: MediaQuery.of(context).size.width * 0.33,
                       height: 400,
                       child: Image(
                           image: AssetImage(books[index].imagePath)
                       )
                   ),
                   Container(
                     width: MediaQuery.of(context).size.width * 0.33,
                     padding: EdgeInsets.only(top: 50, ),
                     child: Column(
                       children: [
                         Flexible(child: Text(books[index].name, style: const TextStyle(fontSize: 20 , color: Colors.black))),
                         Text("\$${books[index].price.toString()}", style: const TextStyle(fontSize: 16,color: Colors.grey)),
                         Text("${books[index].type.toString()}", style: const TextStyle(fontSize: 16,color: Colors.grey)),
                       ],
                     ),
                   ),
                 ],
               ),
             ),
           ),
         );
       },),
    );
  }
}