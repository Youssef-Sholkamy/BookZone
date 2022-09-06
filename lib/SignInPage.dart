import 'package:bookzila/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'TextFieldDecoratorClass.dart';
import 'CountriesPhoneKey.dart';
import 'AlertMessage.dart';

class BottomSignInSheet {
  final TextFieldDecoratorClass _decorator = TextFieldDecoratorClass();
  BuildContext context;
  //int _selectedDropDownItem = 1;
  List<DropdownMenuItem> items = CountriesPhoneKey().getItems;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool isRegistered = false;
  bool isVisible = true;
  BottomSignInSheet(this.context);
  String forgotPasswordText = "Forgot Password?";
  bool passwordVisible = true;


  checkRegisteredUser(FirebaseAuth auth) async {
    String Id = auth.currentUser!.uid;

    var collection = FirebaseFirestore.instance.collection('users').doc(Id);
    var docSnapshot = await collection.get();
    Map<String, dynamic> data = docSnapshot.data()!;
    if(data != null){
      isRegistered = true;
    }
  }


  bottomSheet() {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        )),
        builder: (context) {
          return StatefulBuilder(
              builder:  (BuildContext buildContext, StateSetter setNewState) {
                return  Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  padding: MediaQuery.of(context).viewInsets +
                      const EdgeInsets.only(bottom: 25 , left: 15, right: 15),
                  child: ListView(

                    children: <Widget>[
                      const SizedBox(height: 40,),
                      const Text(
                        "Login",
                        style: TextStyle(fontSize: 50),
                      ),
                      //const SizedBox(height: 10,),
                      // Container(
                      //   padding: const EdgeInsets.only(left: 50,right: 50),
                      //   child: DropdownButton(
                      //       value: _selectedDropDownItem,
                      //       items: items,
                      //       onChanged: (dynamic value){
                      //         setNewState(() {
                      //           _selectedDropDownItem = value!;
                      //         });
                      //
                      //       }
                      //   ),
                      // ),


                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(
                              fontFamily: "Arial",
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          keyboardType: TextInputType.text,
                          decoration: _decorator.decorate("Email"),
                          controller: _emailController,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: TextField(
                          controller: _passController,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(
                              fontFamily: "Arial",
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          keyboardType: TextInputType.text,

                          obscureText: isVisible,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                 icon: const Icon(Icons.remove_red_eye_outlined,),
                              onPressed: (){
                                setNewState(() {
                                  isVisible = !isVisible;
                                });

                              },
                            ),
                              hintStyle: const TextStyle(fontFamily: "Arial"),
                              fillColor: Colors.grey[350],
                              filled: true,

                              hintText: "password",
                              labelText: "Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none),
                              focusedBorder:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
                              contentPadding: const EdgeInsets.all(20)
                          )
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
                            },
                            child: Text(forgotPasswordText)),
                      ),
                      ElevatedButton(
                          onPressed: () async {

                            try {
                              final credential = await auth.signInWithEmailAndPassword(email: _emailController.text, password: _passController.text);
                              print("dsa");
                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(auth: auth,),));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                AlertMessage().showAlert(context);
                                print('No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                AlertMessage().showAlert(context);
                                print('Wrong password provided for that user.');
                              }
                              else{
                                AlertMessage().showAlert(context);
                              }
                            }


                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            fixedSize: const Size(100, 50),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                          ),
                          child: const Text("Sign In")),
                    ],
                  ),
                );

              }
          );
        }

    );
  }
}