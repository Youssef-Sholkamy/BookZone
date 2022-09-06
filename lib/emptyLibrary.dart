import 'package:flutter/material.dart';
import 'Books.dart';

class EmptyLibrary extends StatefulWidget {
  const EmptyLibrary({Key? key}) : super(key: key);

  @override
  State<EmptyLibrary> createState() => EmptyLibraryState();
}

class EmptyLibraryState extends State<EmptyLibrary> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.01,
                  right: MediaQuery.of(context).size.width * 0.01),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                  color: Colors.white, border: Border.all(color: Colors.grey)),
              child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: const [
                      Image(
                        image: AssetImage("design/images/cart.png"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Flexible(
                          child: Text(
                              "Your Library is empty looks like you haven't made a choice yet"))
                    ],
                  )),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.01,
                  right: MediaQuery.of(context).size.width * 0.01),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.56,
              decoration: BoxDecoration(
                  color: Colors.grey[200], border: Border.all(color: Colors.grey)),
              child: ListView(
                children: [
                  const Text("Need Suggestions?" , style: TextStyle(fontSize: 20),),
                  InkWell(
                    onTap: (){
                      Navigator.push(this.context, MaterialPageRoute(builder: (context) => Books(type: "",)));
                    },
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Color.fromRGBO(229, 199, 169, 1),
                        child: Center(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width*0.3,
                                  child: const Image(image: AssetImage("design/images/cover.jpg")),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width*0.3,
                                  child: const Text("Discover Books",style: TextStyle(fontSize: 20),),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width*0.3,
                                  child: const Icon(Icons.arrow_forward_ios_rounded, size: 50,),
                                ),

                              ],
                            )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
