import 'package:flutter/material.dart';
import 'package:mix_cosmetics/reusable_directory/reusable_drawer_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mix_cosmetics/beans/network_helper.dart';

class Brands extends StatefulWidget {
  @override
  _BrandsState createState() => _BrandsState();
}

String url = "http://mixcosmetics.net/api/categories";
NetworkHelper networkHelper = NetworkHelper(url, 'en');

class _BrandsState extends State<Brands> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacementNamed(context, 'home_page_view');
      },
      child: Scaffold(
        drawer: ReusableDrawerWidget(),
        appBar: AppBar(
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
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: 50,
              color: Color.fromARGB(240, 28, 150, 210),
            ),
            FutureBuilder(
              future: networkHelper.getProducts(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(snapshot.data);
                if (snapshot.data == null) {
                  return Container(
                      child: Center(
                          child: Center(
                    child: SpinKitWave(
                      color: Colors.lightBlueAccent,
                      size: 50.0,
                    ),
                  )));
                } else
                  return GridView.builder(
                      itemCount: snapshot.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.all(7.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0,
                                ),
                              ]),
                          child: InkWell(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data[index].image,
                                    placeholder: (context, url) => SpinKitWave(
                                      color: Colors.yellowAccent,
                                      size: 50.0,
                                    ),
                                  ),
                                  //Image.network(snapshot.data[index].image,)
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(7.0),
                                                bottomLeft:
                                                    Radius.circular(7.0)),
                                            color: Color.fromARGB(
                                                250, 115, 190, 222)),
                                        // width: 160,
                                        child: Center(
                                            child: Text(
                                                snapshot.data[index].name))))
                              ],
                            ),
                          ),
                        );
                      });
              },
            ),
          ],
        ),
      ),
    );
  }
}
