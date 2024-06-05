
class FocusTimeModel{
  final String time;
  final String title;
  FocusTimeModel({required this.title, required this.time});
}

final List<FocusTimeModel> focusTime = [
  FocusTimeModel(title: 'Focus Time', time: '30 min'),
  FocusTimeModel(title: 'Focus Time', time: '1 hour'),
  FocusTimeModel(title: 'Focus Time', time: '1 hour 30 min'),
];