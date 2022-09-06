
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';


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
  int? _genderRadioValue = 0;

  bool changeEmailPassObs = true, changePass1 = true, changePass2 = true;

  @override
  Widget build(BuildContext context) {
  //  localizationsDelegates: const [
    //  AppLocalizations.delegate,
      //GlobalMaterialLocalizations.delegate,
      //GlobalWidgetsLocalizations.delegate,
      //GlobalCupertinoLocalizations.delegate,
    //];
    supportedLocales: const [
      Locale('en', ''),
      Locale('ar', ''),
    ];

    return Scaffold(
        body: SafeArea(
          child: Column(children: [
            SettingsGroup(
              title: "Account",
              children: <Widget>[
                SimpleSettingsTile(
                  title: "Account Info",
                  subtitle: "",
                  child: SettingsScreen(title: "Account Info", children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                      child: const TextField(
                        decoration: InputDecoration(
                            label: Text("Email"),
                            floatingLabelBehavior: FloatingLabelBehavior.auto),
                        enabled: false,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                      child: const TextField(
                        decoration: InputDecoration(
                            label: Text("First name"),
                            floatingLabelBehavior: FloatingLabelBehavior.auto),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                      child: const TextField(
                        decoration: InputDecoration(
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
                                firstDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year,
                                    DateTime.now().month + 3, DateTime.now().day));
                            if (newCheckout != null) {
                              _dobController.text =
                              "${newCheckout.day}/${newCheckout.month}/${newCheckout.year}";
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
                                      Text("male")
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
                                      Text("female")
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
                            onPressed: () {}, child: const Text("Save")))
                  ]),
                ),
                SimpleSettingsTile(
                  title: "Saved Cards",
                  subtitle: "",
                ),
                SimpleSettingsTile(
                  title: "Change Email",
                  subtitle: "",
                  child: SettingsScreen(children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: const TextField(
                        decoration: InputDecoration(hintText: "New email"),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: const TextField(
                        decoration: InputDecoration(hintText: "Confirm new email"),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.all(20),
                        child: StatefulBuilder(builder: (context, setNewState) {
                          return TextField(
                            decoration: InputDecoration(
                              hintText: "Password",
                              suffixIcon: IconButton(icon: const Icon(Icons.remove_red_eye), onPressed: () {
                                setNewState(() {
                                  changeEmailPassObs = !changeEmailPassObs;
                                });
                              },),
                            ),
                            obscureText: changeEmailPassObs,
                          );
                        },)
                    ),
                    Container(
                        padding: const EdgeInsets.all(20),
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text("Submit")))
                  ]),
                ),
                SimpleSettingsTile(
                  title: "Change Password",
                  subtitle: "",
                  child: SettingsScreen(children: [
                    Container(
                        padding: const EdgeInsets.all(20),
                        child: StatefulBuilder(builder: (context, setNewState) {
                          return TextField(
                            obscureText: changePass1,
                            decoration: InputDecoration(
                              hintText: "Current password",
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
                        child: StatefulBuilder(builder: (context, setNewState) {
                          return TextField(
                            obscureText: changePass2,
                            decoration: InputDecoration(
                              hintText: "New password",
                              suffixIcon: IconButton(icon: const Icon(Icons.remove_red_eye), onPressed: () {
                                setNewState(() {
                                  changePass2 = !changePass2;
                                });
                              },),
                            ),
                          );
                        },)
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: const TextField(
                        decoration:
                        InputDecoration(hintText: "Confirm new password"),
                        obscureText: true,
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.all(20),
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text("Submit")))
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            SettingsGroup(title: "Language and country", children: [
           /*  DropDownSettingsTile(
                title: "Language",
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
              ),*/
              SimpleSettingsTile(
                title: "Country",
                subtitle: "",
              ),
            ]),
            const SizedBox(
              height: 20,
            ),
            SettingsGroup(title: "Log out", children: [
              SimpleSettingsTile(
                title: "Log out",
                subtitle: "",
              ),
            ])
          ]),
        ));
  }
}