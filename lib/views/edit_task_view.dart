import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tasker/components/selectors/date_picker.dart';
import 'package:tasker/bloc/item_manager/item_manager_bloc.dart';
import 'package:tasker/components/appbars/add_and_edit_item_appbar.dart';
import 'package:tasker/components/textfield/title_input_field.dart';
import 'package:tasker/components/textfield/content_input_field.dart';
import 'package:tasker/models/task.dart';

class EditTaskView extends StatelessWidget {
  static const String routeName = "/editTaskView";

  final Task taskToEdit;

  const EditTaskView(this.taskToEdit, {Key? key}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();
    final ItemManagerBloc dataBloc = BlocProvider.of<ItemManagerBloc>(context);

    void saveTask(_, {String? title, String? content, DateTime? date}){
      taskToEdit.title = titleController.text;
      taskToEdit.content = contentController.text;

      if(date != null){
        taskToEdit.dueDate = date;
      }

      dataBloc.add(ItemManagerEditItem(taskToEdit));
    }

    return Scaffold(
      body: Column(
        children: [
          const AddAndEditItemAppBar(),
          TitleInputField(titleController, saveTask, title: taskToEdit.title),
          DatePicker(taskToEdit.dueDate, saveTask),
          ContentInputField(contentController, saveTask, content: taskToEdit.content)
        ],
      ),
    );
  }
}
