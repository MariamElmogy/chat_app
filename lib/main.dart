import 'package:chatty_app/cubits/login_cubit/login_cubit.dart';
import 'package:chatty_app/views/chat_view.dart';
import 'package:chatty_app/views/login_view.dart';
import 'package:chatty_app/views/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Chatty());
}

class Chatty extends StatelessWidget {
  const Chatty({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: kPrimarySwatch,
            brightness: Brightness.dark,
            fontFamily: 'Inter',
          ),
          routes: {
            LoginView.id: (context) => const LoginView(),
            RegisterView.id: (context) => const RegisterView(),
            ChatView.id: (context) => const ChatView(),
          },
          initialRoute: getInitialView()),
    );
  }

  String getInitialView() {
    if (FirebaseAuth.instance.currentUser == null) {
      return LoginView.id;
    } else {
      return ChatView.id;
    }
  }
}
