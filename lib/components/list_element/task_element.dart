import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:tasker/models/task.dart';
import 'package:tasker/views/edit_item_view.dart';

import '../utils.dart';

class TaskElement extends StatelessWidget {
  final Task task;
  final bool selected;
  final bool selectionActive;
  final Function(Task selectedTask) onLongPress;

  const TaskElement(this.task, this.onLongPress, this.selectionActive, this.selected, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 4.0
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              width: 2.0,
              color: selected? Colors.blue :
                task.highlightColor?? Colors.grey
          ),
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.transparent,
        ),
        child: InkWell(
          onTap: (){
            selectionActive?
              Navigator.pushNamed(context, EditItemView.routeName, arguments: [task]):
              onLongPress(task);
          },
          onLongPress: () => onLongPress(task),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: task.title.isEmpty?
                        const SizedBox.shrink():
                        Text(
                          task.title,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    Container(
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
                    )
                  ]
                ),
                task.content.isEmpty?
                  const SizedBox.shrink():
                  Text(
                    task.content,
                    maxLines: 3,
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.left,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
