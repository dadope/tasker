import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tasker/models/note.dart';
import 'package:tasker/bloc/note_manager/note_manager_bloc.dart';
import 'package:tasker/components/appbars/add_and_edit_note_appbar.dart';
import 'package:tasker/components/textfield/title_input_field.dart';
import 'package:tasker/components/textfield/content_input_field.dart';

class EditNoteView extends StatelessWidget {
  static const String routeName = "/editNoteView";

  final int indexToEdit;
  final Note noteToEdit;

  const EditNoteView(this.indexToEdit, this.noteToEdit, {Key? key}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();
    final NoteManagerBloc dataBloc = BlocProvider.of<NoteManagerBloc>(context);

    void saveNote(_){
      Note editedNote =
        Note(titleController.text, content: contentController.text);
      dataBloc.add(NoteManagerEditNote(indexToEdit, editedNote));
    }

    return Scaffold(
      body: Column(
        children: [
          const AddAndEditNoteAppBar(),
          TitleInputField(titleController, saveNote, title: noteToEdit.title),
          ContentInputField(contentController, saveNote, content: noteToEdit.content)
        ],
      ),
    );
  }
}
