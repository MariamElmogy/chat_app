import 'package:bloc/bloc.dart';
import 'package:chatty_app/utils/functions/store_user_data.dart';
import 'package:chatty_app/views/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> register(
      {required UserModel userModel, required String password}) async {
    emit(RegisterLoading());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userModel.email!,
        password: password,
      );
      emit(RegisterSuccess());
      await storeUserData(credential, userModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errmessage: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(
            errmessage: 'The account already exists for that email.'));
      }
    } catch (e) {
      // print(e);
      emit(RegisterFailure(errmessage: 'something went wrong'));
    }
  }
}
