import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codesageuser/pages/informationpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:units_converter/units_converter.dart';
import 'package:maps_launcher/maps_launcher.dart';

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
  String dname = '';
  name() {
    for (int i = 2; i < widget.disease.length - 2; i++) {
      dname = dname + widget.disease[i];
    }
    print("=====================${dname}==========");
  }

  @override
  void initState() {
    super.initState();

    userId = FirebaseAuth.instance.currentUser!.uid; //fetch user id
    userName = FirebaseAuth.instance.currentUser!.displayName;
    name();
  }

  Widget build(BuildContext context) {
    GeoFirePoint center = geo.point(
        latitude: widget.userLocation.latitude,
        longitude: widget.userLocation.longitude);
// get the collection reference or query
    var collectionReference = _firestore.collection(widget.disease);
    double radius = 5;
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
                        color: Color.fromARGB(255, 250, 250, 250),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: Offset(0, 4), // changes position of shadow
                          ),
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "You are most probably suffering from: ",
                              style: TextStyle(
                                color: Color.fromARGB(255, 15, 15, 15),
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "${widget.disease}",
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    InformationPage(disease: dname)));
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Color(0xff232c51),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ),
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
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "HERE ARE SUGGESTED DOCTORS NEAR YOU",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Divider(
                    indent: 10.0,
                    endIndent: 10.0,
                    color: Colors.grey,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 20,
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
                                  return Hero(
                                    tag: 'Doctor tile',
                                    child: ListTile(
                                      textColor: Colors.white,
                                      leading: Icon(
                                        FontAwesomeIcons.userDoctor,
                                        color:
                                            Color.fromARGB(255, 181, 198, 235),
                                        size: 35,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      tileColor:
                                          Color.fromARGB(255, 64, 80, 145),
                                      title: Text('Dr. ${data.get('name')}'),
                                      subtitle: Text(
                                          '${distanceInMeters.convertFromTo(LENGTH.meters, LENGTH.kilometers)!.toStringAsFixed(2)} KM'),
                                      trailing: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Color(0xff232c51),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Icon(
                                          Icons.place,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onTap: () {
                                        MapsLauncher.launchCoordinates(
                                            documentLocation.latitude,
                                            documentLocation.longitude);
                                      },
                                    ),
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
