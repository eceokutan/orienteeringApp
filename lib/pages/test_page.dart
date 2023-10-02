import 'dart:collection';

import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<String> _list = ['a', 'b', 'c'];

  addList() {
    _list.add('d');

    Queue();

    setState(() {});
  }

  removeList() {
    _list.removeLast();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
