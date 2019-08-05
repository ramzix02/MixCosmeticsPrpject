import 'package:flutter/material.dart';
class ReusableTxt extends StatelessWidget {
  ReusableTxt({ @required this.txt1 , this.txt2 , this.txt3 ,this.txt4});
  final String txt1;
  final String txt2;
  final String txt3;
  final String txt4;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: <Widget>[
        Expanded
          (flex: 2,
            child: Container()),
        Expanded
          (flex: 2,
            child: Container()),
        Expanded(
          flex: 4,
          child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(txt1, style: TextStyle(fontFamily: 'BerlinLite',fontSize: 20.0),),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    txt2,
                    style: TextStyle(fontSize: 35,
                        fontStyle: FontStyle.normal,fontWeight: FontWeight.w700,fontFamily: 'BerlinBold',),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(txt3,style: TextStyle(fontSize: 20,
                      fontStyle: FontStyle.normal,fontWeight: FontWeight.w400,fontFamily: 'BerlinLite'),),
                  Text(txt4,style: TextStyle(fontSize: 20,
                      fontStyle: FontStyle.normal,fontWeight: FontWeight.w400,fontFamily: 'BerlinLite'),),
                ],
            ),
          ),
        ),
      ],
    );
  }
}