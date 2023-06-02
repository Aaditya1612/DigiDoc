import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codesageuser/pages/doctorhomepage.dart';
import 'package:codesageuser/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DoctorSignIn extends StatefulWidget {
  const DoctorSignIn({super.key});

  @override
  State<DoctorSignIn> createState() => _DoctorSignInState();
}

class _DoctorSignInState extends State<DoctorSignIn> {
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  final Color logoGreen = Color(0xff25bcbb);
  var uid;
  signin() async {
    final GoogleSignInAccount? guser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gauth = await guser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gauth.idToken,
      idToken: gauth.idToken,
    );
    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) {
      FirebaseFirestore.instance
          .collection("['$specia']")
          .doc(value.user!.uid)
          .set({
        'email': guser.email,
        'name': guser.displayName,
        'profilepic': guser.photoUrl,
      });
    });
  }

  List<String> suggeston = [
    'Pneumonia',
    'Gastroenteritis',
    'Migraine',
    'Tuberculosis',
    'Varicose veins',
    'Hepatitis D',
    'AIDS',
    'Malaria',
    'Hepatitis E',
    'Arthritis',
    'hepatitis A',
    'Paralysis (brain hemorrhage)',
    'Dimorphic hemmorhoids(piles)',
    'Psoriasis',
    'GERD',
    'Heart attack',
    'Allergy',
    'Common Cold',
    'Hypothyroidism',
    'Impetigo',
    'Fungal infection',
    'Urinary tract infection',
    '(vertigo) Paroymsal  Positional Vertigo',
    'Chicken pox',
    'Drug Reaction',
    'Hypoglycemia',
    'Diabetes ',
    'Alcoholic hepatitis',
    'Chronic cholestasis',
    'Acne',
    'Hepatitis C',
    'Osteoarthristis',
    'Peptic ulcer diseae',
    'Cervical spondylosis',
    'Jaundice',
    'Bronchial Asthma',
    'Hepatitis B',
    'Hypertension ',
    'Dengue',
    'Typhoid',
    'Hyperthyroidism'
  ];
  String specia = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            // Add box decoration
            decoration: BoxDecoration(
              // Box decoration takes a gradient
              color: Color(0xff141a3a),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.houseMedical,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Text(
                    'Hello Doctor !',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Greetings from DigiDoc,\nPlease select your area of speciality ',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TypeAheadField(
                      animationStart: 0,
                      animationDuration: Duration.zero,
                      textFieldConfiguration: TextFieldConfiguration(
                          autofocus: true,
                          style: TextStyle(fontSize: 15),
                          decoration:
                              InputDecoration(border: OutlineInputBorder())),
                      suggestionsBoxDecoration:
                          SuggestionsBoxDecoration(color: Colors.lightBlue[50]),
                      suggestionsCallback: (pattern) {
                        List<String> matches = <String>[];
                        matches.addAll(suggeston);

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
                            backgroundColor: Color.fromRGBO(231, 105, 105, 1),
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
                          specia = suggestion;
                        });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  //LoginScreen
                  MaterialButton(
                    elevation: 0,
                    height: 50,
                    onPressed: () async {
                      await signin();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => DoctorHome(
                                spec: specia,
                              )));
                    },
                    color: logoGreen,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(FontAwesomeIcons.google),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Sign-in using Google',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ],
                    ),
                    textColor: Colors.white,
                  )
                ],
              ),
            )));
  }
}