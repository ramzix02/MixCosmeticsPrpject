import 'package:flutter/material.dart';
import 'package:mix_cosmetics/reusable_directory/reusable_drawer_widget.dart';
import 'package:mix_cosmetics/beans/network_helper.dart';
import 'package:flutter_html/flutter_html.dart';
class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

String url = "http://mixcosmetics.net/api/pages";
AboutUsNetwork aboutUsNetwork =AboutUsNetwork(url,'en');

class _AboutUsState extends State<AboutUs> {
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
            child: FutureBuilder(
              future: aboutUsNetwork.getPages(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                //print(snapshot.data);
                if (snapshot.data == null) {
                  return Container(
                      child: Center(
                          child: Center(
                            child: Text('loading data..'),
                          )
                      )
                  );
                } else
                  return Text(snapshot.data[0].title,
                    style: TextStyle(fontFamily: 'BerlinBold', fontSize: 30),);
              },
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
            FutureBuilder(
              future: aboutUsNetwork.getPages(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                //print(snapshot.data);
                if (snapshot.data == null) {
                  return Container(
                      child: Center(
                          child: Center(
                            child: Text('loading data..'),
                          )
                      )
                  );
                } else
                  return ListView(
                    children: <Widget>[
                      Html(
                        data: snapshot.data[0].desc,
                        defaultTextStyle: TextStyle(fontFamily:"BerlinLite",fontSize: 20.0 ),
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 7.0),
                      ),
                    ],
                   );
              },
            ),
          ],
      )),
    );
    }

  }

