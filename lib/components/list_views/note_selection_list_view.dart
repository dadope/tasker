import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:tasker/models/item.dart';
import 'package:tasker/models/note.dart';
import 'package:tasker/models/task.dart';
import 'package:tasker/components/list_element/task_element.dart';
import 'package:tasker/components/list_element/note_element.dart';

class NoteSelectionListView extends StatelessWidget {
  final List<Item> items;
  final List<Item> selectedIndices;
  final Function(Item selectedItem) onLongPress;

  const NoteSelectionListView(this.items, this.selectedIndices, {required this.onLongPress, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool selectionActive = selectedIndices.isEmpty;

    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index){
          Item item = items.elementAt(index);
          bool selected = selectedIndices.contains(item);
          switch (item.runtimeType){
            case Task:
              return TaskElement(
                item as Task,
                onLongPress,
                selectionActive,
                selected
              );
            case Note:
              return NoteElement(
                item as Note,
                onLongPress,
                selectionActive,
                selected
              );
            default:
              return const SizedBox.shrink();
          }
        }
    );
  }
}