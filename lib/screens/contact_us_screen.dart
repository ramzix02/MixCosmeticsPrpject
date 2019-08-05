import 'package:flutter/material.dart';
import 'package:mix_cosmetics/reusable_directory/reusable_drawer_widget.dart';
import 'package:mix_cosmetics/beans/network_helper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mix_cosmetics/beans/contact_us_request/post_contact_us.dart';
import 'package:mix_cosmetics/beans/contact_us_request/ContactUsRequest.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

String url = "http://mixcosmetics.net/api/contact";
ContactUsNetwork networkHelper = ContactUsNetwork(url, 'en');

class _ContactUsState extends State<ContactUs> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _userName,_email,_phone,_message;

  String url = 'http://mixcosmetics.net/api/contact';
  Future<ContactUsResponse> ContactUs(String username, String email ,String phone, String message ) async{
    var rqm = new ContactUsRequest(username,email,phone,message).toJson();
    final response = await http.post('$url',
        headers: {"lang": 'en'},
        body: rqm
    );
    //print(response.body);
    return postFromJson(response.body);
  }


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
              'Contact Us',
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
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: ListView(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5.0,
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Name',
                                  labelStyle: TextStyle(fontFamily: "BerlinLite")),
                              keyboardType: TextInputType.text,
                              validator: validateName,
                              onSaved: (String val) {
                                _userName = val;
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(fontFamily: "BerlinLite")),
                              keyboardType: TextInputType.emailAddress,
                              validator: validateEmail,
                              onSaved: (String val) {
                                _email = val;
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                labelStyle: TextStyle(fontFamily: "BerlinLite"),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: validateMobile,
                              onSaved: (String val) {
                                _phone = val;
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Message',
                                  labelStyle: TextStyle(fontFamily: "BerlinLite"),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 30.0)),
                              keyboardType: TextInputType.text,
                              validator: validateMassage,
                              onSaved: (String val) {
                                _message = val;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Container(
                                height: 50,
                                child: RaisedButton(
//                                elevation: 7.0,
//                                textColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0)),
                                    color: Color.fromARGB(240, 28, 150, 210),
                                    disabledColor:
                                        Color.fromARGB(240, 28, 150, 210),
                                    child: Text(
                                      'Send',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22.0,
                                          fontFamily: "BerlinBold"),
                                    ),
                                    onPressed: _validateInputs),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 19.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                              ),
                            ]),
                        child: FutureBuilder(
                            future: networkHelper.getPages(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                                  //print(snapshot.data);
                                  if (snapshot.data == null) {
                                    return Container(
                                        child: Center(
                                            child: Center(child: SpinKitWave(
                                              color: Colors.lightBlueAccent,
                                              size: 50.0,
                                            ),)
                                        )
                                    );
                                  } else return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  FlatButton(
                                      child: Text('Phone : ${snapshot.data[0].phone}'),
                                      onPressed: null),
                                  FlatButton(
                                      child: Text('Mobile : ${snapshot.data[0].mobile}'),
                                      onPressed: null),
                                  FlatButton(
                                      child: Text('Email : ${snapshot.data[0].email}'),
                                      onPressed: null),
                                ],
                              );
                            }),
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
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      var msg;
      ContactUs(_userName, _email ,_phone,_message).then((response){
        //(_userName, _password ,_name,_email , _phone,  '1')
        print(response.status);
        if(response.status == 1){
          debugPrint(response.message);
          msg = response.message;
          _showDialog(msg);
          //debugPrint(response.result.user.toString());
          //userObj = response.result.user.toString();

          //setUser(userObj);
          //getUser().then(updateUser);

//          Navigator.pushReplacement(
//              context,
//              MaterialPageRoute(builder: (context) => HomePV()));
        }

        else{
          print('Something went wrong!');
          msg = response.message;
          _showDialog(msg);
        }

      });
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }
  String validateName(String value) {
    if (value.length < 7)
      return 'Name must be more than 6 charater';
    else
      return null;
  }
  String validateMassage(String value) {
    if (value.length < 3)
      return 'Please enter your message..';
    else
      return null;
  }
  String validateMobile(String value) {
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
  void _showDialog(var msg) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Bingo !"),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context,'home_page_view' );
              },
            ),
          ],
        );
      },
    );
  }

}
