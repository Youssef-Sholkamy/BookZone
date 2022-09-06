import 'package:flutter/material.dart';

class AlertMessage {
  void showAlert(BuildContext context) {
    var alert = AlertDialog(
      title: Text("invalid"),
      content: Text("Something went wrong please try again"),
      actions: [
        ElevatedButton(onPressed: () {
          Navigator.pop(context);
        }, child: Text("Ok")),
      ],
    );

    showDialog(context: context, builder: (BuildContext context){return alert;});
  }
}