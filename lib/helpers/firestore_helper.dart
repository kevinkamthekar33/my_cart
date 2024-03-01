import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/auth_model.dart';
import 'auth_helper.dart';

class FirebaseHelper {
  FirebaseHelper._();

  static final FirebaseHelper firebaseHelper = FirebaseHelper._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  String collectionPath = 'user';

  Future<void> addData({required UserModel userModel}) => fireStore
      .collection(collectionPath)
      .doc(userModel.id.toString())
      .set(userModel.toMap);

  updateData({required UserModel userModel}) => fireStore
      .collection(collectionPath)
      .doc(userModel.id.toString())
      .update(userModel.toMap);

  deleteData({required UserModel userModel}) => fireStore
      .collection(collectionPath)
      .doc(userModel.id.toString())
      .delete();

  Stream<QuerySnapshot<Map<String, dynamic>>> liveData() {
    String email =
        AuthHelper.authHelper.firebaseAuth.currentUser!.email as String;
    return fireStore
        .collection(collectionPath)
        .where('email', isNotEqualTo: email)
        .snapshots();
  }
}
