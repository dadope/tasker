import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasker/models/item.dart';
import 'package:tasker/views/create_item_view.dart';

class EditItemView extends CreateItemView {
  static const String routeName = "/editItemView";

  const EditItemView(Item itemToSave, {Key? key}) :
        super(itemToSave, alreadySaved: true, key: key);
}