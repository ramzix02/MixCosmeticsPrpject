import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mix_cosmetics/reusable_directory/reusable_drawer_widget.dart';
import 'package:mix_cosmetics/beans/network_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mix_cosmetics/Utils.dart';
class HomePV extends StatefulWidget {
  @override
  _HomePVState createState() => _HomePVState();
}

String url = "http://mixcosmetics.net/api/home_screen";


class _HomePVState extends State<HomePV> {
  String _locale = '';
  _HomePVState() {
    getLocale().then((val) => setState(() {
      _locale = val;

    }));
  }
  NetworkHelper networkHelper = NetworkHelper(url,'en');

//  void updateLocale(String locale) {
//    this._locale= locale;
//    print('wWw $_locale');
//  }

  void setValue() async {
    final prefs = await SharedPreferences.getInstance();
    int launchCount = prefs.getInt('counter') ?? 0;
    prefs.setInt('counter', launchCount + 1);
    //print('Updated Success');
    }
  @override
  void initState(){
    //changeTheLocale('en');
    setValue();
//    getLocale().then(updateLocale);
    super.initState();

  }

  Future<bool> _onBackPressed() {

    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title:  Text('Are you sure?'),
        content:  Text('Do you want to exit an App'),
        actions: <Widget>[
          FlatButton(
              onPressed:()=> Navigator.pop(context,false),
              child: Text('No')),
          FlatButton(
              onPressed:()=> Navigator.pop(context,true),
              child: Text('Yes')),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Color.fromARGB(240, 28, 150, 210),
            title: Center(
              child: Text(
                'Mix Cosmetics',
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: FutureBuilder(
                          future: networkHelper.getSlider(),
                          builder: (BuildContext context, AsyncSnapshot snapshot){
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
                            }else return PageView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder:(BuildContext context, int index){
                                  return Container(
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) => SpinKitWave(
                                        color: Colors.yellowAccent,
                                        size: 50.0,
                                      ),
                                      imageUrl:
                                      snapshot.data[index].image,
                                      fit: BoxFit.fill,
                                    ),
                                    //Image.network(snapshot.data[index].image),
                                  );
                                });
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(child: Text('Brands',style: TextStyle(fontSize: 25,fontFamily: 'BerlinBold'),)),
                  ),

                  Expanded(
                    flex: 3,
                    child: SizedBox(
                        child: FutureBuilder(
                            future: networkHelper.getProducts(),
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                              } else
                                return GridView.builder(
                                    itemCount: snapshot.data.length,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                                    itemBuilder: (BuildContext context, int index) {
                                      return Container(
                                        margin: EdgeInsets.all(7.0),
                                        decoration:BoxDecoration(borderRadius: BorderRadius.circular(7.0),
                                        color: Colors.white,
                                          shape: BoxShape.rectangle,
                                            boxShadow: [BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 5.0,
                                            ),]
                                        ) ,
                                        child: InkWell(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Expanded(
                                                  flex: 3,
                                                  child: CachedNetworkImage(imageUrl: snapshot.data[index].image,
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
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(7.0),bottomLeft: Radius.circular(7.0)),
                                                    color: Color.fromARGB(250, 115, 190, 222)),
                                                     // width: 160,
                                                      child: Center(child: Text(snapshot.data[index].name))
                                                  )
                                              )
                                            ],
                                          ),
                                        ),

                                      );
                                    }
                                );
                            }))
                  ),
                ],
              ),

          ],
          ),

          drawer: ReusableDrawerWidget()),
    );
  }
}


