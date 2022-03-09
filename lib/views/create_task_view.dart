import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasker/components/selectors/date_picker.dart';

import 'package:tasker/bloc/item_manager/item_manager_bloc.dart';
import 'package:tasker/components/appbars/add_and_edit_item_appbar.dart';
import 'package:tasker/components/textfield/title_input_field.dart';
import 'package:tasker/components/textfield/content_input_field.dart';
import 'package:tasker/models/task.dart';

class CreateTaskView extends StatelessWidget {
  static bool alreadySaved = false;
  static const String routeName = "/createTaskView";

  const CreateTaskView({Key? key}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    Task taskToSave = Task();
    bool alreadySaved = false;

    final ItemManagerBloc dataBloc = BlocProvider.of<ItemManagerBloc>(context);

    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    void saveTask(_, {String? title, String? content, DateTime? date}){
      taskToSave.title = titleController.text;
      taskToSave.content = contentController.text;

      if(date != null){
        taskToSave.dueDate = date;
      }

      if (!alreadySaved){
        alreadySaved = true;
        dataBloc.add(ItemManagerAddItem(taskToSave));
      } else {
        dataBloc.add(ItemManagerEditItem(taskToSave));
      }
    }

    return Scaffold(
      body: Column(
        children: [
          const AddAndEditItemAppBar(),
          TitleInputField(titleController, saveTask),
          DatePicker(taskToSave.dueDate, saveTask),
          ContentInputField(contentController, saveTask)
        ],
      ),
    );
  }
}
