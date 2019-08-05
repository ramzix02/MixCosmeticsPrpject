import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'screens/start_screen.dart';
import 'package:mix_cosmetics/screens/home_page.dart';
//import 'package:mix_cosmetics/screens/pagger_screen.dart';
//import 'package:mix_cosmetics/screens/sign_in_screen.dart';
//import 'package:mix_cosmetics/screens/sign_up_screen.dart';
//import 'screens/branches_screen.dart';
import 'package:mix_cosmetics/screens/start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/branches_screen.dart';
import 'screens/brands_screen.dart';

void main() => runApp(EasyLocalization(child: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var data;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Center(
        child: MaterialApp(
          title: 'Flutter Demo',
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            //app-specific localization
            EasylocaLizationDelegate(
                locale: data.locale ?? Locale('en'), path: 'resources/langs'),
          ],
          supportedLocales: [Locale('en'), Locale('ar')],
          locale: data.locale,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: GoIntroOrHome(),
          //initialRoute:'home_page_view' ,
          routes: {
            'start_page': (context) => StartScreen(),
            'home_page_view': (context) => HomePV(),
//            'page_viewer': (context) => IntroPageView(
//                  reversePager: false,
//                ),
//            'sign_in_page': (context) => SignInScreen(),
//            'sign_up_page': (context) => SignUpScreen(),
            'branches_page': (context) => BranchesMap(),
            'brands_page': (context) => Brands(),
          },
        ),
      ),
    );
  }
}

class GoIntroOrHome extends StatefulWidget {
  @override
  _GoIntroOrHomeState createState() => _GoIntroOrHomeState();
}

class _GoIntroOrHomeState extends State<GoIntroOrHome> {
  @override
  void initState() {
    setValue();
    super.initState();
  }

  void setValue() async {
    final prefs = await SharedPreferences.getInstance();
    int launchCount = prefs.getInt('counter') ?? 0;
    //prefs.setInt('counter', launchCount + 1);
    if (launchCount == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => StartScreen()));
      //print("first launch"); //setState to refresh or move to some other page
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>HomePV()));
      //print("Not first launch");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(body: buildCenterLoading());
  }

  Center buildCenterLoading() {
    return Center();
  }
}
