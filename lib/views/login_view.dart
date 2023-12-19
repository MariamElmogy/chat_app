import 'package:chatty_app/cubits/login_cubit/login_cubit.dart';
import 'package:chatty_app/views/chat_view.dart';
import 'package:chatty_app/views/widgets/login_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/functions/build_snak_bar.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const id = 'login';
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {}
      },
      child: Scaffold(
        body: BlocProvider(
          create: (context) => LoginCubit(),
          child: SafeArea(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover),
              ),
              child: const LoginViewBodyBlocConsumer(),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginViewBodyBlocConsumer extends StatelessWidget {
  const LoginViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccess) {
          saveLoginState();
          buildSnakBar(context, "Success", Colors.green);
          Navigator.pushNamed(context, ChatView.id);
        }
        if (state is LoginFailure) {
          buildSnakBar(context, state.errMessage, Colors.red);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
            inAsyncCall: state is LoginLoading ? true : false,
            child: const LoginViewBody());
      },
    );
  }

  Future<void> saveLoginState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
  }
}
