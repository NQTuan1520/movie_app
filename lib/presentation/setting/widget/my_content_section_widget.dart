import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tuannq_movie/presentation/feed/screen/feed_of_each_user_screen.dart';
import 'package:tuannq_movie/presentation/setting/widget/preference_item_widget.dart';

class MyContentSectionWidget extends StatelessWidget {
  const MyContentSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FeedOfEachUserScreen(),
          ),
        );
      },
      child: PreferenceItemWidget(
        context: context,
        icon: Icons.space_dashboard_outlined,
        title: 'my_shared'.tr(),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
