import 'package:check_point/custom_text_field.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends CustomTextField {
  PasswordTextField({
    Key? key,
  }) : super(
          key: key,
          obscureText: true,
        );
}
