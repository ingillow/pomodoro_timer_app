import 'package:flutter/material.dart';
import 'package:pomodoro_timer_app/pages/calendar/progress_chart.dart';
import 'package:pomodoro_timer_app/pages/timer_choosing/timer_widget.dart';
import 'package:pomodoro_timer_app/styles/styles.dart';

import '../calendar/calendar_page.dart';

class TimerScreen extends StatefulWidget {
  final String time;
  const TimerScreen({super.key, required this.time});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.complementary,
      body: TimerWidget(
        title: widget.time,
      ),
    );
  }
}
