import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/core/constant/app_constant.dart';
import 'package:tuannq_movie/domain/movie/entity/movie_entity.dart';
import 'package:tuannq_movie/manager/widget/custom_dialog_widget.dart';
import 'package:tuannq_movie/presentation/detail_movie/screen/details_movie_screen.dart';
import 'package:tuannq_movie/presentation/home/widget/movie_popular_item_banner_widget.dart';

class HomeAppBarWidget extends StatefulWidget {
  const HomeAppBarWidget({
    super.key,
    required PageController pageController,
    required this.moviesToShow,
    required this.user,
  }) : _pageController = pageController;

  final PageController _pageController;
  final List<MovieEntity> moviesToShow;
  final User user;

  @override
  State<HomeAppBarWidget> createState() => _HomeAppBarWidgetState();
}

class _HomeAppBarWidgetState extends State<HomeAppBarWidget> {
  late Timer timer;
  int _currentPage = 0;

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    widget._pageController.removeListener(_pageListener);
  }

  @override
  void initState() {
    super.initState();
    widget._pageController.addListener(_pageListener);
    startTimer();
  }

  void _pageListener() {
    if (widget._pageController.page!.round() != _currentPage) {
      setState(() {
        _currentPage = widget._pageController.page!.round();
      });
      resetTimer();
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < widget.moviesToShow.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      widget._pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    });
  }

  void resetTimer() {
    timer.cancel();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: AppConstant.defaultExpandedHeight.h,
      pinned: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(),
      ),
      flexibleSpace: PageView.builder(
        controller: widget._pageController,
        itemCount: widget.moviesToShow.length,
        itemBuilder: (context, index) {
          final movieItem = widget.moviesToShow[index];
          return AnimatedBuilder(
            animation: widget._pageController,
            builder: (context, child) {
              double value = 1.0;
              if (widget._pageController.position.haveDimensions) {
                value = widget._pageController.page! - index;
                value = (1 - (value.abs() * .3)).clamp(0.0, 1.0);
              }
              return Transform(
                transform: Matrix4.identity()..rotateY((1 - value) * 0.5),
                child: Opacity(
                  opacity: value,
                  child: MovieItem(
                    movieItem: movieItem,
                    pageController: widget._pageController,
                    onTap: () {
                      if (widget.user.isAnonymous) {
                        showDialog(
                          context: context,
                          builder: ((context) => CustomDialogWidget(
                                titleWarning: 'this_features'.tr(),
                                submitCallback: () {},
                              )),
                        );
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MovieDetailScreen(idMovie: movieItem.id ?? 0, uid: widget.user.uid),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
