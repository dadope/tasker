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
      leading: IconButton(
        icon: const Icon(Icons.cancel),
        onPressed: cancelDeletion,
      ),
      title: const DefaultSearchBar(),
      actions: [
        IconButton(
          icon: const Icon(Icons.delete_forever),
          onPressed: deleteItem,
        )
      ],
    );
  }
}
