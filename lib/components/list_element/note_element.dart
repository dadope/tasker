import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasker/models/note.dart';
import 'package:tasker/views/edit_note_view.dart';

class NoteElement extends StatelessWidget {
  final int index;
  final Note note;
  final bool selected;
  final bool selectionActive;
  final Function(int index) onLongPress;

  const NoteElement(this.index, this.note, this.onLongPress, this.selectionActive, this.selected, {Key? key}) : super(key: key);

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
              color: selected? Colors.blue : Colors.grey
          ),
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.transparent,
        ),
        child: InkWell(
          onTap: (){
            selectionActive?
              Navigator.pushNamed(context, EditNoteView.routeName, arguments: [index, note]):
              onLongPress(index);
          },
          onLongPress: () => onLongPress(index),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                note.title.isEmpty? const SizedBox.shrink():
                Text(
                  note.title,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                  ),
                ),
                note.content.isEmpty? const SizedBox.shrink():
                Text(
                  note.content,
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
