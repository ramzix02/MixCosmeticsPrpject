import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

setLocale(String locale) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("localization", locale);
}

Future<String> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String locale = prefs.getString("localization");
  return locale;
}

setUserWatchIntroFlag(int flag) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt("Flag", flag);
  //print(flag);
}

Future<int> getUserWatchIntroFlag() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int flag = prefs.getInt("Flag");
  return flag;
}


setUser(String user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("CurrentUser", user);
}

Future<String> getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String user = prefs.getString("CurrentUser");
  return user;
}


setCountry(String country) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("Country", country);
  //print(country);
}

Future<String> getCountry() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String country = prefs.getString("Country");
  return country;
}