import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      child: CircularProgressIndicator(
        strokeWidth: 2,
      ),
    );
  }
}
