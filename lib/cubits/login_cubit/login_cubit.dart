import 'package:bloc/bloc.dart';
import 'package:chatty_app/constants.dart';
import 'package:chatty_app/utils/functions/fetch_user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../views/models/user_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      var userData = await fetchUserData(userCredential: credential);

      // Obtain shared preferences.
      await saveLocalAvatar(userData);

      emit(LoginSuccess(userData));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        LoginFailure(errMessage: "user not found");
      } else if (e.code == "wrong-password") {
        LoginFailure(errMessage: "wrong password");
      }
    }
  }

  Future<void> saveLocalAvatar(UserModel userData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(kAvatar, userData.avatar!);
  }
}
