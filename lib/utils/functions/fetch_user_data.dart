import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../views/models/user_model.dart';

Future<UserModel> fetchUserData({required UserCredential userCredential}) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = firestore.collection('users');

  var document = await users.doc(userCredential.user!.uid).get();
  UserModel userModel =
      UserModel.fromJson(document.data() as Map<String, dynamic>);
  return userModel;
}
