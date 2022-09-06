import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'SignInPage.dart';
import 'SignUpPage.dart';






class Welcome extends StatefulWidget {
  const Welcome({Key? key,}) : super(key: key);
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late BottomSignInSheet signIn;
  late BottomSignUpSheet signUp;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).viewPadding;
    double height2 = height - padding.top - padding.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: width,
                height: height2 * 0.60,
                child: const Image(
                  image: AssetImage("design/images/logo.png"),
                ),
              ),
              SizedBox(
                  width: width,
                  height: height2 * 0.40,
                  child: Container(
                    decoration: const ShapeDecoration(
                      color: Color.fromRGBO(255, 185, 0, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          )),
                    ),
                    child: SafeArea(
                      child: ListView(
                        children: <Widget>[
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Column(
                              children: const <Widget>[
                                Text(
                                  "Welcome",
                                  style: TextStyle(fontSize: 32),
                                ),

                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    signIn = BottomSignInSheet(context);
                                    signIn.bottomSheet();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    onPrimary: Colors.white,
                                    primary: Colors.black,
                                    fixedSize: const Size(100, 50),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                  ),
                                  child: const Text(
                                    "Sign In",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    signUp = BottomSignUpSheet(context);
                                    signUp.bottomSheet();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    onPrimary: Colors.black,
                                    primary: Colors.white,
                                    fixedSize: const Size(100, 50),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                  ),
                                  child: const Text(
                                    "Sign up",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          )),
    );
  }
}
