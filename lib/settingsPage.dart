import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:provider/provider.dart';
import 'LanguageChangeProvider.dart';
import 'generated/l10n.dart';
import 'main.dart';


class settingsPage extends StatefulWidget {
  const settingsPage({Key? key}) : super(key: key);

  @override
  State<settingsPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<settingsPage> {
  static const keyEmail = "key-email";
  static const keyLanguage = "key-language";

  late DateTime DOB;
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _accountInfoEmailController = TextEditingController();
  final TextEditingController _accountInfofNameController = TextEditingController();
  final TextEditingController _accountInfolNameController = TextEditingController();
  final TextEditingController _changeEmailController = TextEditingController();
  final TextEditingController _changeEmailConfirmController = TextEditingController();
  final TextEditingController _changePassController = TextEditingController();
  final TextEditingController _changePassConfirmController = TextEditingController();
  int? _genderRadioValue = 0;

  bool changePass1 = true;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  initialize() async {
    var collection = FirebaseFirestore.instance.collection('users').doc(auth!.currentUser!.uid);
    var docSnapshot = await collection.get();
    Map<String, dynamic> data = docSnapshot.data()!;
    setState(() {
      _dobController.text = data["Date of birth"];
      _accountInfoEmailController.text = auth.currentUser!.email!;
      _accountInfofNameController.text = data["First name"];
      _accountInfolNameController.text = data["Last name"];
      if(data["Gender"] == "Male"){
        _genderRadioValue = 0;
      }
      else{
        _genderRadioValue = 1;
      }
    });
  }

  updateAccountInfo(){
    String gender = "Male";
    if(_genderRadioValue == 1){
      gender = "Female";
    }

    var collection = FirebaseFirestore.instance.collection('users').doc(auth!.currentUser!.uid);
    collection.update(
        {"First name": _accountInfofNameController.text,
        "Last name": _accountInfolNameController.text,
        "Date of birth": _dobController.text,
        "Gender": gender}).then((value) => print("Profile updated"));
  }

  changeEmailAddress(){
    if(_changeEmailController.text == _changeEmailConfirmController.text){
      try{
        auth.currentUser!.updateEmail(_changeEmailController.text);
      }
      catch(err) {
        if(err == "requires-recent-login"){
          //Go to login page
        }

      }
    }
  }

  changePassword(){
    if(_changePassController.text == _changePassConfirmController.text){
      try{
        auth.currentUser!.updatePassword(_changePassConfirmController.text);
      }
      catch(err) {
        if(err == "requires-recent-login"){
          //Go to login page
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color.fromRGBO(255, 185, 0, 1),
      ),
        body: SafeArea(
      child: Column(children: [
        SettingsGroup(
          title: "Account",
          children: <Widget>[
            SimpleSettingsTile(
              title: S.of(context).AccountInfo,
              subtitle: "",
              child: SettingsScreen(title: "Account Info", children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: TextField(
                    controller: _accountInfoEmailController,
                    decoration: const InputDecoration(
                        label: Text("Email"),
                        floatingLabelBehavior: FloatingLabelBehavior.auto),
                    enabled: false,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: TextField(
                    controller: _accountInfofNameController,
                    decoration: const InputDecoration(
                        label: Text("First name"),
                        floatingLabelBehavior: FloatingLabelBehavior.auto),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: TextField(
                    controller: _accountInfolNameController,
                    decoration: const InputDecoration(
                        label: Text("Last name"),
                        floatingLabelBehavior: FloatingLabelBehavior.auto),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: GestureDetector(
                      child: TextField(
                        enabled: false,
                        controller: _dobController,
                        decoration: const InputDecoration(
                            label: Text("Date of birth"),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            suffixIcon: Icon(Icons.calendar_month_rounded)),
                      ),
                      onTap: () async {
                        DateTime? newCheckout = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(DateTime.now().year - 100),
                            lastDate: DateTime(DateTime.now().year + 1) );
                        if (newCheckout != null) {
                          _dobController.text =
                              "${newCheckout.year}-${newCheckout.month}-${newCheckout.day}";
                        }
                      },
                    )),
                Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: const Text("Gender")),
                Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                    child: StatefulBuilder(
                      builder: (context, setNewState) {
                        return Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setNewState(() {
                                  _genderRadioValue = 0;
                                });
                              },
                              child: Row(
                                children: [
                                  Radio(
                                    value: 0,
                                    groupValue: _genderRadioValue,
                                    onChanged: (int? value) {
                                      setNewState(() {
                                        _genderRadioValue = value;
                                      });
                                    },
                                  ),
                                  Text("Male")
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setNewState(() {
                                  _genderRadioValue = 1;
                                });
                              },
                              child: Row(
                                children: [
                                  Radio(
                                    value: 1,
                                    groupValue: _genderRadioValue,
                                    onChanged: (int? value) {
                                      setNewState(() {
                                        _genderRadioValue = value;
                                      });
                                    },
                                  ),
                                  const Text("Female")
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    )),
                Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          fixedSize: const Size(100, 50),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                        ),
                        onPressed: () {
                          updateAccountInfo();
                        }, child: const Text("Save")))
              ]),
            ),
            SimpleSettingsTile(
              title: S.of(context).ChangeEmail,
              subtitle: "",
              child: SettingsScreen(children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: _changeEmailController,
                    decoration: const InputDecoration(hintText: "New email"),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: _changeEmailConfirmController,
                    decoration: const InputDecoration(hintText: "Confirm new email"),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          fixedSize: const Size(100, 50),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                        ),
                        onPressed: () {
                         changeEmailAddress();
                        }, child: const Text("Submit")))
              ]),
            ),
            SimpleSettingsTile(
              title: S.of(context).ChangePassword,
              subtitle: "",
              child: SettingsScreen(children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: StatefulBuilder(builder: (context, setNewState) {
                    return TextField(
                      controller: _changePassController,
                      obscureText: changePass1,
                      decoration: InputDecoration(
                        hintText: "New password",
                        suffixIcon: IconButton(icon: const Icon(Icons.remove_red_eye), onPressed: () {
                          setNewState(() {
                            changePass1 = !changePass1;
                          });
                        },),
                      ),
                    );
                  },)
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: _changePassConfirmController,
                    decoration: const InputDecoration(hintText: "Confirm new password"),
                    obscureText: true,
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          fixedSize: const Size(100, 50),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                        ),
                        onPressed: () {
                          changePassword();
                        }, child: const Text("Submit")))
              ]),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
        SettingsGroup(title: "Language and country", children: [
          DropDownSettingsTile(
            title: S.of(context).Language,
            subtitle: "",
            selected: 0,
            values: const <int, String>{
              0: "English",
              1: "العربية"
            },
            onChange: (p0) {
              if(p0 == 1){
                context.read<LanguageChangeProvider>().changeLanguage("ar");
              }
              else{
                context.read<LanguageChangeProvider>().changeLanguage("en");
              }
            },
            settingKey: keyLanguage,
          ),
        ]),
        const SizedBox(
          height: 20,
        ),
        SettingsGroup(title: S.of(context).LogOut, children: [
          SimpleSettingsTile(
            title: S.of(context).LogOut,
            subtitle: "",
            child: TextButton(onPressed: () {
              auth.signOut();

              Navigator.push(context,MaterialPageRoute(builder: (context)=>MyApp()));
            },
                child: const Text("")),
          ),
        ])
      ]),
    ));
  }
}
