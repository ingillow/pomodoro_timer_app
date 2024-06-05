
import 'package:flutter/material.dart';
import 'package:pomodoro_timer_app/styles/styles.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(itemBuilder: (context, builder){
      return SizedBox(
        child: ColoredBox(
          color: Styles.primary,
        ),
      );
    });
  }
}
