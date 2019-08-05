import 'package:flutter/material.dart';
import 'package:mix_cosmetics/reusable_directory/reusable_drawer_widget.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:(){
        Navigator.pushReplacementNamed(context, 'home_page_view');
      },
      child: Scaffold(
        drawer: ReusableDrawerWidget(),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromARGB(240, 28, 150, 210),
          title: Center(
            child: Text(
              'Profile',
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
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.circular(7.0),
                    boxShadow: [BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(shape: BoxShape.circle,boxShadow: [BoxShadow(
                          color: Colors.grey,
                          blurRadius: 9.0,
                        ),]),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:
                          AssetImage('assets/icons/ic_profile.png'),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(hintText: 'ali',labelText: 'User Name',labelStyle: TextStyle(fontFamily:  "BerlinLite"),hintStyle: TextStyle(fontFamily:  "BerlinLite")),
                            ),
                            TextFormField(
                              decoration: InputDecoration(hintText: 'ali maher',labelText: 'Name',labelStyle: TextStyle(fontFamily:  "BerlinLite"),hintStyle: TextStyle(fontFamily:  "BerlinLite")),
                            ),
                            TextFormField(
                              decoration: InputDecoration(hintText: 'ali@cloudspark.com',labelText: 'Email',labelStyle: TextStyle(fontFamily:  "BerlinLite"),hintStyle: TextStyle(fontFamily:  "BerlinLite")),
                            ),
                            TextFormField(
                              decoration: InputDecoration(hintText: '111111',labelText: 'Phone Number',labelStyle: TextStyle(fontFamily:  "BerlinLite"),hintStyle: TextStyle(fontFamily:  "BerlinLite")),
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Password',labelStyle: TextStyle(fontFamily:  "BerlinLite"),hintStyle: TextStyle(fontFamily:  "BerlinLite")),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Container(
                                height: 50,
                                child: RaisedButton(
//                                elevation: 7.0,
//                                textColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                    color:Color.fromARGB(240, 28, 150, 210) ,
                                    disabledColor: Color.fromARGB(240, 28, 150, 210) ,
                                    child: Text('Save',
                                      style:
                                      TextStyle(color: Colors.white,fontSize: 22.0,fontFamily:  "BerlinBold"),),
                                    onPressed: null ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                height: 50,
                                child: RaisedButton(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                    color:Color.fromARGB(240, 28, 150, 210) ,
                                    disabledColor: Color.fromARGB(240, 28, 150, 210) ,
                                    child: Text('Sign Out',
                                      style:
                                        TextStyle(color: Colors.white,fontSize: 22.0,fontFamily:  "BerlinBold"),),
                                    onPressed: null),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
