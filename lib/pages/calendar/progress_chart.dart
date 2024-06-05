import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/timer_spent_value_provider.dart';


class ChartsScreen extends StatefulWidget {
  const ChartsScreen({super.key});

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  int _savedSeconds = 0;

  @override
  void initState() {
    super.initState();
    _getSavedSeconds().then((value) {
      setState(() {
        _savedSeconds = value;
      });
    });
  }

  Future<int> _getSavedSeconds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('seconds') ?? 0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Charts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'here you can see overall focus time',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Consumer<TimeSpentProvider>(
              builder: (context, timeSpentProvider, _) {
                return Expanded(
                  child: Column(
                    children: [
                      CustomPaint(
                        size: Size(double.infinity, 200),
                        painter: BarChartPainter(_savedSeconds),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Date: ${DateTime.now().month}/${DateTime.now().day} - Total Time:',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    return '$hours hours $minutes minutes';
  }
}

class BarChartPainter extends CustomPainter {
  final int totalTime;

  BarChartPainter(this.totalTime);

  @override
  void paint(Canvas canvas, Size size) {
    final barPaint = Paint()..color = Colors.blue;

    const barWidth = 20.0;
    final barHeight = size.height * (totalTime / 3600);


    canvas.drawRect(Rect.fromLTWH((size.width - barWidth) / 2, size.height - barHeight, barWidth, barHeight), barPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}