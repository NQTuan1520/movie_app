import 'package:flutter/material.dart';

class ErrorVideoPlayerWidget extends StatelessWidget {
  const ErrorVideoPlayerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Error initializing video player',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
