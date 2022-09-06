import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'BookCategories.dart';
import 'Books.dart';

class StorePage extends StatefulWidget {
  FirebaseAuth? auth;
  StorePage({Key? key, this.auth}) : super(key: key);

  @override
  State<StorePage> createState() => StorePageState();

}

class StorePageState extends State<StorePage> {
  late String timePeriod;
  String? name = "";
  final _searchController = TextEditingController();
  BookCategories categoryList = BookCategories();

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
    if (DateTime.now().hour >= 0 && DateTime.now().hour <= 12) {
      timePeriod = "Morning";
    } else {
      timePeriod = "Evening";
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        children: [
          Container(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 185, 0, 1),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.12,
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  onEditingComplete: (){
                    print(_searchController.text);
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.27,
                    left: MediaQuery.of(context).size.width * 0.03,
                    right: MediaQuery.of(context).size.width * 0.03,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: BookCategories(),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.32,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.5,
                  left: MediaQuery.of(context).size.width * 0.03,
                  right: MediaQuery.of(context).size.width * 0.03,
                ),
                child: ListView(
                  children: [
                    Text("Good $timePeriod, $name  ",style: const TextStyle(fontSize: 20)),
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

          )
          ),

        ],
      )),
    );
  }
}
