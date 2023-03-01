import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Googleservices {
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
      FirebaseFirestore.instance.collection('userdata').doc(guser.email).set({
        'email': guser.email,
        'name': guser.displayName,
        'profilepic': guser.photoUrl,
      });
    });
  }
}