import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

//TODO: Implement https://www.flutterclutter.dev/flutter/tutorials/date-format-dynamic-string-depending-on-how-long-ago/2020/229/

class DatePicker extends StatelessWidget {
  const DatePicker(this.dueDate, this.highlight, this.saveNote, {Key? key}) : super(key: key);

  final DateTime dueDate;
  final Color? highlight;
  final Function saveNote;

  @override
  Widget build(BuildContext context) {

    // TODO: use only one function to get date and time
    void _selectDateAndTime() async {
      final DateTime pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day
        ),
        lastDate: DateTime(2100),
        initialDate: dueDate,
      )?? dueDate;

      final TimeOfDay pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(
              hour: dueDate.hour,
              minute: 0
          )
      )?? TimeOfDay.fromDateTime(dueDate);

      DateTime pickedDateTime = DateTime(
          pickedDate.year, pickedDate.month, pickedDate.day,
          pickedTime.hour, pickedTime.minute
      );

      saveNote(pickedDateTime);
    }

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: (){
              _selectDateAndTime();
            },
            child: Container(
              decoration: BoxDecoration(
                color: highlight?? Colors.grey,
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: useWhiteForeground(highlight)?
                    Colors.white:Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      DateFormat('MMM dd, kk:mm').format(dueDate),
                      style: TextStyle(
                          color: useWhiteForeground(highlight)?
                          Colors.white:Colors.black
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}