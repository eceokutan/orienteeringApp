import 'package:flutter/material.dart';

class CustomTextField extends TextField {
  CustomTextField(
      {Key? key,
      String? hintText,
      bool obscureText = false,
      void Function(String)? onChanged,
      Widget icon = const Icon(
        Icons.person,
        color: Color.fromARGB(66, 90, 77, 77),
      ),
      TextEditingController? controller,
      TextInputType? textInputType})
      : super(
          key: key,
          controller: controller,
          obscureText: obscureText,
          keyboardType: textInputType,
          onChanged: onChanged,
          minLines: 1,
          maxLines: obscureText ? 1 : 5,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white)),
            hintText: hintText,
          ),
        );
}
