import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tasker/models/note.dart';
import 'package:tasker/bloc/item_manager/item_manager_bloc.dart';
import 'package:tasker/components/appbars/add_and_edit_item_appbar.dart';
import 'package:tasker/components/textfield/title_input_field.dart';
import 'package:tasker/components/textfield/content_input_field.dart';

class EditNoteView extends StatelessWidget {
  static const String routeName = "/editNoteView";

  final Note noteToEdit;

  const EditNoteView(this.noteToEdit, {Key? key}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();
    final ItemManagerBloc dataBloc = BlocProvider.of<ItemManagerBloc>(context);

    void saveNote(_){
      noteToEdit.title = titleController.text;
      noteToEdit.content = contentController.text;
      dataBloc.add(ItemManagerEditItem(noteToEdit));
    }

    return Scaffold(
      body: Column(
        children: [
          const AddAndEditItemAppBar(),
          TitleInputField(titleController, saveNote, title: noteToEdit.title),
          ContentInputField(contentController, saveNote, content: noteToEdit.content)
        ],
      ),
    );
  }
}
