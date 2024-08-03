import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/core/time_tracking/time_tracker.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/search/search_bloc.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/search/search_event.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/search/search_state.dart';

import 'package:tuannq_movie/presentation/explore/widget/layout_explore_widget.dart';
import 'package:tuannq_movie/presentation/fab_screen/widget/layout_guest_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(CheckUserStatusEvent());
    TimeTracker().startTracking();
  }

  @override
  void dispose() {
    super.dispose();
    TimeTracker().stopTracking();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.status == Status.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == Status.success) {
          return state.isGuest ? const LayoutGuestWidget() : const LayoutExploreWidget();
        } else {
          return const Center(child: Text('An error occurred'));
        }
      },
    );
  }
}
