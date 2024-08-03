import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/manager/enum/stat_status_enum.dart';
import 'package:tuannq_movie/presentation/stat/bloc/stat_bloc.dart';
import 'package:tuannq_movie/presentation/stat/bloc/stat_event.dart';
import 'package:tuannq_movie/presentation/stat/bloc/stat_state.dart';
import 'package:tuannq_movie/presentation/stat/widget/bar_chart_widget.dart';

class MyStatScreen extends StatefulWidget {
  const MyStatScreen({super.key});

  @override
  State<MyStatScreen> createState() => _MyStatScreenState();
}

class _MyStatScreenState extends State<MyStatScreen> {
  late StreamSubscription<User?> _authSubscription;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser!;
    uid = user.uid;

    context.read<StatBloc>().add(LoadDailyUsageStats(uid));

    _authSubscription = _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        context.read<StatBloc>().add(LoadDailyUsageStats(user.uid));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("my_stat".tr()),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'view_frequency'.tr(),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'your_peak_viewing'.tr(),
              style: TextStyle(
                fontSize: 14.sp,
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<StatBloc, StatState>(
                builder: (context, state) {
                  if (state.status == StatStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == StatStatus.failure) {
                    return Center(child: Text("Error: ${state.errorMessage}", style: const TextStyle()));
                  } else if (state.status == StatStatus.success && state.dailyUsageStats.isEmpty) {
                    return const Center(child: Text("No usage data available", style: TextStyle()));
                  } else if (state.status == StatStatus.success) {
                    final dailyStats = state.dailyUsageStats;
                    return BarChartWidget(dailyStats: dailyStats);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
