import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tuannq_movie/presentation/setting/widget/preference_item_widget.dart';
import 'package:tuannq_movie/presentation/stat/my_stat_screen.dart';

class StatSectionWidget extends StatelessWidget {
  const StatSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyStatScreen()),
        );
      },
      child: PreferenceItemWidget(
        context: context,
        icon: Icons.timelapse,
        title: 'my_stat'.tr(),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
