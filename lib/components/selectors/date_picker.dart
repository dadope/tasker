import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//TODO: Implement https://www.flutterclutter.dev/flutter/tutorials/date-format-dynamic-string-depending-on-how-long-ago/2020/229/

class DatePicker extends StatefulWidget {
  DateTime dueDate;
  final Function saveNote;

  DatePicker(this.dueDate, this.saveNote, {Key? key}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {

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
        initialDate: widget.dueDate,
      )?? widget.dueDate;

      final TimeOfDay pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(widget.dueDate)
      )?? TimeOfDay.fromDateTime(widget.dueDate);

      DateTime pickedDateTime = DateTime(
        pickedDate.year, pickedDate.month, pickedDate.day,
        pickedTime.hour, pickedTime.minute
      );

      widget.saveNote("_", date:pickedDateTime);

      setState(() {
        widget.dueDate = pickedDateTime;
      });
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
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      DateFormat('MMM dd, kk:mm').format(widget.dueDate),
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