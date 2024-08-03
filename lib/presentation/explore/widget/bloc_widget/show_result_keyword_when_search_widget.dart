import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/manager/color.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/presentation/explore/bloc/local/bloc/keyword/keyword_local_bloc.dart';
import 'package:tuannq_movie/presentation/explore/bloc/local/bloc/keyword/keyword_local_event.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/keywordBloc/keyword_bloc.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/keywordBloc/keyword_state.dart';
import 'package:tuannq_movie/presentation/explore/result_of_search_by_keyword.dart';

class ShowResultKeywordWhenSearchWidget extends StatelessWidget {
  final GestureTapCallback clearSearch;
  const ShowResultKeywordWhenSearchWidget({super.key, required this.clearSearch});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<KeywordBloc, KeywordState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == Status.success) {
            return ListView.builder(
              itemCount: state.listKeyword.length,
              itemBuilder: (context, index) {
                final itemKeyword = state.listKeyword[index];
                return GestureDetector(
                  onTap: () {
                    context.read<KeywordLocalBloc>().add(AddKeywordEvent(keyword: itemKeyword.name ?? 'NaN'));
                    clearSearch();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResultMovieOfSearchByKeyword(
                                  keywordSearched: itemKeyword.name,
                                )));
                  },
                  child: ListTile(
                    title: Text(
                      itemKeyword.name ?? 'NaN',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? TAppColor.whiteLightColor
                            : TAppColor.darkFadeBlueColor,
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state.status == Status.failure) {
            return Center(child: Text(state.message.toString()));
          } else if (state.status == Status.initial) {
            return const SizedBox.shrink();
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
