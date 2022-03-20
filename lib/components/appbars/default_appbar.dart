import 'package:flutter/material.dart';
import 'package:tasker/components/textfield/default_search_bar.dart';
import 'package:tasker/models/tag.dart';

class DefaultAppBar extends StatelessWidget with PreferredSizeWidget{
  const DefaultAppBar(this.searchController, {Key? key, required this.searchedTags, required this.cancelSearch}) : super(key: key);

  final Function() cancelSearch;
  final List<Tag> searchedTags;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: DefaultSearchBar(
        searchController,
        searchedTags: searchedTags,
        cancelSearch: cancelSearch
      )
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
