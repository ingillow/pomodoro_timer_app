import 'package:flutter/material.dart';

import '../../provider/picking_calendar_provider.dart';
import '../../styles/styles.dart';

import 'package:provider/provider.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar() : super();

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final selectedDateProvider = Provider.of<SelectedDateProvider>(context);
    final selectedDate = selectedDateProvider.selectedDate;

    return Scaffold(
        backgroundColor: Styles.complementary,
        appBar: AppBar(
          title: Text(
            'Progress by days',
            style: TextStyle(color: Styles.white),
          ),
          backgroundColor: Styles.complementary,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                  ),
                  itemCount: DateTime.daysPerWeek * 6,
                  itemBuilder: (context, index) {
                    final dayOfMonth = index - selectedDate.weekday + 1;
                    final dateTime = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      dayOfMonth,
                    );
                    final isCurrentMonth = dateTime.month == selectedDate.month;
                    final isSelectedDay = dateTime.day == selectedDate.day;

                    return GestureDetector(
                      onTap: () {
                        selectedDateProvider.updateSelectedDate(dateTime);
                      },
                      onDoubleTap: () {
                        _showEditDialog(context, selectedDateProvider);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: isCurrentMonth
                              ? (isSelectedDay ? Styles.primary.withOpacity(0.5) : Styles.secondary)
                              : Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          isCurrentMonth ? '$dayOfMonth' : '',
                          style: TextStyle(
                            color: isCurrentMonth ? Colors.white : Colors.black,
                            fontWeight: isSelectedDay ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Consumer<SelectedDateProvider>(
                  builder: (context, taskProvider, _) {
                    return ListView.builder(
                      itemCount: taskProvider.tasks.length,
                      itemBuilder: (context, index) {
                        print(taskProvider.tasks.length);
                        return Dismissible(
                          key: Key(taskProvider.tasks[index]),
                          onDismissed: (direction) {
                            taskProvider.removeTask(index);
                          },
                          background: DecoratedBox(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Styles.secondary,),
                          ),
                          child: Card(
                            color: Styles.primary,
                            child: ListTile(
                              trailing: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              title: Text(taskProvider.tasks[index], style: TextStyle(color: Styles.white),),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }

  void _showEditDialog(BuildContext context, SelectedDateProvider taskProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Tasks for a Day'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: ''),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Save'),
              onPressed: () {
                Navigator.of(context).pop();
                taskProvider.addTask(_controller.text);
                _controller.clear();
              },
            ),
          ],
        );
      },
    );
  }
}
