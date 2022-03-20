import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:tasker/models/item.dart';
import 'package:tasker/models/note.dart';
import 'package:tasker/models/tag.dart';
import 'package:tasker/models/task.dart';
import 'package:tasker/components/elements/item_element.dart';

class NoteSelectionListView extends StatelessWidget {
  final List<Item> items;
  final List<Item> selectedIndices;
  final Function(Tag)? searchTag;
  final Function(Item) onLongPress;

  const NoteSelectionListView(this.items, this.selectedIndices, {required this.onLongPress, this.searchTag, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool selectionActive = selectedIndices.isEmpty;

    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index){
          Item item = items.elementAt(index);
          bool selected = selectedIndices.contains(item);
          if (item is Task || item is Note) {
            return ItemElement(
                item,
                onLongPress,
                selectionActive,
                selected,
                searchTag: searchTag,
              );
          } else {
            return const SizedBox.shrink();
          }
        }
    );
  }
}