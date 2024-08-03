import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/presentation/feed/bloc/shared_bloc/shared_bloc.dart';
import 'package:tuannq_movie/presentation/feed/bloc/shared_bloc/shared_event.dart';

class ErrorStatusWidget extends StatelessWidget {
  const ErrorStatusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('something_wrong'.tr()),
          ElevatedButton(
            onPressed: () {
              context.read<SharedBloc>().add(const GetAllSharedEvent());
            },
            child: const Text('Retry'),
          )
        ],
      ),
    );
  }
}
