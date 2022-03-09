import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tasker/models/note.dart';
import 'package:tasker/bloc/item_manager/item_manager_bloc.dart';
import 'package:tasker/components/appbars/add_and_edit_item_appbar.dart';
import 'package:tasker/components/textfield/title_input_field.dart';
import 'package:tasker/components/textfield/content_input_field.dart';

class CreateNoteView extends StatelessWidget {
  static bool alreadySaved = false;
  static const String routeName = "/createNoteView";

  const CreateNoteView({Key? key}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    Note noteToSave = Note();
    bool alreadySaved = false;

    final ItemManagerBloc dataBloc = BlocProvider.of<ItemManagerBloc>(context);

    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    void saveNote(_){
      noteToSave.title = titleController.text;
      noteToSave.content = contentController.text;

      if (!alreadySaved){
        alreadySaved = true;
        dataBloc.add(ItemManagerAddItem(noteToSave));
      } else {
        dataBloc.add(ItemManagerEditItem(noteToSave));
      }
    }

    return Scaffold(
      body: Column(
        children: [
          const AddAndEditItemAppBar(),
          TitleInputField(titleController, saveNote),
          ContentInputField(contentController, saveNote)
        ],
      ),
    );
  }
}
