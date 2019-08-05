import 'package:flutter/material.dart';

class ReusableTF extends StatelessWidget {

  ReusableTF({@required this.txtLable });
  final String txtLable;
//  final Widget textB;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      foregroundDecoration: BoxDecoration(
          border: Border(
              bottom:BorderSide(
                color: Colors.black,
              )
          )),
      child: TextField(
        //obscureText: true,
        //keyboardAppearance: Brightness.dark,
        //keyboardType: TextInputType.numberWithOptions(),
        decoration: InputDecoration(
          alignLabelWithHint: true,
          labelText: txtLable,
          border: InputBorder.none,
          // hintText: 'User',
        ),
      ),
    );
  }
}