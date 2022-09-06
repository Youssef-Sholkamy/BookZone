import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Book{
  late String name;
  late String price;
  late String numberOfPages;
  late String imagePath;
  late String type;
  late String pdfPath;
  late String rate;
  late String auth;
  late bool isOwned;

  Book(this.name, this.price, this.numberOfPages, this.imagePath, this.pdfPath, this.type, this.rate , this.auth, this.isOwned);

  set setIsOwned(bool isOwned){
    this.isOwned = isOwned;
  }
}




class Books extends StatefulWidget {
  String? type = "";
  Books({Key? key, String? this.type}) : super(key: key);

  @override
  State<Books> createState() => BooksState();
}
class BooksState extends State<Books> {
  List<Book> books = [];
  int numberOfItems = 0;
  late Map<String, dynamic> bookStore;
  List<Map<String, dynamic>> allBooks = [];
  List<Map<String, dynamic>> library = [];
  late Map<String, dynamic> temp2;
  FirebaseAuth auth = FirebaseAuth.instance;
  int cartItems = 0;

  compare(){
    for(int i = 0; i < allBooks.length; i++){
      books.add(Book(allBooks[i]["name"], allBooks[i]["price"].toString(), allBooks[i]["numberOfPages"].toString(),
          "design/bookCovers/${allBooks[i]["name"]}.png", "books/sample.pdf", allBooks[i]["type"], allBooks[i]["rate"].toString(), allBooks[i]["auth"], false));
      for(int j = 0; j < library.length; j++){
        if(library[j]["name"] == allBooks[i]["name"]){
          books[i].setIsOwned = true;
        }
      }
    }
  }


     getData() async {
      if(widget.type == "") {
        CollectionReference _collectionRef = FirebaseFirestore.instance.collection('books');
        QuerySnapshot querySnapshot = await _collectionRef.get();
        FirebaseFirestore.instance.collection('library').doc(auth.currentUser!.uid).get().then((DocumentSnapshot snapshot) async {

       setState(() {
          temp2 = snapshot.data() as Map<String, dynamic>;
          for(int i = 0; i < querySnapshot.size; i++){
            bookStore = querySnapshot.docs.elementAt(i).data() as Map<String, dynamic>;
            allBooks.add(bookStore);
          }
          for(int i = 0; i < temp2.length-1; i++){
            library.add(temp2["Item $i"]);
          }
          // print(allBooks);
          });
       compare();
        });
      }
      else{
        try{
          FirebaseFirestore db = FirebaseFirestore.instance;
          final ref = db.collection("books").where("type", isEqualTo: widget.type);
          QuerySnapshot querySnapshot = await ref.get();
          FirebaseFirestore.instance.collection('library').doc(auth.currentUser!.uid).get().then((DocumentSnapshot snapshot) async {
          setState(() {
            temp2 = snapshot.data() as Map<String, dynamic>;
            for(int i = 0; i < querySnapshot.size; i++){
              bookStore = querySnapshot.docs.elementAt(i).data() as Map<String, dynamic>;
              allBooks.add(bookStore);
            }
            for(int i = 0; i < temp2.length-1; i++){
              library.add(temp2["Item $i"]);
            }
          });
          compare();
          });
        }
        catch(err){
          print(err);
        }

      }
    }

getItemsCount() async {

  await FirebaseFirestore.instance.collection("library").
  doc(FirebaseAuth.instance.currentUser!.uid).get().then((snapshot) async {
    if(snapshot.exists){
      setState(() {
        numberOfItems = snapshot["numberOfItems"];

      });
    }
  } );
}
    @override
  void initState() {
    super.initState();
    getData();
    getItemsCount();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 185, 0, 1),
      ),
      body: SafeArea(
        child: ListView.builder(itemExtent: 200,itemCount: books.length ,itemBuilder: (context, index) {
          if(!books[index].isOwned){
            return Row(
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
                      Flexible(child: Text(books[index].name, style: const TextStyle(fontSize: 20 , color: Colors.white))),
                      Text("\$${books[index].price.toString()}", style: const TextStyle(fontSize: 16,color: Colors.grey)),
                      Text("${books[index].type.toString()}", style: const TextStyle(fontSize: 16,color: Colors.grey)),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.33,
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.11),
                  child: IconButton(onPressed: () async {


                    final cartRef = FirebaseFirestore.instance.collection("library");


                      cartRef.doc(auth.currentUser!.uid).set({
                        "numberOfItems" : numberOfItems+1,
                        "Item $numberOfItems" : {
                          "name" : books[index].name,
                          "author" : books[index].auth,
                          "type" : books[index].type,
                          "price" : books[index].price,
                          "numberOfPages" : books[index].numberOfPages,
                          "rate" : books[index].rate,
                          "imagePath" : books[index].imagePath,
                          "pdfPath" : books[index].pdfPath,
                          "isOwned" : true
                        }
                      }, SetOptions(merge: true));

                  }, icon: const Icon(Icons.shopping_cart_checkout_rounded) , color: Colors.green,),
                )
              ],
            );
          }
          else{
            return Row(
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
                      Flexible(child: Text(books[index].name, style: const TextStyle(fontSize: 20 , color: Colors.white))),
                      Text("\$${books[index].price.toString()}", style: const TextStyle(fontSize: 16,color: Colors.grey)),
                      Text("${books[index].type.toString()}", style: const TextStyle(fontSize: 16,color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            );
          }
        },)
        )
    );
  }

}