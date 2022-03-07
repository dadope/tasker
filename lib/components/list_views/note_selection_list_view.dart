import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasker/bloc/note_manager/note_manager_bloc.dart';
import 'package:tasker/components/list_element/note_element.dart';
import 'package:tasker/models/note.dart';

class NoteSelectionListView extends StatelessWidget {
  final List<Note> notes;
  final void Function(int index) onLongPress;

  final List<int> selectedIndices;

  const NoteSelectionListView(this.notes, this.selectedIndices, {required this.onLongPress, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool selectionActive = selectedIndices.isEmpty;
    final NoteManagerBloc dataBloc = BlocProvider.of<NoteManagerBloc>(context);


    return ListView.builder(
        itemCount: notes.length,
        itemBuilder: (BuildContext context, int index){
          bool selected = selectedIndices.contains(index);
          Note note = notes.elementAt(index);

          if(note.title.isEmpty && note.content.isEmpty) {
            dataBloc.add(NoteManagerRemoveNote(index));
            return const SizedBox.shrink();
          }

          return NoteElement(
            index,
            note,
            onLongPress,
            selectionActive,
            selected
          );
        }
    );
  }
}