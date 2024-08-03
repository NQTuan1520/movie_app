import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/searchMovieBloc/search_movie_bloc.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/searchMovieBloc/search_movie_event.dart';
import 'package:tuannq_movie/presentation/explore/widget/button_show_dialog_filter_widget.dart';
import 'package:tuannq_movie/presentation/explore/widget/header_of_search_result_widget.dart';

import 'widget/bloc_widget/gridview_result_of_search_widget.dart';

class ResultMovieOfSearchByKeyword extends StatefulWidget {
  final String? keywordSearched;
  const ResultMovieOfSearchByKeyword({super.key, required this.keywordSearched});

  @override
  State<ResultMovieOfSearchByKeyword> createState() => _ResultMovieOfSearchByKeywordState();
}

class _ResultMovieOfSearchByKeywordState extends State<ResultMovieOfSearchByKeyword> {
  String uid = '';
  User user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser!;
    uid = user.uid;

    context.read<SearchMovieBloc>().add(GetMovieBySearchEvent(query: widget.keywordSearched ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('search_result'.tr()),
        actions: [
          ButtonShowDialogFilterWidget(widget: widget),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderOfSearchResultWidget(widget: widget),
              16.verticalSpace,
              GridviewResultSearchWidget(uid: uid)
            ],
          ),
        ),
      ),
    );
  }
}
