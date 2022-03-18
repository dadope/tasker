import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasker/components/list_views/tag_list_view.dart';
import 'package:tasker/components/selectors/color_selector.dart';
import 'package:tasker/components/selectors/date_picker.dart';

import 'package:tasker/bloc/item_manager/item_manager_bloc.dart';
import 'package:tasker/components/appbars/add_and_edit_item_appbar.dart';
import 'package:tasker/components/textfield/title_input_field.dart';
import 'package:tasker/components/textfield/content_input_field.dart';
import 'package:tasker/models/item.dart';
import 'package:tasker/models/note.dart';
import 'package:tasker/models/tag.dart';
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

    void saveItem(_){
      if (_ is DateTime && item is Task){
        setState(() {
          item.dueDate = _;
        });
      } else if(_ is Color){
        setState(() {
          item.highlightColor = _;
        });
      } else if(_ is Tag){
        setState(() {
          if(item.tags.contains(_)) {
            item.tags.remove(_);
          } else {
            item.tags.add(_);
          }
        });
      } else if (item is Task){
        item.title = titleController.text;
        item.content = contentController.text;
        if (item.title == "" && item.content == ""){
          dataBloc.add(ItemManagerRemoveItem(item));
          saved = false;
          return;
        }
      } else if (item is Note){
        item.title = titleController.text;
        item.content = contentController.text;
        if (item.title == "" && item.content == ""){
          dataBloc.add(ItemManagerRemoveItem(item));
          saved = false;
          return;
        }
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
      appBar: const AddAndEditItemAppBar(),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: TitleInputField(titleController, saveItem, title: item.title)
              ),
              ColorSelector(item.highlightColor, saveItem)
            ],
          ),
          Row(
            children: [
              item is Task?
                DatePicker(item.dueDate, item.highlightColor, saveItem):
                const SizedBox.shrink(),
              Expanded(
                child: SizedBox(
                    height: 30,
                    child: TagListView(
                      item.tags,
                      addElement: true,
                      saveItem: saveItem,
                      highlight: item.highlightColor,
                    )
                ),
              ),
            ],
          ),
          ContentInputField(contentController, saveItem, content: content)
        ],
      ),
    );
  }
}
