import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bookzila/VerifyEmail.dart';
import 'AlertMessage.dart';



class SignUpPage3 extends StatefulWidget {
  String? fName, lName, gender, phoneNumber;
  DateTime? dob;

  SignUpPage3({Key? key, this.fName, this.lName, this.gender, this.dob, this.phoneNumber}) : super(key: key);

  @override
  State<SignUpPage3> createState() => SignUpPage3State();
}

class SignUpPage3State extends State<SignUpPage3> {
  List<bool> eye = [true, true];
  List<Color> eyeColor = [Colors.grey, Colors.grey];
  final _passController = TextEditingController();
  final _passConfirmController = TextEditingController();
  final _emailController = TextEditingController();

  //Database

  FirebaseFirestore database = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;


  String validatePassword(){
    String errors = '';
    bool containsDigit = false, containsChar = false, containsUpperCaseLetter = false, containsLowerCaseLetter = false;
    if(_passController.text.isEmpty){
      errors += "Password can't be empty.\n";
    }
    if(_passController.text.length < 8 || _passController.text.length > 32){
      errors += "Password needs to be between 8 and 32 characters long.\n";
    }
    for(int i = 0; i < _passController.text.length; i++){
      if(_passController.text[i].contains(RegExp("[0-9]"))){
        containsDigit = true;
      }
      if(_passController.text[i].contains(RegExp("[A-Z]"))){
        containsUpperCaseLetter = true;
      }
      if(_passController.text[i].contains(RegExp("[a-z]"))){
        containsLowerCaseLetter = true;
      }
      else if(!_passController.text[i].contains(RegExp("[^A-Za-z0-9]"))){
        containsChar = true;
      }
    }
    if(_passController.text.length < 8 || _passController.text.length > 32){
      errors += "Password needs to be between 8 and 32 characters long.\n";
    }
    if(!containsDigit){
      errors += "Password needs to contain at least one digit.\n";
    }
    if(!containsChar){
      errors += "Password needs to contain at least one special character.\n";
    }
    if(!containsUpperCaseLetter){
      errors += "Password needs to contain at least one uppercase letter.\n";
    }
    if(!containsLowerCaseLetter){
      errors += "Password needs to contain at least one lowercase letter.\n";
    }
    if(_passController != _passConfirmController){
      errors += "Passwords don't match.\n";
    }

    return errors;
  }

  Future<void> addUser() async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passConfirmController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        print('The email you entered is not valid.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    auth.currentUser!.sendEmailVerification();
  }


  @override
  Widget build(BuildContext context) {

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
                Text("3/4",style: TextStyle(fontSize: 24, color: Colors.grey[600]),),
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
                      hintText: "Email",

                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                Center(
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                        fontFamily: "Arial",
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    keyboardType: TextInputType.text,
                    obscureText: eye[0],
                    controller: _passController,
                    decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye,color: eyeColor[0]),
                        onPressed: (){
                          setState(() {
                            eye[0] = !eye[0];
                            if(eye[0] == true) {
                              eyeColor[0] = Colors.grey;
                            }
                            else {
                              eyeColor[0] = Colors.blue;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                        fontFamily: "Arial",
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    keyboardType: TextInputType.text,
                    obscureText: eye[1],
                    controller: _passConfirmController,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye,color: eyeColor[1]),
                        onPressed: (){
                          setState(() {
                            eye[1] = !eye[1];
                            if(eye[1] == true) {
                              eyeColor[1] = Colors.grey;
                            }
                            else {
                              eyeColor[1] = Colors.blue;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40,),
                Center(
                  child: ElevatedButton.icon(
                    label: const Text("Confirm",style: TextStyle(fontSize: 20),),
                    icon: const Icon(Icons.chevron_right),

                    onPressed: () {
                      String pass = validatePassword();
                      if(pass != ''){
                        addUser();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage4(email: _emailController.text, dob: widget.dob, fName: widget.fName, gender: widget.gender, lName: widget.lName, phoneNumber: widget.phoneNumber)));
                      }
                      else{
                        AlertMessage().showAlert(context);
                      }

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