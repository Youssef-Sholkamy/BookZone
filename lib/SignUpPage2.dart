import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'SignUpPage3.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'AlertMessage.dart';


class SignUpPage2 extends StatefulWidget {
  String? phoneNumber;
  SignUpPage2({Key? key,  this.phoneNumber}) : super(key: key);

  @override
  State<SignUpPage2> createState() => SignUpPage2State();
}

class SignUpPage2State extends State<SignUpPage2> {
  DateTime dob = DateTime.now();
  String dropValue = "Male";
  List<String> gender = ["Male", "Female"];
  final _lNameController = TextEditingController();
  final _fNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool nameValidator(String name){
      for(int i = 0; i < name.length; i++){
        if(!name[i].contains(RegExp("[A-Za-z]"))){
          return false;
        }
      }
      return true;
    }


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
            Text("2/4",style: TextStyle(fontSize: 24, color: Colors.grey[600]),),
            const SizedBox(height: 80,),
            Center(
              child: TextField(
                textInputAction: TextInputAction.next,
                style: const TextStyle(
                    fontFamily: "Arial",
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                keyboardType: TextInputType.text,
                controller: _fNameController,
                decoration: const InputDecoration(
                  hintText: "First Name",
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
                controller: _lNameController,
                decoration: const InputDecoration(
                  hintText: "Last Name",
                ),
              ),
            ),
            const SizedBox(height: 40,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[350],
                fixedSize: const Size(100, 50),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
              ),
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: dob,
                  firstDate: DateTime(dob.year - 100),
                  lastDate: DateTime(dob.year + 1),
                );
                if (newDate == null) return;
                setState(() {
                  dob = newDate;
                });
              },
              child: Text(
                "${dob.year.toString()} / ${dob.month.toString()} / ${dob.day.toString()}",
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 30,),
            Center(
              child: DropdownButton<String>(
                iconSize: 40,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
                onChanged: (String? value) {
                  setState(() {
                    dropValue = value.toString();
                  });
                },
                items: gender.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                value: dropValue,
              ),
            ),
            const SizedBox(height: 30,),
            Center(
              child: ElevatedButton.icon(

                label: const Text("Next",style: TextStyle(fontSize: 20),),
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  if(nameValidator(_fNameController.text) && nameValidator(_lNameController.text)){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage3(fName: _fNameController.text,lName: _lNameController.text,gender: dropValue, dob: dob, phoneNumber: widget.phoneNumber)));
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