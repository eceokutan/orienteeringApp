import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    required this.e,
  });

  final Exception e;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("HATA"),
      content: Text(e.toString()),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Tamam"))
      ],
    );
  }
}