import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeSpentProvider extends ChangeNotifier {
  int workMinutes = 1;
  int breakMinutes = 5;
  int pomodoroCount = 0;
  int currentMinutes = 0;
  int currentSeconds = 0;

  Timer? timer;
  SharedPreferences? _prefs;


  PomodoroModel() {
    initSharedPreferences();
  }

  void initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    pomodoroCount = _prefs?.getInt('pomodoroCount') ?? 0;
  }

  Future<void> savePomodoroCount() async {
    await _prefs?.setInt('pomodoroCount', pomodoroCount);
  }

  void startWorkTimer() {
    currentMinutes = workMinutes;
    currentSeconds = 0;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (currentSeconds > 0) {
        currentSeconds--;
      } else {
        if (currentMinutes > 0) {
          currentMinutes--;
          currentSeconds = 59;
        } else {
          timer.cancel();
          pomodoroCount++;
          savePomodoroCount();
          if (pomodoroCount < 4) {
            startBreakTimer();
          } else {
            resetPomodoro();
          }
        }
      }
      notifyListeners();
    });
  }

  void startBreakTimer() {
    currentMinutes = breakMinutes;
    currentSeconds = 0;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentSeconds > 0) {
        currentSeconds--;
      } else {
        if (currentMinutes > 0) {
          currentMinutes--;
          currentSeconds = 59;
        } else {
          timer.cancel();
          startWorkTimer();
        }
      }
      notifyListeners();
    });
  }

  void resetPomodoro() {
    pomodoroCount = 0;
    savePomodoroCount();
    notifyListeners();
  }
}

