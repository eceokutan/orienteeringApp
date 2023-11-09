import 'package:flutter/material.dart';

class AsyncButton extends StatefulWidget {
  const AsyncButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.loadingWidget = const CircularProgressIndicator(),
  }) : super(key: key);

  final Future<void> Function() onPressed;

  final Widget child;

  final Widget loadingWidget;

  @override
  _AsyncButtonState createState() => _AsyncButtonState();
}

class _AsyncButtonState extends State<AsyncButton> {
  bool _isLoading = false;
  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> _completeProcess() async {
    _changeLoading();
    await widget.onPressed();
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isLoading
          ? widget.loadingWidget
          : SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: _completeProcess, child: widget.child),
            ),
    );
  }
}
