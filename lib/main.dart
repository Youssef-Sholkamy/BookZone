import 'package:bookzila/LanguageChangeProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart' as settings;
import 'package:provider/provider.dart';
import 'Welcome.dart';
import 'HomePage.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';




void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await settings.Settings.init(cacheProvider: settings.SharePreferenceCache());
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FirebaseAuth auth = FirebaseAuth.instance;

  runApp(const MyApp());

  FlutterNativeSplash.remove();


}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

@override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return ChangeNotifierProvider<LanguageChangeProvider>(
      create: (context) => LanguageChangeProvider(),
      child: Builder(builder: (context) =>
      MaterialApp(
        locale: Provider.of<LanguageChangeProvider>(context, listen: true).currentLocale,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color:  Color.fromRGBO(255, 185, 0, 1),),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder:(context,snapshot) {
            if(snapshot.hasData){
              return HomePage();
            }
            else{
              return const Welcome();
            }
        },
        ),
      ),
    )));

  }
}
