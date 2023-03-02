/*import 'package:ambimed_phone_sign_up_page/pages/services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';

String time = "";

class toggle extends StatefulWidget {
  const toggle({super.key});

  @override
  State<toggle> createState() => _toggleState();
}

class _toggleState extends State<toggle> {
  late DatabaseReference dbref;
  Position? _currentPosition;
  String available = "true";
  String booked = "false";
  String vehicleNumber = "DL 12 CT 1234";
  String vehicleColor = "white";
  String userId = ''; //to store user id

  // Function to check if location access has been approved or not
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

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser!.uid; //fetch user id

    dbref = FirebaseDatabase.instance.ref().child('Drivers/${userId}');

    _getCurrentPosition();

    // Intitally pushing a random data
    Map<String, dynamic> drivers = {
      'available': available,
      'booked': booked,
      'longitude': "fake",
      'latitude': "fake",
      'vehicleDetails': {
        'vehicleNumber': vehicleNumber,
        'vehicleColor': vehicleColor
      },
    };
    dbref.set(drivers);

    // Periodically updating latitude and longitude after 10 seconds.
    Timer mytimer = Timer.periodic(Duration(seconds: 10), (timer) {
      _getCurrentPosition();
      Map<String, String> drivers = {
        'available': available,
        'booked': booked,
        'longitude': _currentPosition!.longitude.toString(),
        'latitude': _currentPosition!.latitude.toString(),
      };
      dbref.update(drivers);
    });
  }

  bool isOnline = true;
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LiteRollingSwitch(
            value: isOnline,
            animationDuration: const Duration(milliseconds: 400),
            width: 151,
            textOn: "Online",
            textOff: "Offline",
            iconOn: Icons.car_repair_rounded,
            iconOff: Icons.car_crash_rounded,
            colorOn: Color.fromRGBO(231, 105, 105, 1),
            colorOff: Color.fromARGB(255, 180, 180, 180),
            textOnColor: Colors.white,
            onTap: () {},
            onDoubleTap: () {},
            onSwipe: () {},
            onChanged: (bool state) {
              setState(() {
                isOnline = state;
                available = (isOnline) ? ("true") : ("false");
                // Updating status.
                Map<String, String> drivers = {
                  'available': available,
                  'booked': booked,
                  'longitude': _currentPosition!.longitude.toString(),
                  'latitude': _currentPosition!.latitude.toString(),
                };
                dbref.update(drivers);
              });
            }),
      ),
    );
  }
}
*/