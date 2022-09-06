import 'package:bookzila/PhoneVerification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'TextFieldDecoratorClass.dart';
import 'CountriesPhoneKey.dart';
import 'AlertMessage.dart';
class BottomSignUpSheet{
  BuildContext context;
  final TextFieldDecoratorClass _decorator = TextFieldDecoratorClass();
  String _selectedDropDownItem = "+20";
  List<DropdownMenuItem> items = CountriesPhoneKey().getItems;
  final _phoneNumController = TextEditingController();


  BottomSignUpSheet(this.context);

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
              builder: (BuildContext buildContext, StateSetter setNewState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              padding: MediaQuery.of(context).viewInsets + const EdgeInsets.only(bottom: 25, right: 15,left: 15),
              child: ListView(
                children: <Widget>[
                  const SizedBox(height: 30,),
                  const Text(
                    "Enter your phone number to continue",
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 60,),
                  Container(
                    padding:  const EdgeInsets.only(left: 50,right: 50),
                    child: DropdownButton(
                        value: _selectedDropDownItem,
                        items: items,
                        onChanged: (dynamic value){
                          setNewState(() {
                            _selectedDropDownItem = value!;
                          });
                        }
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Center(
                    child: TextField(
                      style: const TextStyle(
                          fontFamily: "Arial",
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      keyboardType: TextInputType.number,
                      maxLength: 11,
                      decoration: _decorator.decorate("Phone Number"),
                      controller: _phoneNumController,
                    ),
                  ),
                  const SizedBox(height: 30,),
                  ElevatedButton(
                      onPressed: ()   async {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: "${_selectedDropDownItem}${_phoneNumController.text}",
                          verificationCompleted: (PhoneAuthCredential credential) {
                          },
                          verificationFailed: (FirebaseAuthException e) {
                            AlertMessage().showAlert(context);

                          },
                          codeSent: (String verificationId, int? resendToken) {
                            print("object");
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneVerification(verificationId: verificationId, resendToken: resendToken, phoneNumber: _phoneNumController.text),));
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {
                            AlertMessage().showAlert(context);
                          },
                        );


                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        fixedSize: const Size(100, 50),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      child: const Text("Confirm")),
                ],
              ),
            );
          });
        });
  }

}