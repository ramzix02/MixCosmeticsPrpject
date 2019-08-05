import 'package:flutter/material.dart';

class ReusableBG extends StatelessWidget {
  ReusableBG({@required this.imgB , this.textB});
  final String imgB;
  final Widget textB;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: textB,
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage(imgB),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}