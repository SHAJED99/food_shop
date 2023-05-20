import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_shop/firebase_options.dart';
import 'package:food_shop/src/models/pojo_models/order_model.dart';
import 'package:food_shop/src/models/pojo_models/product_model.dart';
import 'package:food_shop/src/models/pojo_models/user_information_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuple/tuple.dart';

class FirebaseController {
  final String _userString = "users";
  final String _productString = "products";
  final String _orderString = "orders";
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
      print(res.toString());
      return UserInformationModel.fromMap(res);
    } catch (e) {
      rethrow;
    }
  }

  //* fetch user data
  Future<void> addProduct(ProductModel productModel) async {
    try {
      var res = await FirebaseFirestore.instance.collection(_productString).add(productModel.toMap());
      await FirebaseFirestore.instance.collection(_userString).doc(FirebaseAuth.instance.currentUser?.uid).update({
        'productList': FieldValue.arrayUnion([res.id])
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductModel>> getProduct(List<String> productIdList) async {
    try {
      List<ProductModel> productList = [];

      // Split the productIdList into smaller chunks of 10
      List<List<String>> idChunks = [];
      for (var i = 0; i < productIdList.length; i += 10) {
        var end = (i + 10 < productIdList.length) ? i + 10 : productIdList.length;
        idChunks.add(productIdList.sublist(i, end));
      }

      // Query Firestore for each chunk of product ids
      for (var chunk in idChunks) {
        var query = await FirebaseFirestore.instance.collection(_productString).where(FieldPath.documentId, whereIn: chunk).get();

        var chunkProducts = query.docs.map((doc) => ProductModel.fromMap(doc.data())).toList();
        productList.addAll(chunkProducts);
      }

      return productList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Tuple2<String, ProductModel>>> getOtherUserProductList(List<String> removeList) async {
    try {
      var res = await FirebaseFirestore.instance.collection(_productString).get();

      List<Tuple2<String, ProductModel>> result = [];

      for (QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot in res.docs) {
        if (!removeList.contains(queryDocumentSnapshot.id)) {
          result.add(Tuple2(queryDocumentSnapshot.id, ProductModel.fromMap(queryDocumentSnapshot.data())));
        }
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> placeOrder(OrderModel orderModel) async {
    try {
      var res = await FirebaseFirestore.instance.collection(_orderString).add(orderModel.toMap());

      await FirebaseFirestore.instance.collection(_userString).doc(FirebaseAuth.instance.currentUser?.uid).update(
        {
          "activeOrder": FieldValue.arrayUnion([res.id])
        },
      );

      return res.id;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OrderModel>> loadOrder(String orderId, List<String> orderList) async {
    try {
      List<OrderModel> ol = [];

      // Split the productIdList into smaller chunks of 10
      List<List<String>> idChunks = [];
      for (var i = 0; i < orderList.length; i += 10) {
        var end = (i + 10 < orderList.length) ? i + 10 : orderList.length;
        idChunks.add(orderList.sublist(i, end));
      }

      // Query Firestore for each chunk of product ids
      for (var chunk in idChunks) {
        var query = await FirebaseFirestore.instance.collection(_orderString).where(FieldPath.documentId, whereIn: chunk).get();

        var chunkProducts = query.docs.map((doc) => OrderModel.fromMap(doc.data())).toList();
        ol.addAll(chunkProducts);
      }

      return ol;
    } catch (e) {
      rethrow;
    }
  }
}
