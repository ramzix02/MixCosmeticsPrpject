import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mix_cosmetics/beans/login_request/LoginRequest.dart';
import 'package:mix_cosmetics/screens/sign_up_screen.dart';
import 'package:mix_cosmetics/post_log_in.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:mix_cosmetics/Utils.dart';
import 'package:mix_cosmetics/screens/home_page.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}





class _SignUpScreenState extends State<SignInScreen> {

  String _locale = '';
  var userObj ,_user ;

  @override
  void initState(){
    //changeTheLocale('en');
    super.initState();
    getLocale().then(updateLocale);

  }

  void updateLocale(String locale) {
    this._locale= locale;
    print('xXx $_locale');
    //getData(_locale);
  }
  void updateUser(String user) {
    this._user= user;
    print('uUu $_user');
    //getData(_user);
  }

  String url = 'http://mixcosmetics.net/api/login';
  Future<LoginResponse> Login(String username, String password) async{
    var rqm = new LoginRequest(username, password).toJson();
    final response = await http.post('$url',
        headers: {"lang": _locale},
        body: rqm
    );

    return postFromJson(response.body);
  }

  //  _formKey and _autoValidate
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _name , _password;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/bg_sign_in.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 130, right: 30, left: 30),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0)),
              ),
              child: Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context).tr('signInWord'),
                          style:
                          TextStyle(fontFamily: 'BerlinBold', fontSize: 30),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: new TextFormField(
                        decoration: const InputDecoration(labelText: 'Name'),
                        keyboardType: TextInputType.text,
                        validator: validateName,
                        onSaved: (String val) {
                          _name = val;
                        },
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: new TextFormField(
                        obscureText: true,
                        decoration:
                        const InputDecoration(labelText: 'Password'),
                        keyboardType: TextInputType.text,
                        validator: validatePassword,
                        onSaved: (String val) {
                          _password = val;
                        },
                      ),
                    ),
                    //Text('Testtt  $_locale'),
                    Container(
                      padding: EdgeInsets.only(top: 25,bottom:0,right: 20,left: 20),
                      child: RaisedButton(
                        onPressed: _validateInputs,
                        child: Text(
                          AppLocalizations.of(context).tr('signin'),
                          style: TextStyle(
                              fontFamily: 'BerlinBold',
                              color: Colors.white,
                              fontSize: 20),
                        ),
                        color: Color.fromARGB(230, 28, 150, 210),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),

                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context).tr('signUpPage'),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'BerlinBold'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      print(_name);
      print(_password);

      Login(_name, _password).then((response){
        if(response.status.succeed == 1){
          debugPrint(response.status.message);
          //debugPrint(response.result.user.toString());
          userObj = response.result.user.toString();

          setUser(userObj);
          getUser().then(updateUser);

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePV()));
        }

       else{
          print('not registered!');
          _showDialog();
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
    if (value.length < 3)
      return 'Name must be more than 2 charater';
    else
      return null;
  }


  String validatePassword(String value) {
    if (value.length < 3)
      return 'Password must be more than 8 charaters';
    else
      return null;
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Login Failed"),
          content: new Text("Your Email &Password does not match a current user!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
