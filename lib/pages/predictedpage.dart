import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:units_converter/units_converter.dart';

class PredictedPage extends StatefulWidget {
  PredictedPage({super.key, required this.disease, required this.userLocation});
  String disease;
  
  GeoFirePoint userLocation;

  @override
  State<PredictedPage> createState() => _PredictedPageState();
}

class _PredictedPageState extends State<PredictedPage> {
  final geo = GeoFlutterFire();
  final _firestore = FirebaseFirestore.instance;
  String userId = '';
  String? userName = '';
  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser!.uid; //fetch user id
    userName = FirebaseAuth.instance.currentUser!.displayName;
  }

  Widget build(BuildContext context) {
    GeoFirePoint center = geo.point(
        latitude: widget.userLocation.latitude,
        longitude: widget.userLocation.longitude);
// get the collection reference or query
    var collectionReference = _firestore.collection(widget.disease);
    double radius = 1;
    String field = 'position';

    Stream<List<DocumentSnapshot>> streamOfNearby = geo
        .collection(collectionRef: collectionReference)
        .within(center: center, radius: radius, field: field);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff232c51),
        title: Text(
          "${userName}",
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    height: 95,
                    width: 330,
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Color(0xff232c51),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "You are most probably suffering from: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "${widget.disease}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    child: StreamBuilder<List<DocumentSnapshot>>(
                        stream: streamOfNearby,
                        builder: (context,
                            AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                          if (!snapshot.hasData) {
                            return Container(
                              child: Text('No data'),
                            );
                          }
                          return Container(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: ((context, index) {
                                  DocumentSnapshot data = snapshot.data![index];
                                  GeoPoint documentLocation =
                                      data.get('position')['geopoint'];
                                  var distanceInMeters =
                                      Geolocator.distanceBetween(
                                          center.latitude,
                                          center.longitude,
                                          documentLocation.latitude,
                                          documentLocation.longitude);
                                  return ListTile(
                                    
                                    title: Text('Dr. ${data.get('name')}'),
                                    subtitle: Text(
                                        '${distanceInMeters.convertFromTo(LENGTH.meters, LENGTH.kilometers)!.toStringAsFixed(2)} KM'),
                                  );
                                })),
                          );
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      //bottomNavigationBar: BottomNavigationBar(),
    );
  }
}
/*
SafeArea(
        child: StreamBuilder<List<DocumentSnapshot>>(
            stream: streamOfNearby,
            builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: Text('No data'),
                );
              }
              return Container(
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: ((context, index) {
                      DocumentSnapshot data = snapshot.data![index];
                      GeoPoint documentLocation =
                          data.get('position')['geopoint'];
                      var distanceInMeters = Geolocator.distanceBetween(
                          center.latitude,
                          center.longitude,
                          documentLocation.latitude,
                          documentLocation.longitude);
                      return ListTile(
                        title: Text('${data.get('name')}'),
                        subtitle: Text(
                            '${distanceInMeters.convertFromTo(LENGTH.meters, LENGTH.kilometers)!.toStringAsFixed(2)} KM'),
                      );
                    })),
              );
            }),
      ),

      */
