import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/data/local/tv_show/datasource/cached_db_tv_show_hepler.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/manager/widget/layout_error_widget.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/search/search_bloc.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/search/search_event.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/tvShowBloc/tvshow_bloc.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/tvShowBloc/tvshow_event.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/tvShowBloc/tvshow_state.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/tvShowPopularBloc/tv_show_popular_bloc.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/tvShowPopularBloc/tv_show_popular_event.dart';
import 'package:tuannq_movie/presentation/explore/widget/bloc_widget/tv_show_arings_today_widget.dart';
import 'package:tuannq_movie/presentation/explore/widget/bloc_widget/tv_show_most_popular_widget.dart';
import 'package:tuannq_movie/presentation/explore/widget/button_search_widget.dart';
import 'package:tuannq_movie/presentation/explore/widget/text_title_widget.dart';

class LayoutExploreWidget extends StatefulWidget {
  const LayoutExploreWidget({
    super.key,
  });

  @override
  State<LayoutExploreWidget> createState() => _LayoutExploreWidgetState();
}

class _LayoutExploreWidgetState extends State<LayoutExploreWidget> {
  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    context.read<SearchBloc>().add(CheckUserStatusEvent());
    context.read<TvshowBloc>().add(const GetTVShowAirToDayEvent());
    context.read<TvShowPopularBloc>().add(const GetTvShowPopularListEvent());
  }

  Future<void> _refresh() async {
    final databaseHelper = DatabaseTvShowCachedHelper();
    await databaseHelper.deleteAllTvShow();
    _loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('explore'.tr()),
        actions: const <Widget>[ButtonSearchWidget()],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: BlocBuilder<TvshowBloc, TvshowState>(
          builder: (context, state) {
            if (state.status == Status.failure) {
              return ErrorLayoutWidget(
                  tap: () {
                    _refresh();
                  },
                  message: 'Opps! Something went wrong. Please try again later.');
            }
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextTitleExploreWidget(
                      title: 'tv_show_airing_today'.tr(),
                    ),
                    16.verticalSpace,
                    const TvShowsAiringToday(),
                    16.verticalSpace,
                    TextTitleExploreWidget(
                      title: 'tv_show_most_popular'.tr(),
                    ),
                    16.verticalSpace,
                    const TvShowsMostPopular(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
