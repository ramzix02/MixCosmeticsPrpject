//import 'package:flutter/material.dart';
//import 'package:mix_cosmetics/main.dart';
//import 'package:mix_cosmetics/reusable_directory/reusable_text.dart';
//import 'package:easy_localization/easy_localization.dart';
//import 'package:mix_cosmetics/screens/sign_up_screen.dart';
//import 'package:mix_cosmetics/screens/sign_in_screen.dart';
//
//
//
//class SignScreen extends MyApp {
//
//
//  @override
//  Widget build(BuildContext context) {
//    var data = EasyLocalizationProvider.of(context).data;
//    return EasyLocalizationProvider(
//      data: data,
//      child: Scaffold(
//        body: Stack(
//          alignment: Alignment.bottomCenter,
//          children: <Widget>[
//            new Container(
//              decoration: new BoxDecoration(
//                image: new DecorationImage(
//                  image: new AssetImage("assets/bg_intro_sign.png"),
//                  fit: BoxFit.cover,
//                ),
//              ),
//            ),
//            Column(
//              mainAxisAlignment: MainAxisAlignment.end,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: <Widget>[
//                new ReusableTxt(
//                  txt1: AppLocalizations.of(context).tr('discover'),
//                  txt2: AppLocalizations.of(context).tr('latest'),
//                  txt3: AppLocalizations.of(context).tr('shop'),
//                  txt4: AppLocalizations.of(context).tr('we'),
//                ),
//
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    RaisedButton(
//                      onPressed: () {
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => SignInScreen()),
//                        );
//                      },
//                      child: Text(AppLocalizations.of(context).tr('signin'),style: TextStyle(fontFamily: 'BerlinBold'),),
//                      disabledColor: Colors.white,
//                      shape: OutlineInputBorder(),
//                      padding: EdgeInsets.fromLTRB(30, 3, 30, 3),
//                    ),
//                    SizedBox(
//                      width: 15,
//                    ),
//
//                    RaisedButton(
//                      onPressed: () {
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => SignUpScreen()),
//                        );
//                      },
//                      child: Text(AppLocalizations.of(context).tr('signup'),style: TextStyle(fontFamily: 'BerlinBold'),),
//                      disabledColor: Colors.white,
//                      shape: OutlineInputBorder(),
//                      padding: EdgeInsets.fromLTRB(30, 3, 30, 3),
//                    ),
//                  ],
//                ),
//                Padding(
//                  padding: const EdgeInsets.only(top: 10, bottom: 40),
//                  child: FlatButton(
//                    onPressed: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => SignInScreen()),
//                      );
//                    },
//                    child: Text(
//                      AppLocalizations.of(context).tr('skip'),
//                      style: TextStyle(color: Colors.pink, fontSize: 20,fontFamily: 'BerlinBold'),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
