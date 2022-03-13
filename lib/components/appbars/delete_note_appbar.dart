import 'package:flutter/material.dart';

import 'package:tasker/components/textfield/default_search_bar.dart';

class DeleteNoteAppBar extends StatelessWidget with PreferredSizeWidget{
  final Function() deleteItem;
  final Function() cancelDeletion;

  const DeleteNoteAppBar({required this.deleteItem, required this.cancelDeletion, Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(
          Icons.cancel,
          color: Colors.grey,
        ),
        onPressed: cancelDeletion,
      ),
      title: const DefaultSearchBar(),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.delete_forever,
            color: Colors.grey,
          ),
          onPressed: deleteItem,
        )
      ],
    );
  }
}
