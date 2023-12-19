import 'package:chatty_app/cubits/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_button.dart';
import 'custom_text_form_field.dart';

class LoginForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  late String email, password;

  LoginForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autoValidateMode,
      child: Column(
        children: [
          CustomTextFormField(
            hintText: 'Enter your email',
            onSaved: (value) {
              email = value!;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextFormField(
            hintText: 'Enter your password',
            onSaved: (value) {
              password = value!;
            },
          ),
          const SizedBox(
            height: 36,
          ),
          CustomButton(
            onPressed: () async {
              _formKey.currentState?.save();
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();
                BlocProvider.of<LoginCubit>(context)
                    .loginUser(email: email, password: password);
                _formKey.currentState!.reset();
              }
            },
            text: 'Login',
          ),
        ],
      ),
    );
  }
}
