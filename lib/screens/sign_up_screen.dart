import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mix_cosmetics/screens/sign_in_screen.dart';
import 'package:mix_cosmetics/beans/register_request/SignUpRequest.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:mix_cosmetics/beans/register_request/post_sign_up.dart';
import 'package:mix_cosmetics/Utils.dart';
import 'package:mix_cosmetics/screens/home_page.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  //  _formKey and _autoValidate
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _name;
  String _userName;
  String _email;
  String _phone;
  String _password;
  var userObj ,_user ;

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  void updateUser(String user) {
    this._user= user;
    print('uUu $_user');
    //getData(_user);
  }

  String url = 'http://mixcosmetics.net/api/register';
  Future<SignUpResponse> SignUp(String username, String password ,String name, String email , String phone , String countryID) async{
    var rqm = new SignUpRequest(username,  password ,name,email , phone, countryID).toJson();
    final response = await http.post('$url',
        headers: {"lang": 'en'},
        body: rqm
    );
    //print(response.body);
    return postFromJson(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/bg_sign_up.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 130, right: 30, left: 30),
              //color: Colors.white,
//              width: 350.0,
//              height: 400.0,
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
                          AppLocalizations.of(context).tr('signUpWord'),
                          style:
                          TextStyle(fontFamily: 'BerlinBold', fontSize: 30),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: new TextFormField(
                        decoration: const InputDecoration(labelText: 'User Name'),
                        keyboardType: TextInputType.text,
                        validator: validateName,
                        onSaved: (String val) {
                          _userName = val;
                        },
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
                        decoration: const InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail,
                        onSaved: (String val) {
                          _email = val;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: new TextFormField(
                        decoration: const InputDecoration(labelText: 'Mobile'),
                        keyboardType: TextInputType.phone,
                        validator: validateMobile,
                        onSaved: (String val) {
                          _phone = val;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child:  TextFormField(
                        decoration:
                        InputDecoration(
                            labelText: 'Password',

                          icon: IconButton(
                            onPressed:_toggle ,
                            icon: Icon(_obscureText ?Icons.check_circle_outline:Icons.check_circle),
                          ),
                        ),

                        obscureText: _obscureText,
                        keyboardType: TextInputType.text,
                        validator: validatePassword,
                        onSaved: (String val) {
                          _password = val;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 25,bottom:0,right: 20,left: 20),
                      child: RaisedButton(
                        onPressed: _validateInputs,
                        child: Text(
                          AppLocalizations.of(context).tr('signup'),
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
                              builder: (context) => SignInScreen()),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context).tr('signInPage'),
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
      SignUp(_userName, _password ,_name,_email , _phone,  '1').then((response){
        //(_userName, _password ,_name,_email , _phone,  '1')
        print(response.status.succeed);
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
    if (value.length < 7)
      return 'Name must be more than 6 charater';
    else
      return null;
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
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

  String validatePassword(String value) {
    if (value.length < 8)
      return 'Password must be more than 7 charaters';
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
