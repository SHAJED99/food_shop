import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_shop/firebase_options.dart';
import 'package:food_shop/src/models/pojo_models/user_information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseController {
  initFirebase() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

  //* Signup
  Future<UserCredential> signup(UserInformation user, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email, password: password);
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set(user.toMap());
      print(userCredential.user?.getIdToken());
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  //* Login
  Future<UserCredential> login(email, password) async {
    try {
      // return await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      print(FirebaseAuth.instance.currentUser);
      return await FirebaseAuth.instance.signInWithCustomToken('GMe67fJMCcQ5B28WplPKf6dvY6x1');
    } catch (e) {
      rethrow;
    }
  }
}
