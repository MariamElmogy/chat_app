import 'package:chatty_app/views/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../constants.dart';

Future<void> storeUserData(
    UserCredential userCredential, UserModel userModel) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = firestore.collection(kUsersCollections);

  await users.doc(userCredential.user!.uid).set(userModel.toJson());
}
