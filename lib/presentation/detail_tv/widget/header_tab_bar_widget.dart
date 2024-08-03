import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../manager/color.dart';

class HeaderTabBarWidget extends StatelessWidget {
  const HeaderTabBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _SliverAppBarDelegate(
        TabBar(
          labelColor: TAppColor.primaryColor,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(
              text: 'Episodes'.tr(),
            ),
            Tab(
              text: 'Suggested'.tr(),
            ),
            Tab(
              text: 'About'.tr(),
            ),
            Tab(
              text: 'Review'.tr(),
            )
          ],
        ),
      ),
      pinned: true,
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).brightness == Brightness.dark ? TAppColor.darkFadeBlueColor : TAppColor.whiteLightColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
