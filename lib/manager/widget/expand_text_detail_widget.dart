import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  const ExpandableText({super.key, required this.text});

  @override
  // ignore: library_private_types_in_public_api
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;
  final int _maxLines = 5;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: ConstrainedBox(
            constraints: _isExpanded ? const BoxConstraints() : BoxConstraints(maxHeight: 16.sp * 5 + (3 * 5)),
            child: Text(
              widget.text,
              maxLines: _isExpanded ? null : _maxLines,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).brightness == Brightness.dark
                    ? TAppColor.whiteLightColor
                    : TAppColor.darkFadeBlueColor,
              ),
              softWrap: true,
              overflow: TextOverflow.fade,
            ),
          ),
        ),
        InkWell(
          child: Text(
            _isExpanded ? 'Show less ⤴' : 'More ⤵',
            style: TextStyle(
              color: TAppColor.primaryColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
        ),
      ],
    );
  }
}
