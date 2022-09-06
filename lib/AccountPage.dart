import 'package:bookzila/settingsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'contactus.dart';
import 'rating.dart';
import 'package:provider/provider.dart';
import 'generated/l10n.dart';

class account extends StatefulWidget {
  const account({Key? key}) : super(key: key);
  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {
  String name = "";
  getData() async{
    await FirebaseFirestore.instance.collection("users").
    doc(FirebaseAuth.instance.currentUser!.uid).get().then((snapshot) async {
      if(snapshot.exists){
        setState(() {
          name = snapshot["First name"];
        });

      }
    } );
  }
  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        children: <Widget>[
          SizedBox(height: 30),
          ListTile(
            leading: Icon(Icons.account_circle_rounded,size: 80,),
            title: Text("$name", style: TextStyle(color: Colors.black, fontSize: 20)),
            trailing: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> settingsPage()));
                },
                icon: Icon(Icons.settings)),
          ),
          SizedBox(height: 50),

          ListTile(
            title: Text(S.of(context).contactus, style: TextStyle(color: Colors.indigo)),
            leading: Icon(Icons.contact_support),
            trailing: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> contactus()));
                },
                icon: Icon(Icons.arrow_forward_ios)),
          ),
          ListTile(
            title: Text(S.of(context).rating, style: TextStyle(color: Colors.indigo)),
            leading: Icon(Icons.star),
            trailing: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => rating()));
                },
                icon: Icon(Icons.arrow_forward_ios)),
          )
        ],
      ),
    );
  }
}
