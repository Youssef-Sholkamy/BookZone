import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Library.dart';
import 'emptyLibrary.dart';


class CartPage extends StatefulWidget {
  FirebaseAuth? auth;
  CartPage({Key? key, this.auth}) : super(key: key);
  @override
  State<CartPage> createState() => CartPageState();
}
class CartPageState extends State<CartPage> {
  late String timePeriod;
  String? name = "";
  int numberOfItems = 0;
 bool empt = false;
  isLibraryEmpty() async{
    await FirebaseFirestore.instance.collection("library").
        doc(FirebaseAuth.instance.currentUser!.uid).get().then((snapshot) async {
          if(snapshot.exists){
            setState(() {
              numberOfItems = snapshot["numberOfItems"];
              if(numberOfItems == 0){
                empt = true;
              }
            });
          }
    } );
  }

  getUserName() async{
    await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid)
        .get().then((snapshot) async{
      if(snapshot.exists){
        setState(() {
          name = snapshot["First name"];
        });

      }
    });
  }

  @override
  void initState() {
    super.initState();
    isLibraryEmpty();
    getUserName();

  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 185, 0, 1),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02 ,),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                //height: MediaQuery.of(context).size.height * 0.05,
                child: Align(
                  alignment: Alignment.center,
                  child: Text("My library" ,style: const TextStyle(fontSize: 20),),
                )
              ),
            empt? EmptyLibrary() : Library(),
          ],
        ),
      )
    );
  }
}