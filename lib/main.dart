

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pomodoro_timer_app/pages/calendar/calendar_page.dart';
import 'package:pomodoro_timer_app/pages/calendar/progress_chart.dart';
import 'package:pomodoro_timer_app/pages/timer_choosing/chose_timer_screen.dart';

import 'package:flutter/material.dart';
import 'package:pomodoro_timer_app/pages/timer_choosing/timer_screen.dart';
import 'package:pomodoro_timer_app/provider/picking_calendar_provider.dart';
import 'package:pomodoro_timer_app/provider/timer_spent_value_provider.dart';
import 'package:prayers_times/prayers_times.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimeSpentProvider()),
        ChangeNotifierProvider(create: (_) => SelectedDateProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Lora',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ChooseTimerScreen(),
      ),
    );
  }
}



class StraingPoint extends FlameGame{
  late EmberPlayer _ember;
  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'block.png',
      'ember.png',
      'ground.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
    ]);

    camera.viewfinder.anchor = Anchor.topLeft;

    _ember = EmberPlayer(
      position: Vector2(128, canvasSize.y - 70),
    );
    world.add(_ember);
  }
  }

class EmberPlayer extends SpriteAnimationComponent
    with HasGameReference<StraingPoint> {
  EmberPlayer({
    required super.position,
  }) : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('ember.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(16),
        stepTime: 0.12,
      ),
    );
  }
}




