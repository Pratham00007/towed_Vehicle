import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

class AuthenticationServices {
  //cloud storage
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //authrisation
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //signup
  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
    required String phoneno,
  }) async {
    String res = "Some Error Occured";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          name.isNotEmpty &&
          phoneno.isNotEmpty) {
        //for register user in firebase
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        //add in cloud
        await _firestore.collection("users").doc(credential.user!.uid).set({
          'name': name,
          'email': email,
          'phoneno': phoneno,
          'uid': credential.user!.uid,
          'password': password,
        });
        res = "Success";
      }
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some Error Occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        //login user with email and password
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      } else {
        res = "Please Enter All the Field";
      }
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  //for logout
  Future<void> signOut()async{
    await _auth.signOut();
  }
}
