import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class NoteGuideSwipeWidget extends StatelessWidget {
  const NoteGuideSwipeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          const Icon(
            Icons.error_sharp,
            color: Colors.amber,
          ),
          5.horizontalSpace,
          const Text('Swipe to delete your download film')
        ],
      ),
    );
  }
}
