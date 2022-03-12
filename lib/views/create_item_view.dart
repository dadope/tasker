import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasker/components/selectors/color_selector.dart';
import 'package:tasker/components/selectors/date_picker.dart';

import 'package:tasker/bloc/item_manager/item_manager_bloc.dart';
import 'package:tasker/components/appbars/add_and_edit_item_appbar.dart';
import 'package:tasker/components/textfield/title_input_field.dart';
import 'package:tasker/components/textfield/content_input_field.dart';
import 'package:tasker/models/item.dart';
import 'package:tasker/models/note.dart';
import 'package:tasker/models/task.dart';

class CreateItemView extends StatefulWidget {
  static const String routeName = "/createItemView";

  final Item itemToSave;
  final bool alreadySaved;

  const CreateItemView(this.itemToSave, {this.alreadySaved = false, Key? key}) :super(key: key);

  @override
  State<CreateItemView> createState() => _CreateItemViewState();
}

class _CreateItemViewState extends State<CreateItemView> {
  late bool saved;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    saved = widget.alreadySaved;
  }

  @override
  Widget build(BuildContext context) {
    Item item = widget.itemToSave;

    final ItemManagerBloc dataBloc = BlocProvider.of<ItemManagerBloc>(context);
    final String content = item is Note? item.content: item is Task? item.content: "";

    void saveTask(_){
      if (_ is DateTime && item is Task){
        setState(() {
          item.dueDate = _;
        });
      } else if(_ is Color){
        setState(() {
          item.highlightColor = _;
        });
      } else if (item is Task){
        item.title = titleController.text;
        item.content = contentController.text;
      } else if (item is Note){
        item.title = titleController.text;
        item.content = contentController.text;
      } else {
        item.title = titleController.text;
      }

      if (!saved){
        saved = true;
        dataBloc.add(ItemManagerAddItem(item));
      } else {
        dataBloc.add(ItemManagerEditItem(item));
      }
    }

    return Scaffold(
      body: Column(
        children: [
          const AddAndEditItemAppBar(),
          Row(
            children: [
              Expanded(
                  child: TitleInputField(titleController, saveTask, title: item.title)
              ),
              ColorSelector(item.highlightColor, saveTask)
            ],
          ),
          item is Task?
            DatePicker(item.dueDate, item.highlightColor, saveTask):
            const SizedBox.shrink(),
          ContentInputField(contentController, saveTask, content: content)
        ],
      ),
    );
  }
}
