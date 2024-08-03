import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/presentation/explore/bloc/local/bloc/keyword/keyword_local_bloc.dart';
import 'package:tuannq_movie/presentation/explore/bloc/local/bloc/keyword/keyword_local_event.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/keywordBloc/keyword_bloc.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/keywordBloc/keyword_event.dart';
import 'package:tuannq_movie/presentation/explore/widget/bloc_widget/show_keyword_local_section_widget.dart';
import 'package:tuannq_movie/presentation/explore/widget/bloc_widget/show_keyword_search_for_widget.dart';
import 'package:tuannq_movie/presentation/explore/widget/bloc_widget/show_result_keyword_when_search_widget.dart';

class SearchKeywordResultScreen extends StatefulWidget {
  const SearchKeywordResultScreen({super.key});

  @override
  State<SearchKeywordResultScreen> createState() => _SearchKeywordResultScreenState();
}

class _SearchKeywordResultScreenState extends State<SearchKeywordResultScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    context.read<KeywordLocalBloc>().add(GetStoredKeywordsEvent());
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      context.read<KeywordBloc>().add(GetKeywordBySearchEvent(query: query));
    } else {
      context.read<KeywordBloc>().add(ClearKeywordSearchEvent());
    }
  }

  void _clearSearch() {
    _searchController.clear();
    context.read<KeywordBloc>().add(ClearKeywordSearchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'enter_a_keyword'.tr(),
            hintMaxLines: 1,
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _clearSearch,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ShowKeywordLocalSectionWidget(
                controller: _searchController,
                onSearchChanged: () {
                  _onSearchChanged();
                }),
            16.verticalSpace,
            ShowKeywordSearchForWidget(
              searchController: _searchController,
            ),
            16.verticalSpace,
            ShowResultKeywordWhenSearchWidget(
              clearSearch: () {
                _clearSearch();
              },
            ),
          ],
        ),
      ),
    );
  }
}
