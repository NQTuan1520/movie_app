import 'package:flutter/material.dart';
import 'package:tuannq_movie/manager/color.dart';

class GenreChip extends StatelessWidget {
  final String label;

  const GenreChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      child: Chip(
        label: Text(label),
        avatar: Icon(
          Icons.calendar_month,
          color:
              Theme.of(context).brightness == Brightness.dark ? TAppColor.whiteLightColor : TAppColor.darkFadeBlueColor,
        ),
        backgroundColor: Colors.black.withOpacity(0.08),
      ),
    );
  }
}
