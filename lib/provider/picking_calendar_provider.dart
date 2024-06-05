import 'package:flutter/cupertino.dart';

class SelectedDateProvider extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;
  List<String> tasks = [];

  void updateSelectedDate(DateTime newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }

  void addTask(String task) {
    tasks.add(task);
    notifyListeners();
  }

  void removeTask(int index) {
    tasks.removeAt(index);
    notifyListeners();
  }

  String formatDate(DateTime taskDate, DateTime selectedDate) {
    final difference = taskDate.difference(selectedDate);
    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Tomorrow';
    } else {
      return 'In ${difference.inDays} days';
    }
  }
}