import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../di/injection.dart';
import '../../../domain/cast/usecase/cast_usecase.dart';
import '../../../domain/review/usecase/review_usecase.dart';
import '../../../domain/shared/usecase/shared_usecase.dart';
import '../../../domain/tv_show/usecase/tv_show_usecase.dart';
import '../../../domain/tv_show_detail/usecase/tv_detail_usecase.dart';
import '../../../manager/enum/status_enum.dart';
import '../../../manager/widget/custom_spin_widget.dart';
import '../../../manager/widget/layout_error_widget.dart';
import '../../feed/bloc/shared_bloc/shared_bloc.dart';
import '../bloc/cast_tv/cast_tv_bloc.dart';
import '../bloc/cast_tv/cast_tv_event.dart';
import '../bloc/detail_tv/detail_tv_bloc.dart';
import '../bloc/detail_tv/detail_tv_event.dart';
import '../bloc/detail_tv/detail_tv_state.dart';
import '../bloc/review/review_tv_bloc.dart';
import '../bloc/review/review_tv_event.dart';
import '../bloc/similar_tv_show/similar_tv_show_bloc.dart';
import '../bloc/similar_tv_show/similar_tv_show_event.dart';
import '../widget/detail_tv_section_widget.dart';

class DetailTvScreen extends StatefulWidget {
  final int idTvShow;

  const DetailTvScreen({super.key, required this.idTvShow});

  @override
  State<DetailTvScreen> createState() => _DetailTvScreenState();
}

class _DetailTvScreenState extends State<DetailTvScreen> {
  int get idTvShow => widget.idTvShow;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => SharedBloc(
              sl<SharedPostUseCase>(),
            ),
          ),
          BlocProvider(
            create: (context) => CastTvBloc(sl<CastUseCase>())
              ..add(
                GetCastTVDetailEvent(idTvShow),
              ),
          ),
          BlocProvider(
            create: (context) => DetailTvBloc(sl<TVDetailUseCase>())
              ..add(
                GetDetailTvEvent(idTvShow),
              ),
          ),
          BlocProvider(
            create: (context) => ReviewTvBloc(sl<ReviewUseCase>())
              ..add(
                GetReviewTVShowEvent(idTvShow),
              ),
          ),
          BlocProvider(
            create: (context) => SimilarTvShowBloc(sl<TVShowUseCase>())
              ..add(
                GetSimilarTVEvent(idTvShow.toString()),
              ),
          ),
        ],
        child: BlocBuilder<DetailTvBloc, DetailTvState>(
          builder: (context, state) {
            if (state.status == Status.loading) {
              return SpinCustomWidget(
                sized: 50.r,
              );
            } else if (state.status == Status.failure) {
              return ErrorLayoutWidget(
                tap: () {
                  context.read<DetailTvBloc>().add(GetDetailTvEvent(widget.idTvShow));
                },
                message: '//${state.message}',
              );
            }
            if (state.status == Status.success) {
              final tvDetail = state.tvDetailEntity;
              final String lastAirDate = tvDetail?.lastAirDate ?? 'N/A';
              final String lastAirYear = lastAirDate != 'N/A' ? DateTime.parse(lastAirDate).year.toString() : 'N/A';

              return DetailTVSectionWidget(
                tvDetail: tvDetail!,
                lastAirYear: lastAirYear,
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
