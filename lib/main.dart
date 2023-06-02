import 'package:codesageuser/firebase_options.dart';
import 'package:codesageuser/pages/predictedpage.dart';
import 'package:codesageuser/pages/singninpage.dart';
import 'package:codesageuser/pages/starterpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  
  final geo = GeoFlutterFire();
  // GeoFirePoint userLocation = geo.point(
  //                           latitude: 28.489853,
  //                           longitude: 77.5233408);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StarterPage(), 
    );
  }
}

