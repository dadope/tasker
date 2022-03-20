import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tasker/bloc/item_manager/item_manager_bloc.dart';
import 'package:tasker/components/list_views/tag_list_view.dart';
import 'package:tasker/models/tag.dart';

class DefaultSearchBar extends StatelessWidget {
  const DefaultSearchBar(this.searchController, {required this.searchedTags, Key? key, required this.cancelSearch}) : super(key: key);

  final Function() cancelSearch;
  final List<Tag> searchedTags;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    final ItemManagerBloc dataBloc = BlocProvider.of<ItemManagerBloc>(context);
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: Colors.grey
          ),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
            onPressed: (){},
          ),
          Expanded(
            child: TextField(
              onChanged: (String s) => dataBloc.add(ItemManagerSearchItem(searchController.text)),
              controller: searchController,
              decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none
              ),
            ),
          ),
          if (searchedTags.isNotEmpty) SizedBox(
            height: 22,
            child: TagListView(searchedTags)
          ),
          IconButton(
            icon: const Icon(
              Icons.clear,
              color: Colors.grey,
            ),
            onPressed: cancelSearch
          ),
        ],
      ),
    );
  }
}
