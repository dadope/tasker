import 'package:flutter/material.dart';

import 'package:tasker/components/textfield/default_search_bar.dart';
import 'package:tasker/models/tag.dart';

class DeleteNoteAppBar extends StatelessWidget with PreferredSizeWidget{
  final List<Tag> searchedTags;
  final Function() deleteItem;
  final Function() cancelSearch;
  final Function() cancelDeletion;
  final TextEditingController searchController;

  const DeleteNoteAppBar(this.searchController, this.searchedTags,
      {required this.deleteItem, required this.cancelDeletion, required this.cancelSearch, Key? key}) : super(key: key);

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
      title: DefaultSearchBar(
        searchController,
        searchedTags: searchedTags,
        cancelSearch: cancelSearch,
      ),
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
