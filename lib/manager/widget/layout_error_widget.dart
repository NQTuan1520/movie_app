import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorLayoutWidget extends StatelessWidget {
  final GestureTapCallback tap;
  final String message;
  const ErrorLayoutWidget({super.key, required this.tap, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Text(
            message,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          16.verticalSpace,
          IconButton(onPressed: () {
            tap();
          }, icon: const Icon(Icons.refresh))
        ],
      ),
    );
  }
}