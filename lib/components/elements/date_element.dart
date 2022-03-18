import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:tasker/models/task.dart';

import '../utils.dart';

class DateElement extends StatelessWidget {
  const DateElement(this.task, {Key? key}) : super(key: key);
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: task.highlightColor?? Colors.grey.shade400,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
        child: Row(
            children: [
              Icon(
                  Icons.calendar_today_outlined,
                  size: 20,
                  color: useWhiteForeground(task.highlightColor)?
                  Colors.white:Colors.black
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    DateFormat('MMM dd, kk:mm').format(task.dueDate),
                    style: TextStyle(
                        color: useWhiteForeground(task.highlightColor)?
                        Colors.white:Colors.black
                    ),
                  )
              )
            ]
        )
    );
  }
}
