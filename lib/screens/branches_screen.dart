import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mix_cosmetics/reusable_directory/reusable_drawer_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mix_cosmetics/beans/network_helper.dart';

class BranchesMap extends StatefulWidget {
  @override
  State<BranchesMap> createState() => BranchesMapState();
}

String url = "http://mixcosmetics.net/api/branches";
BranchesMapNetwork branchesNetwork = BranchesMapNetwork(url, 'en');

class BranchesMapState extends State<BranchesMap> {
  PermissionStatus _status;
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(29.443425, 40.535878),
    zoom: 4.3,
  );

  @override
  void initState() {
    PermissionHandler()
        .checkPermissionStatus(PermissionGroup.locationWhenInUse)
        .then(_updateStatus);
//    _askPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:(){
        Navigator.pushReplacementNamed(context, 'home_page_view');
      },
      child: new Scaffold(
        drawer: ReusableDrawerWidget(),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromARGB(240, 28, 150, 210),
          title: Center(
            child: Text(
              'Branches',
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
              padding: const EdgeInsets.symmetric(horizontal: 9.0),
              child: FutureBuilder(
                  future: branchesNetwork.getPages(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                      return Column(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5.0,
                                  ),
                                ]),
                            child: GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: _kGooglePlex,
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                              markers: {
                                markerFunction(
                                    double.parse(snapshot.data[0].lat),
                                    double.parse(snapshot.data[0].lng),
                                    snapshot.data[0].name),

                                markerFunction(
                                    double.parse(snapshot.data[1].lat),
                                    double.parse(snapshot.data[1].lng),
                                    snapshot.data[1].name),
                              },
                            ),

                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.17,
                              width: MediaQuery.of(context).size.width,
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
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text(
                                      snapshot.data[0].name,
                                      style: TextStyle(color: Colors.blue,fontFamily: 'BerlinBold',fontSize: 25.0),),
                    SizedBox(height: 11.0,),
                                    Text(snapshot.data[0].address,
                                      style: TextStyle(fontFamily: 'BerlinLite',fontSize: 18.0),),
                                    SizedBox(height: 7.0,),
                                    Row(
                                      children: <Widget>[
                    Image(image: AssetImage('assets/icons/ic_nav_contact_us.png', ),width: 25,),
                                        SizedBox(width: 7.0,),
                                        Text(snapshot.data[0].phone,
                                          style: TextStyle(fontFamily: 'BerlinLite',fontSize: 18.0),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.17,
                            width: MediaQuery.of(context).size.width,
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
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(snapshot.data[1].name,style:TextStyle(color: Colors.blue,fontFamily: 'BerlinBold',fontSize: 25.0),),
                                  SizedBox(height: 11.0,),
                                  Text(snapshot.data[1].address,style: TextStyle(fontFamily: 'BerlinLite',fontSize: 18.0),),
                                  SizedBox(height: 7.0,),
                                  Row(
                                    children: <Widget>[
                                      Image(image: AssetImage('assets/icons/ic_nav_contact_us.png', ),width: 25,),
                                      SizedBox(width: 7.0,),
                                      Text(snapshot.data[1].phone,style: TextStyle(fontFamily: 'BerlinLite',fontSize: 18.0),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                  }),
            ),
//          SafeArea(child: Text('$_status')),

          ],
        ),
      ),
    );
  }

  void _updateStatus(PermissionStatus status) {
    if (status != _status) {
      setState(() {
        _status = status;
        _status.toString() != 'PermissionStatus.granted'?_askPermission():null;
        print(_status);
      });
    }
  }

  void _askPermission() {
    PermissionHandler().requestPermissions(
        [PermissionGroup.locationWhenInUse]).then(_onStatusRequest);
  }

  void _onStatusRequest(Map<PermissionGroup, PermissionStatus> statuses) {
    final status = statuses[PermissionGroup.locationWhenInUse];
    _updateStatus(status);
  }

}

Marker markerFunction(double lat, double lng, String branch) {
  return Marker(
    markerId: MarkerId(branch),
    position: LatLng(lat, lng),
    infoWindow: InfoWindow(title: branch),
  );
}
