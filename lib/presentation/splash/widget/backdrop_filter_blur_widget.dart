import 'dart:ui';

import 'package:flutter/material.dart';

class BackdropFilterBlurWidget extends StatelessWidget {
  const BackdropFilterBlurWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Container(
        color: Colors.black.withOpacity(0.1),
      ),
    );
  }
}
