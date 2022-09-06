import 'package:bookzila/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'AlertMessage.dart';



class SignUpPage4 extends StatefulWidget {
  String? fName, lName, gender, phoneNumber, email;
  DateTime? dob;

  SignUpPage4({Key? key, this.fName, this.lName, this.gender, this.dob, this.phoneNumber, this.email}) : super(key: key);

  @override
  State<SignUpPage4> createState() => SignUpPage4State();
}

class SignUpPage4State extends State<SignUpPage4> {
  List<bool> eye = [true, true];
  List<Color> eyeColor = [Colors.grey, Colors.grey];
  final _emailController = TextEditingController();

  //Database

  FirebaseFirestore database = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;


  Future<void> addUser() async {
    auth!.currentUser!.updateDisplayName("${widget.fName} ${widget.lName}");
    return database.collection("users").doc(auth!.currentUser!.uid).set(
        {"First name" : widget.fName,
          "Last name" : widget.lName,
          "Date of birth" : "${widget.dob!.year}-${widget.dob!.month}-${widget.dob!.day}",
          "Gender" : widget.gender,
          "Phone number" : widget.phoneNumber,
          
        }).then((value) => print("user added")).catchError((error) => print(error));
  }
  Future<void> addUserLibrary() async {
    auth!.currentUser!.updateDisplayName("${widget.fName} ${widget.lName}");
    return database.collection("library").doc(auth!.currentUser!.uid).set(
        {
          "numberOfItems" : 0,

        }).then((value) => print("cart added")).catchError((error) => print(error));
  }

  checkVerified(){
    if(auth.currentUser!.emailVerified){
      addUser();
      addUserLibrary();
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(auth: auth,),));
    }
    else{
      AlertMessage().showAlert(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    _emailController.text = widget.email!;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up"),
          backgroundColor: const Color.fromRGBO(255, 170, 0, 1),
        ),
        body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.only(right: 25, left: 25),
              children: [
                const SizedBox(height: 30,),
                Text("4/4",style: TextStyle(fontSize: 24, color: Colors.grey[600]),),
                const SizedBox(height: 130,),
                Center(
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                        fontFamily: "Arial",
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      enabled: false,
                      label: Text("Email"),
                    ),
                  ),
                ),

                const SizedBox(height: 30,),

                const Center(
                  child: Flexible(child: Text("A verification email has been sent to the email above, please verify your email then press on the button below to continue"),
                )),
                const SizedBox(height: 40,),
                Center(
                  child: ElevatedButton.icon(
                    label: const Text("Verify",style: TextStyle(fontSize: 20),),
                    icon: const Icon(Icons.chevron_right),

                    onPressed: () async {
                      await auth.currentUser!.reload().then((value) => checkVerified());
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      fixedSize: Size(
                          MediaQuery.of(context).size.width,
                          50
                      ),
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                )
              ],
            )
        )
    );
  }
}