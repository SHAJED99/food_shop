import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_shop/firebase_options.dart';
import 'package:food_shop/src/models/pojo_models/user_information_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseController {
  final String _userString = "users";
  initFirebase() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

  //* Signup
  Future<void> signup(UserInformationModel user, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email, password: password);
      await FirebaseFirestore.instance.collection(_userString).doc(userCredential.user?.uid).set(user.toMap());
    } catch (e) {
      rethrow;
    }
  }

  //* Login
  Future<void> login(email, password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  //* fetch user data
  Future<UserInformationModel> fetchUserData() async {
    try {
      Map<String, dynamic> res = await FirebaseFirestore.instance.collection(_userString).doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) => value.data() ?? {});
      return UserInformationModel.fromMap(res);
    } catch (e) {
      rethrow;
    }
  }
}
