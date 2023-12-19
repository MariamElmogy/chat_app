import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../cubits/login_cubit/login_cubit.dart';

void buildSnakBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message, style: TextStyle(color: color),)));
  }