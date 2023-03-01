import 'package:codesageuser/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
          .collection('userdata')
          .doc(value.user!.uid)
          .set({
        'email': guser.email,
        'name': guser.displayName,
        'profilepic': guser.photoUrl,
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            // Add box decoration
            decoration: BoxDecoration(
              // Box decoration takes a gradient
              gradient: LinearGradient(
                colors: [Color(0xff141a3a), Color(0xff064170)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
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
                    'Welcome to DigiDoc !',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'A one-stop portal to get best Doc near you ',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  //Our MaterialButton which when pressed will take us to a new screen named as
                  //LoginScreen
                  MaterialButton(
                    elevation: 0,
                    height: 50,
                    onPressed: () async {
                      await signin();
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePage()));
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

class Googleservices {}
