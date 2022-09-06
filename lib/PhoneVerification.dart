import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'TextFieldDecoratorClass.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'SignUpPage2.dart';

class PhoneVerification extends StatefulWidget {
  String? verificationId, phoneNumber;
  int? resendToken;
  PhoneVerification({Key? key, this.verificationId, resendToken, this.phoneNumber}) : super(key: key);

  @override
  State<PhoneVerification> createState() => PhoneVerificationState();
}
class PhoneVerificationState extends State<PhoneVerification> {
  final TextFieldDecoratorClass _decorator = TextFieldDecoratorClass();
  String smsCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone verification"),
        backgroundColor: const Color.fromRGBO(255, 170, 0, 1),
      ),
      body: ListView(
        padding: const EdgeInsets.only(right: 30,left: 30),
        children: <Widget>[
          const SizedBox(height: 30,),
          Text("1/4",style: TextStyle(fontSize: 24, color: Colors.grey[600]),),
          const SizedBox(height:  100,),
        const Text(
              "Enter 6 digits verification code sent to your number",
              style: TextStyle(fontSize: 24),
            ),
          const SizedBox(height:  70,),
          Center(
            child: VerificationCode(
              textStyle: const TextStyle(fontSize: 20.0, color: Colors.black),
              keyboardType: TextInputType.number,
              underlineColor: const Color.fromRGBO(255, 185, 0, 1),
              length: 6,
              digitsOnly: true,
              cursorColor: Colors.black,
              clearAll: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'clear all',
                  style: TextStyle(fontSize: 14.0, decoration: TextDecoration.underline, color: Colors.blue[700]),
                ),
              ),
              onCompleted: (String value) {
                setState(() {
                  smsCode = value;
                });
              },
              onEditing: (bool value) {
                if (!value) FocusScope.of(context).unfocus();
              },
            ),
          ),
          const SizedBox(height: 30,),
          Center(
            child: ElevatedButton.icon(
              label: const Text("Confirm"),
              icon: const Icon(Icons.chevron_right),
              onPressed: () async {
                FirebaseAuth auth = FirebaseAuth.instance;
                PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verificationId.toString(), smsCode: smsCode);
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage2(phoneNumber: widget.phoneNumber,)));
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

    );
  }
}