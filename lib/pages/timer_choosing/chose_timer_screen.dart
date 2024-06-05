import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer_app/pages/timer_choosing/timer_screen.dart';

import '../../model/focus_time_model.dart';
import '../../styles/styles.dart';

class ChooseTimerScreen extends StatefulWidget {
   ChooseTimerScreen({Key? key}) : super(key: key);

  @override
  State<ChooseTimerScreen> createState() => _ChooseTimerScreenState();
}

class _ChooseTimerScreenState extends State<ChooseTimerScreen> {
  int _selectedIndex = 0;

   void _onItemTapped(int index) {
     setState(() {
       _selectedIndex = index;
     });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.complementary,
      appBar: AppBar(
        backgroundColor: Styles.complementary,
        title: Text('Choose time to focus', style: TextStyle(color: Styles.white),),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TimerScreen(time: focusTime[index].time),
                      ),
                    );
                  },
                  child: Card(
                    color: Styles.primary,
                    child: ListTile(
                      trailing: Icon(Icons.access_alarm_outlined),
                      leading: Text(focusTime[index].title,style: TextStyle(color: Styles.white), ),
                      title:  Text(focusTime[index].time, style: TextStyle(color: Styles.white),),
                    ),
                  ),
                );
              },
              childCount: focusTime.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Styles.complementary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Timer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Achivments',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Styles.primary,
        unselectedItemColor: Styles.secondary,
        onTap: (int index) {
          _onItemTapped(index);
        },
      ),
    );
  }
}

