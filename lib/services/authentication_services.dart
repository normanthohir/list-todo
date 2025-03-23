//  untuk regstrasi dan login
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshop_flutter_firebases/models/profile.dart';
import 'package:workshop_flutter_firebases/pages/profile_page.dart';

class AuthenticationServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final prefs = SharedPreferences.getInstance();

  // untuk login
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      prefs.then((value) => value.setString('email', email));
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // untuk register
  Future registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String role,
    required String phoneNumber,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firebaseFirestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'name': name,
        'role': role,
        'email': email,
        'phoneNumber': phoneNumber,
        'createdAt': FieldValue.serverTimestamp(),
      });
      prefs.then((value) => value.setString('email', email));
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

// mengambil data user ayng sudah login

  Future<Profile?> getCurrentUserProfile() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      DocumentSnapshot doc =
          await _firebaseFirestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return Profile.fromMap(doc.data() as Map<String, dynamic>);
      }
    }
    return null;
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
    prefs.then((value) => value.remove('email'));
  }
}
