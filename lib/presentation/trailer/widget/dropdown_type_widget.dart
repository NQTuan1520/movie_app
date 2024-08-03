import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/manager/color.dart';

class DropDownTypeWidget extends StatelessWidget {
  final String currentTrailerType;
  final ValueChanged<String?> onChanged;

  const DropDownTypeWidget({
    super.key,
    required this.currentTrailerType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? TAppColor.primaryColor.withOpacity(0.4)
            : TAppColor.whiteGreyColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentTrailerType,
          icon: const Icon(Icons.arrow_downward),
          onChanged: onChanged,
          items: <String>['Teaser', 'Clip', 'Behind the Scenes', 'Featurette', 'Trailer']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? TAppColor.whiteLightColor
                      : TAppColor.darkFadeBlueColor,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
