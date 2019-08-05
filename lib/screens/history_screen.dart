import 'package:flutter/material.dart';
import 'package:mix_cosmetics/reusable_directory/reusable_drawer_widget.dart';
class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
              'History',
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
          ],
        ),
      ),
    );
  }
}
