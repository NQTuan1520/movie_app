import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class TimeTracker with WidgetsBindingObserver {
  static final TimeTracker _instance = TimeTracker._internal();

  factory TimeTracker() {
    return _instance;
  }

  TimeTracker._internal();

  late DateTime _startTime;
  late SharedPreferences _prefs;
  late String uid;

  Future<void> init(String userId) async {
    _prefs = await SharedPreferences.getInstance();
    uid = userId;
    WidgetsBinding.instance.addObserver(this);
  }

  void startTracking() {
    _startTime = DateTime.now();
  }

  Future<void> stopTracking() async {
    final endTime = DateTime.now();
    final duration = endTime.difference(_startTime);
    await _updateTime(duration);
  }

  Future<void> _updateTime(Duration duration) async {
    final now = DateTime.now();
    final today = DateFormat('yyyy-MM-dd').format(now);
    final weekOfYear = getWeekOfYear(now);

    final dailyKey = '${uid}_daily_$today';
    final weeklyKey = '${uid}_weekly_$weekOfYear';

    final dailyTime = _prefs.getInt(dailyKey) ?? 0;
    final weeklyTime = _prefs.getInt(weeklyKey) ?? 0;

    await _prefs.setInt(dailyKey, dailyTime + duration.inSeconds);
    await _prefs.setInt(weeklyKey, weeklyTime + duration.inSeconds);
  }

  int getWeekOfYear(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysSinceFirstDay = date.difference(firstDayOfYear).inDays;
    return (daysSinceFirstDay / 7).ceil();
  }

  Future<Map<String, int>> getDailyUsageStats(
      DateTime startDate, int days) async {
    final Map<String, int> dailyStats = {};
    for (int i = 0; i < days; i++) {
      final day =
          DateFormat('yyyy-MM-dd').format(startDate.add(Duration(days: i)));
      dailyStats[day] = _prefs.getInt('${uid}_daily_$day') ?? 0;
    }
    return dailyStats;
  }

  Future<Map<String, int>> getWeeklyUsageStats(
      int year, int startWeek, int weeks) async {
    final Map<String, int> weeklyStats = {};
    for (int i = 0; i < weeks; i++) {
      final weekKey = '${uid}_weekly_${year}_${startWeek + i}';
      weeklyStats[weekKey] = _prefs.getInt(weekKey) ?? 0;
    }
    return weeklyStats;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      startTracking();
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      stopTracking();
    }
  }
}
