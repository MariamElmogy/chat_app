import 'package:flutter/material.dart';
import '../register_view.dart';
import 'already_have_an_account.dart';
import 'login_form.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
              ),
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            LoginForm(),
            const SizedBox(
              height: 32,
            ),
            AuthAuthenticationOption(
              action: 'Register',
              text: 'Don\'t have an account?',
              onPressed: () {
                Navigator.pushNamed(context, RegisterView.id);
              },
            )
          ],
        ),
      ),
    );
  }
}
