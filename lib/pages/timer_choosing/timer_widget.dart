import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/timer_spent_value_provider.dart';
import '../animation/ripple_wave.dart';

class TimerWidget extends StatefulWidget {
  final String title;

  const TimerWidget({Key? key, required this.title}) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget>
    with SingleTickerProviderStateMixin {

  late AnimationController _rippleController;
  @override
  void initState() {
    super.initState();
    _rippleController = AnimationController(
      duration: Duration(milliseconds: 5000),
      vsync: this,
    );

  }

  @override
  void dispose() {
    _rippleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TimeSpentProvider>(context);
    return InkWell(
      onTap: (){
        if (model.timer != null && model.timer!.isActive) {
          model.timer?.cancel();
        } else {
          model.startWorkTimer();
        }
      },
      borderRadius: BorderRadius.circular(130),
      child: Stack(
        children: [
          RippleWave(
            animationController: _rippleController,
            color: Colors.blue.withOpacity(0.5),
            duration: Duration(milliseconds: 1500),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: model.timer != null && model.timer!.isActive ? Color(0xFFe0f2f1) : Colors.grey[300],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Flexible(
                      child: Text(
                        '${model.currentMinutes.toString().padLeft(2, '0')}:${model.currentSeconds.toString().padLeft(2, '0')}',
                        style: TextStyle(fontSize: 60),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
       /*   if (_secondsRemaining == 0)
            Positioned(
              bottom: 10,
              right: 10,
              child: Column(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 40,
                  ),
                  Consumer<TimeSpentProvider>(
                    builder: (context, timeSpentProvider, _) {
                      return Text(
                        '${timeSpentProvider.totalSeconds}',
                        style: TextStyle(fontSize: 20),
                      );
                    },
                  ),
                  Text(
                    'You can go and see how is your progress going',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),*/
        ],
      ),
    );
  }
}

