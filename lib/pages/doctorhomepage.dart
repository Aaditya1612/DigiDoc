import 'package:codesageuser/widgets/curvepainter.dart';
import 'package:codesageuser/widgets/curvepainter2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class DoctorHome extends StatefulWidget {
  DoctorHome({super.key, required this.spec});
  String spec;
  @override
  State<DoctorHome> createState() => _DoctorHome();
}

class _DoctorHome extends State<DoctorHome> {
  int _selectedIndex = 0;
  Position? _currentPosition;
  String userId = '';
  String? userName = '';
  int sympCount = 0;
  String msg = "Your profile is almost ready Doc";
  String msg2 = "Click on above button to add your workplace";
  String msg3 = "";
  String btTEXT = "Locate me";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  // Function to get current location of driver using geolocator
  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  final geo = GeoFlutterFire();
  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser!.uid; //fetch user id
    userName = FirebaseAuth.instance.currentUser!.displayName;

    //_handleLocationPermission();
    _getCurrentPosition();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff232c51),
        title: Text(
          "Dr. ${userName}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xff232c51),
      ),
      body: Container(
        color: Color.fromARGB(255, 238, 238, 238),
        child: CustomPaint(
          painter: CurvePainter2(),
          child: Padding(
              padding: EdgeInsets.only(top: 35.0, right: 25, left: 25),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Wooho!, \n${msg}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 30.0, right: 20.0, left: 20),
                      width: 390,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: Offset(0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Add your workplace",
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 18,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () async {
                              await _getCurrentPosition();
                              GeoFirePoint userLocation = geo.point(
                                  latitude: _currentPosition!.latitude,
                                  longitude: _currentPosition!.longitude);
                              FirebaseFirestore.instance
                                  .collection("['${widget.spec}']")
                                  .doc(userId)
                                  .update({'position': userLocation.data});
                              setState(() {
                                msg = "You are all set";
                                msg2 =
                                    "You have successfully added your workplace";
                                btTEXT = "Done";
                              });
                            },
                            child: Container(
                              width: 300,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xff232c51),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.locationDot,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(btTEXT,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "${msg2}",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${msg3}",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ])),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color(0xFF232C51),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
              backgroundColor: Color(0xff232c51),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Color(0xff232c51),
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 25,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
