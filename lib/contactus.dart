import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';


class contactus extends StatefulWidget {
  const contactus({Key? key}) : super(key: key);
  @override
  State<contactus> createState() => _contactusState();}

class _contactusState extends State<contactus> {


  @override
  Widget build(BuildContext context) {


    return MaterialApp(

        home: Scaffold(

     body:ContactUs(cardColor: Colors.white,
          textColor: Colors.teal.shade900,
          logo: AssetImage('images/OIP.jpg'),
          email: 'yossef_mos_123@hotmail.com',
          companyName: 'BOOK ZONE',
          companyColor: Colors.teal.shade100,
          dividerThickness: 2,


          taglineColor: Colors.teal.shade100,
        )
    )
        );

  }
}