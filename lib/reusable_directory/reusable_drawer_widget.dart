import 'package:flutter/material.dart';
import 'package:mix_cosmetics/screens/brands_screen.dart';
import 'package:mix_cosmetics/screens/home_page.dart';
import 'package:mix_cosmetics/screens/branches_screen.dart';
import 'package:mix_cosmetics/screens/profile_screen.dart';
import 'package:mix_cosmetics/screens/history_screen.dart';
import 'package:mix_cosmetics/screens/favourite_screen.dart';
import 'package:mix_cosmetics/screens/contact_us_screen.dart';
import 'package:mix_cosmetics/screens/settings_screen.dart';
import 'package:mix_cosmetics/screens/about_us.dart';
import 'package:mix_cosmetics/screens/start_screen.dart';
import 'package:mix_cosmetics/screens/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mix_cosmetics/screens/sign_in_screen.dart';
import 'package:mix_cosmetics/Utils.dart';
import 'dart:convert';
import 'package:mix_cosmetics/post_log_in.dart';

class ReusableDrawerWidget extends StatefulWidget {
  @override
  _ReusableDrawerWidgetState createState() => _ReusableDrawerWidgetState();
}

class _ReusableDrawerWidgetState extends State<ReusableDrawerWidget> {
  String _user;
  void userLoggingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    String loggedStatus = prefs.getString('CurrentUser') ?? 'visitor';
    //prefs.setString('counter', launchCount + 1);
  }

  @override
  void initState() {
    getUser().then(updateUser);
    super.initState();
  }

  void updateUser(String user) {
    this._user = json.encode(user);
    print('uUu $_user');
    //getData(_user);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.4, 0.6, 0.9],
            colors: [
              Color.fromARGB(200, 218, 223, 105),
              Colors.white,
              Colors.white,
              Color.fromARGB(200, 47, 150, 199),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => {
                        Navigator.of(context).pop(),
                        (_user == 'null')
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInScreen()),
                              )
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileEdit()),
                              )
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('assets/icons/ic_profile.png'),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Visitor',

                      //_user.name,
                      style: TextStyle(fontFamily: 'BerlinBold', fontSize: 22),
                    ),
                  ],
                ),
              ),
            ),
            new ReusableDrawerItem(
                'assets/icons/ic_nav_home.png', 'Home', HomePV()),
            new ReusableDrawerItem(
                'assets/icons/ic_nav_brands.png', 'Brands', Brands()),
            new ReusableDrawerItem(
                'assets/icons/ic_nav_branches.png', 'Branches', BranchesMap()),
            new ReusableDrawerItem(
                'assets/icons/ic_nav_profile.png', 'Profile', ProfileEdit()),
            new ReusableDrawerItem(
                'assets/icons/ic_nav_history.png', 'History', History()),
            new ReusableDrawerItem(
                'assets/icons/ic_nav_favorite.png', 'Favorite', Favorite()),
            new ReusableDrawerItem('assets/icons/ic_nav_contact_us.png',
                'Contact Us', ContactUs()),
            new ReusableDrawerItem(
                'assets/icons/ic_nav_settings.png', 'Settings', Settings()),
            //AboutUs
            new ReusableDrawerItem(
                'assets/icons/eye@3x.png', 'About Us', AboutUs()),
          ],
        ),
      ),
    );
  }
}

var oldRoute = 'HomePV';

class ReusableDrawerItem extends StatelessWidget {
  ReusableDrawerItem(this.iconLocation, this.iconText, this.newRoute);
  final String iconLocation, iconText;
  final newRoute;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.0),
      child: Container(
//        decoration: (newRoute.toString() == oldRoute )?BoxDecoration(color: Color.fromARGB(35, 28, 150, 210),borderRadius: BorderRadius.circular(11.0),border: Border.fromBorderSide(BorderSide(width: 1.0))):null,
        child: FlatButton(
          onPressed: () {
//            if(newRoute.toString() == oldRoute){
//              Navigator.pop(context);
//            }
//            else{
//            oldRoute = newRoute.toString() ;
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => newRoute),
            );
//            }
          },
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Image.asset(
                iconLocation,
                width: 30,
                color: Colors.black,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                iconText,
                style: TextStyle(fontFamily: 'BerlinBold', fontSize: 22),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget reusableAppBar = AppBar(
  elevation: 0.0,
  backgroundColor: Color.fromARGB(240, 28, 150, 210),
  title: Center(
    child: Text(
      'Brands',
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
);
