import 'dart:convert';

import 'package:codesageuser/pages/predictedpage.dart';
import 'package:codesageuser/widgets/curvepainter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  Position? _currentPosition;
  String userId = '';
  String? userName = '';
  int sympCount = 0;
  String predictedDisease = 'Tuberculosis';
  bool isChange = false;
  bool isPredict = false;
  IconData iconForSubmit = Icons.send;
  IconData iconForPredict = Icons.send;
  List<String> suggestons = [
    'itching',
    'skin_rash',
    'nodal_skin_eruptions',
    'continuous_sneezing',
    'shivering',
    'chills',
    'joint_pain',
    'stomach_pain',
    'acidity',
    'ulcers_on_tongue',
    'muscle_wasting',
    'vomiting',
    'burning_micturition',
    'spotting_ urination',
    'fatigue',
    'weight_gain',
    'anxiety',
    'cold_hands_and_feets',
    'mood_swings',
    'weight_loss',
    'restlessness',
    'lethargy',
    'patches_in_throat',
    'irregular_sugar_level',
    'cough',
    'high_fever',
    'sunken_eyes',
    'breathlessness',
    'sweating',
    'dehydration',
    'indigestion',
    'headache',
    'yellowish_skin',
    'dark_urine',
    'nausea',
    'loss_of_appetite',
    'pain_behind_the_eyes',
    'back_pain',
    'constipation',
    'abdominal_pain',
    'diarrhoea',
    'mild_fever',
    'yellow_urine',
    'yellowing_of_eyes',
    'acute_liver_failure',
    'fluid_overload',
    'swelling_of_stomach',
    'swelled_lymph_nodes',
    'malaise',
    'blurred_and_distorted_vision',
    'phlegm',
    'throat_irritation',
    'redness_of_eyes',
    'sinus_pressure',
    'runny_nose',
    'congestion',
    'chest_pain',
    'weakness_in_limbs',
    'fast_heart_rate',
    'pain_during_bowel_movements',
    'pain_in_anal_region',
    'bloody_stool',
    'irritation_in_anus',
    'neck_pain',
    'dizziness',
    'cramps',
    'bruising',
    'obesity',
    'swollen_legs',
    'swollen_blood_vessels',
    'puffy_face_and_eyes',
    'enlarged_thyroid',
    'brittle_nails',
    'swollen_extremeties',
    'excessive_hunger',
    'extra_marital_contacts',
    'drying_and_tingling_lips',
    'slurred_speech',
    'knee_pain',
    'hip_joint_pain',
    'muscle_weakness',
    'stiff_neck',
    'swelling_joints',
    'movement_stiffness',
    'spinning_movements',
    'loss_of_balance',
    'unsteadiness',
    'weakness_of_one_body_side',
    'loss_of_smell',
    'bladder_discomfort',
    'foul_smell_of urine',
    'continuous_feel_of_urine',
    'passage_of_gases',
    'internal_itching',
    'toxic_look_(typhos)',
    'depression',
    'irritability',
    'muscle_pain',
    'altered_sensorium',
    'red_spots_over_body',
    'belly_pain',
    'abnormal_menstruation',
    'dischromic _patches',
    'watering_from_eyes',
    'increased_appetite',
    'polyuria',
    'family_history',
    'mucoid_sputum',
    'rusty_sputum',
    'lack_of_concentration',
    'visual_disturbances',
    'receiving_blood_transfusion',
    'receiving_unsterile_injections',
    'coma',
    'stomach_bleeding',
    'distention_of_abdomen',
    'history_of_alcohol_consumption',
    'fluid_overload',
    'blood_in_sputum',
    'prominent_veins_on_calf',
    'palpitations',
    'painful_walking',
    'pus_filled_pimples',
    'blackheads',
    'scurring',
    'skin_peeling',
    'silver_like_dusting',
    'small_dents_in_nails',
    'inflammatory_nails',
    'blister',
    'red_sore_around_nose',
    'yellow_crust_ooze'
  ];
  Map<String, int> map = {
    'itching': 0,
    'skin_rash': 0,
    'nodal_skin_eruptions': 0,
    'continuous_sneezing': 1,
    'shivering': 0,
    'chills': 0,
    'joint_pain': 0,
    'stomach_pain': 0,
    'acidity': 0,
    'ulcers_on_tongue': 0,
    'muscle_wasting': 0,
    'vomiting': 0,
    'burning_micturition': 0,
    'spotting_urination': 0,
    'fatigue': 0,
    'weight_gain': 0,
    'anxiety': 0,
    'cold_hands_and_feets': 0,
    'mood_swings': 0,
    'weight_loss': 0,
    'restlessness': 0,
    'lethargy': 0,
    'patches_in_throat': 1,
    'irregular_sugar_level': 0,
    'cough': 0,
    'high_fever': 0,
    'sunken_eyes': 0,
    'breathlessness': 0,
    'sweating': 0,
    'dehydration': 0,
    'indigestion': 0,
    'headache': 0,
    'yellowish_skin': 0,
    'dark_urine': 0,
    'nausea': 0,
    'loss_of_appetite': 0,
    'pain_behind_the_eyes': 0,
    'back_pain': 0,
    'constipation': 0,
    'abdominal_pain': 0,
    'diarrhoea': 0,
    'mild_fever': 0,
    'yellow_urine': 0,
    'yellowing_of_eyes': 0,
    'acute_liver_failure': 0,
    'fluid_overload': 0,
    'swelling_of_stomach': 0,
    'swelled_lymph_nodes': 0,
    'malaise': 0,
    'blurred_and_distorted_vision': 0,
    'phlegm': 0,
    'throat_irritation': 0,
    'redness_of_eyes': 0,
    'sinus_pressure': 0,
    'runny_nose': 0,
    'congestion': 0,
    'chest_pain': 0,
    'weakness_in_limbs': 0,
    'fast_heart_rate': 0,
    'pain_during_bowel_movements': 0,
    'pain_in_anal_region': 0,
    'bloody_stool': 1,
    'irritation_in_anus': 0,
    'neck_pain': 1,
    'dizziness': 1,
    'cramps': 0,
    'bruising': 1,
    'obesity': 0,
    'swollen_legs': 1,
    'swollen_blood_vessels': 0,
    'puffy_face_and_eyes': 0,
    'enlarged_thyroid': 0,
    'brittle_nails': 1,
    'swollen_extremeties': 0,
    'excessive_hunger': 0,
    'extra_marital_contacts': 0,
    'drying_and_tingling_lips': 0,
    'slurred_speech': 0,
    'knee_pain': 0,
    'hip_joint_pain': 0,
    'muscle_weakness': 1,
    'stiff_neck': 0,
    'swelling_joints': 0,
    'movement_stiffness': 0,
    'spinning_movements': 0,
    'loss_of_balance': 0,
    'unsteadiness': 0,
    'weakness_of_one_body_side': 0,
    'loss_of_smell': 0,
    'bladder_discomfort': 0,
    'foul_smell_of_urine': 0,
    'continuous_feel_of_urine': 0,
    'passage_of_gases': 0,
    'internal_itching': 0,
    'toxic_look_typhos': 0,
    'depression': 0,
    'irritability': 0,
    'muscle_pain': 0,
    'altered_sensorium': 0,
    'red_spots_over_body': 0,
    'belly_pain': 1,
    'abnormal_menstruation': 1,
    'dischromic_patches': 0,
    'watering_from_eyes': 0,
    'increased_appetite': 1,
    'polyuria': 0,
    'family_history': 0,
    'mucoid_sputum': 0,
    'rusty_sputum': 1,
    'lack_of_concentration': 0,
    'visual_disturbances': 0,
    'receiving_blood_transfusion': 0,
    'receiving_unsterile_injections': 0,
    'coma': 0,
    'stomach_bleeding': 0,
    'distention_of_abdomen': 0,
    'history_of_alcohol_consumption': 0,
    'fluid_overload2': 0,
    'blood_in_sputum': 0,
    'prominent_veins_on_calf': 0,
    'palpitations': 0,
    'painful_walking': 0,
    'pus_filled_pimples': 1,
    'blackheads': 0,
    'scurring': 0,
    'skin_peeling': 0,
    'silver_like_dusting': 0,
    'small_dents_in_nails': 0,
    'inflammatory_nails': 0,
    'blister': 0,
    'red_sore_around_nose': 0,
    'yellow_crust_ooze': 1
  };
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
          "${userName}",
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
          painter: CurvePainter(),
          child: Padding(
              padding: EdgeInsets.only(top: 35.0, right: 25, left: 25),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Hey, \nAre you not feeling well?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
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
                            "What things are troubling you?",
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
                          TypeAheadField(
                            animationStart: 0,
                            animationDuration: Duration.zero,
                            textFieldConfiguration: TextFieldConfiguration(
                                autofocus: true,
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder())),
                            suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                color: Colors.lightBlue[50]),
                            suggestionsCallback: (pattern) {
                              List<String> matches = <String>[];
                              matches.addAll(suggestons);

                              matches.retainWhere((s) {
                                return s
                                    .toLowerCase()
                                    .contains(pattern.toLowerCase());
                              });
                              return matches;
                            },
                            itemBuilder: (context, sone) {
                              return Card(
                                  child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text(sone.toString()),
                              ));
                            },
                            onSuggestionSelected: (suggestion) {
                              SnackBar snack = SnackBar(
                                  backgroundColor:
                                      Color.fromRGBO(231, 105, 105, 1),
                                  elevation: 10,
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(5),
                                  content: Text(
                                    "Selected ${suggestion}",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 253, 251, 251),
                                    ),
                                  ));
                              ScaffoldMessenger.of(context).showSnackBar(snack);

                              setState(() {
                                sympCount++;
                                map[suggestion] = 1;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "No. of symptoms selected: ${sympCount}",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Recommended to select atleast 3",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () async {
                              isChange = true;
                              iconForSubmit = Icons.done;
                              const url =
                                  'https://4f7f-2405-204-3026-2c43-4471-9e1e-977-4ba8.in.ngrok.io';
                              final response = await http.post(Uri.parse(url),
                                  body: json.encode(map));
                            },
                            child: AnimatedContainer(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 10.0),
                                duration: const Duration(seconds: 2),
                                width: (!isChange) ? 250 : 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xff232c51),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                child: (isChange)
                                    ? Icon(
                                        iconForSubmit,
                                        color: Colors.white,
                                      )
                                    : Text('Submit',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400))
                                //Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: <Widget>[
                                //     Icon(
                                //       iconForSubmit,
                                //       color: Colors.white,
                                //     ),
                                //     SizedBox(
                                //       width: 10,
                                //     ),
                                //     Text('Submit',
                                //         style: TextStyle(
                                //             color: Colors.white,
                                //             fontSize: 18,
                                //             fontWeight: FontWeight.w400)),
                                //   ],
                                // ),
                                ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        isPredict = true;
                        isChange = false;
                        await _getCurrentPosition();
                        GeoFirePoint userLocation = geo.point(
                            latitude: _currentPosition!.latitude,
                            longitude: _currentPosition!.longitude);
                        FirebaseFirestore.instance
                            .collection('userdata')
                            .doc(userId)
                            .update({'position': userLocation.data});
                        const url =
                            'https://4f7f-2405-204-3026-2c43-4471-9e1e-977-4ba8.in.ngrok.io';
                        http.Response response;
                        response = await http.get(Uri.parse(url));
                        if (response.statusCode == 200) {
                          setState(() {
                            predictedDisease = response.body;
                          });
                        }

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PredictedPage(
                                  disease: predictedDisease.toString(),
                                  userLocation: userLocation,
                                )));
                      },
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 2),

                          width: (!isPredict) ? 250 : 40,
                          height: 40,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Color(0xff232c51),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: (isPredict)
                              ? Icon(
                                  iconForPredict,
                                  color: Colors.white,
                                )
                              : Text('Predict Disease',
                              
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400))
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: <Widget>[
                          //     Icon(
                          //       FontAwesomeIcons.userDoctor,
                          //       color: Colors.white,
                          //     ),
                          //     SizedBox(
                          //       width: 10,
                          //     ),
                          //     Text('Predict Disease',
                          //         style: TextStyle(
                          //             color: Colors.white,
                          //             fontSize: 18,
                          //             fontWeight: FontWeight.w400)),
                          //   ],
                          // ),
                          ),
                    )
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
