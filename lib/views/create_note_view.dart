import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tasker/models/note.dart';
import 'package:tasker/bloc/note_manager/note_manager_bloc.dart';
import 'package:tasker/components/appbars/add_and_edit_note_appbar.dart';
import 'package:tasker/components/textfield/title_input_field.dart';
import 'package:tasker/components/textfield/content_input_field.dart';

class CreateNoteView extends StatelessWidget {
  static bool alreadySaved = false;
  static const String routeName = "/createNoteView";

  final int listLen;

  const CreateNoteView(this.listLen, {Key? key}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    bool savedNote = false;
    final NoteManagerBloc dataBloc = BlocProvider.of<NoteManagerBloc>(context);

    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    void saveNote(_){
      if (titleController.text.isEmpty && contentController.text.isEmpty) {
        return;
      }

      Note noteToInsert = Note(titleController.text, content: contentController.text);

      if (!savedNote){
        savedNote = true;
        dataBloc.add(NoteManagerAddNote(noteToInsert));
      } else {
        dataBloc.add(NoteManagerEditNote(listLen, noteToInsert));
      }
    }

    return Scaffold(
      body: Column(
        children: [
          const AddAndEditNoteAppBar(),
          TitleInputField(titleController, saveNote),
          ContentInputField(contentController, saveNote)
        ],
      ),
    );
  }
}
