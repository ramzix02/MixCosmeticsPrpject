import 'package:flutter/material.dart';
import 'package:mix_cosmetics/reusable_directory/reusable_drawer_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:mix_cosmetics/beans/CountriesResponse.dart';
import 'package:mix_cosmetics/beans/Countries.dart';
import 'package:mix_cosmetics/Utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';


class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}


class _SettingsState extends State<Settings> {

  Map data;
  List userData;
  String dropdownValue = '';
  String _locale = '';

  Future<CountriesResponse> getData(String lang) async {
    http.Response response = await http
        .get('http://mixcosmetics.net/api/countries', headers: {"lang": lang});
    if (response.statusCode == 200) {
      return CountriesResponse.fromJsonMap(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }


  _SettingsState() {
    getLocale().then((val) => setState(() {
      _locale = val;
      _locale=='en'? dropdownValue ='English':dropdownValue ='العربية';
    }));
  }


//  bool _userWatchIntro ;
  @override
  void initState() {
    //changeTheLocale('en');
    getLocale().then(updateLocale);
//    getUserWatchIntroFlag().then(updateWatchIntro);
    getData(_locale);

    super.initState();
  }
  void updateLocale(String locale) {
    this._locale = locale;
    print('xXx $_locale');
    //getData(_locale);
  }

//  boolLocale() {
//    getLocale().then((locale) {
//
//    });
//  }






  @override
  Widget build(BuildContext context) {
    //final c = context;
    var data = EasyLocalizationProvider.of(context).data;

    return WillPopScope(
      onWillPop:(){
        Navigator.pushReplacementNamed(context, 'home_page_view');
      } ,
      child: EasyLocalizationProvider(
        data: data,
        child: Scaffold(
          drawer: ReusableDrawerWidget(),
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Color.fromARGB(240, 28, 150, 210),
            title: Center(
              child: Text(
                'Settings',
                style: TextStyle(fontFamily: 'BerlinBold', fontSize: 30),
              ),
            ),
            actions: <Widget>[
              IconButton(
                padding: EdgeInsets.all(20),
                icon: Icon(Icons.add_shopping_cart),
                tooltip: 'Cart',
                onPressed: null,
              ),
            ],
          ),
          body: Stack(
            children: <Widget>[
              Container(
                height: 50,
                color: Color.fromARGB(240, 28, 150, 210),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: Container(
                  child: Container(
                    height: MediaQuery.of(context).size.height* 0.35,
                    width: MediaQuery.of(context).size.width,
//                padding: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7.0),
                      boxShadow: [BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),]
                  ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        FlatButton(
                          padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 15.0),
                            child: Text(AppLocalizations.of(context).tr('rate'),
                                style: TextStyle(
                                    fontSize: 25, fontFamily: 'BerlinBold')),
                            onPressed: null),
                        FlatButton(
                            padding: EdgeInsets.symmetric(vertical: 4.0,horizontal: 15.0),
                            child: Text(AppLocalizations.of(context).tr('share'),
                                style: TextStyle(
                                    fontSize: 25, fontFamily: 'BerlinBold')),
                            onPressed: _launchURL ),
                      ],
                    ),
                ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
_launchURL() async {
  const url = 'https://play.google.com/store/apps/details?id=com.spark.mixcosmetics';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}