import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'StorePage.dart';
import 'TradePage.dart';
import 'libraryPage.dart';
import 'AccountPage.dart';
import 'settingsPage.dart';



class HomePage extends StatefulWidget {
  FirebaseAuth? auth;
  String? name;
  HomePage({Key? key, this.auth,}) : super(key: key);

  getName() async {
    var collection = FirebaseFirestore.instance.collection('users').doc(this.auth!.currentUser!.uid);
    var docSnapshot = await collection.get();
    Map<String, dynamic> data = docSnapshot.data()!;
    name = data["First name"];
  }
  @override
  State<HomePage> createState() => HomePageState();
}
class HomePageState extends State<HomePage> {
  int bottomNavigationBarValue = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = <Widget>[
      StorePage(auth: widget.auth),
      CartPage(auth: widget.auth),
      const account(),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: screens[bottomNavigationBarValue],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromRGBO(211, 151, 0, 1),
        backgroundColor: const Color.fromRGBO(232, 232, 232, 1),
        unselectedItemColor: const Color.fromRGBO(107, 107, 107, 1),
        iconSize: 30,
        currentIndex: bottomNavigationBarValue,
        onTap: (value) {
          setState(() {
            bottomNavigationBarValue = value;
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Store"),
          BottomNavigationBarItem(icon: Icon(Icons.book ), label: "Library"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded ), label: "Account"),
        ],
      ),
    );
  }
}