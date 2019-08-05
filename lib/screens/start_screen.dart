import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:mix_cosmetics/beans/CountriesResponse.dart';
import 'package:mix_cosmetics/beans/Countries.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mix_cosmetics/screens/pagger_screen.dart';
import 'package:mix_cosmetics/Utils.dart';


class StartScreen extends StatefulWidget {
  StartScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Map data;
  List userData;
  String dropdownValue = 'English';

  Future<CountriesResponse> getData(String lang) async {
    http.Response response = await http
        .get('http://mixcosmetics.net/api/countries', headers: {"lang": lang});
    if (response.statusCode == 200) {
      return CountriesResponse.fromJsonMap(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  //String langCheck = 'en';
  String _locale = 'en';

//  bool _userWatchIntro ;
  @override
  void initState() {
    //changeTheLocale('en');
    getLocale().then(updateLocale);
//    getUserWatchIntroFlag().then(updateWatchIntro);
    getData(_locale);

    super.initState();
  }

//  void updateWatchIntro(bool flag) {
//    this._userWatchIntro= flag;
//    print('xXx $_userWatchIntro');
//    if(_userWatchIntro){
//      //print('flag is $_flag');
//      Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context) => HomePV()),
//      );
//    }
//  }

  void updateLocale(String locale) {
    this._locale = locale;
    print('xXx $_locale');
    //getData(_locale);
  }

  boolLocale() {
    getLocale().then((locale) {
      var reversePager;
      if (locale == 'ar') {
        reversePager = false;
      } 
      else if (locale == 'en'|| locale == null) {
        reversePager = true;
      }

      print('reversePager is ${reversePager}');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => IntroPageView(reversePager: reversePager)));
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;

    return EasyLocalizationProvider(
      data: data,
      child: new Scaffold(
        body: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/bg_intro_settings.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 70,
              left: 50,
              right: 50,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 300.0,
                      color: Colors.white,
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            style:
                                TextStyle(color: Colors.black, fontSize: 25.0),
                            elevation: 2,
                            isDense: true,
                            iconSize: 40.0,
                            value: dropdownValue,
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                                if (dropdownValue == 'English') {
                                  setState(() {
                                    data.changeLocale(Locale("en"));
                                    setLocale('en');
                                    updateLocale('en');
//                                    getData('en');
                                  });
                                  //langCheck = 'en';
                                } else if (dropdownValue == 'العربية') {
                                  setState(() {
                                    data.changeLocale(Locale("ar"));
                                    setLocale('ar');
                                    updateLocale('ar');
//                                    getData('ar');
                                  });
                                  //getData(_locale);
                                  // langCheck = 'ar';
                                }
                              });
                            },
                            items: <String>['English', 'العربية']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Row(
                                  children: <Widget>[
                                    value == "English"
                                        ? Image.asset('assets/lang@3x.png',
                                            width: 27)
                                        : Image.asset('assets/ic_lang_ar.png',
                                            width: 27),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(value)
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: FutureBuilder<CountriesResponse>(
                        future: getData(_locale),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
//                            print(
//                                "Countries: ${snapshot.data.data.countries.length}");
                            var dropdownValue = snapshot.data.data.countries[0];
                            setCountry(dropdownValue.toString());
                            return Container(
                              width: 300.0,
                              color: Colors.white,
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  // to solve .. The DropdownMenuItems I add are always wider than the dropdown itself
                                  child: DropdownButton<Country>(
                                    isExpanded: true,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 25.0),
                                    elevation: 2,
                                    isDense: true,
                                    iconSize: 40.0,
                                    value: dropdownValue,
                                    onChanged: (Country newValue) {
                                      setState(() {
                                        dropdownValue = newValue;
                                      });
                                    },
                                    items: snapshot.data.data.countries
                                        .map<DropdownMenuItem<Country>>(
                                            (Country value) {
                                      return DropdownMenuItem<Country>(
                                        value: value,
                                        child: Row(
                                          children: <Widget>[
                                            Image.network(
                                              value.image,
                                              width: 27,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(value.name )
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            );
                            //finish
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }

                          // By default, show a loading spinner.
                          return CircularProgressIndicator();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 300.0,
                      child: RaisedButton(
                        color: Colors.white,
                        //padding: EdgeInsets.symmetric(horizontal: 120,),
                        shape: OutlineInputBorder(),
                        onPressed: () {
                          //setUserWatchIntroFlag(null);
//                          if(_userWatchIntro == false)
//                          {boolLocale();}
//                          else{
                          boolLocale();
//                          }
                        },
                        child: Text(AppLocalizations.of(context).tr('next'),
                            style: TextStyle(
                                fontSize: 25, fontFamily: 'BerlinBold')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
