import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tasker/bloc/item_manager/item_manager_bloc.dart';

class DefaultSearchBar extends StatelessWidget {
  const DefaultSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    final ItemManagerBloc dataBloc = BlocProvider.of<ItemManagerBloc>(context);

    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: TextField(
          onChanged: (String s) => dataBloc.add(ItemManagerSearchItem(searchController.text)),
          controller: searchController,
          decoration: InputDecoration(
              prefixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: (){},
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  searchController.text = "";
                  dataBloc.add(ItemManagerLoad());
                },
              ),
              hintText: 'Search...',
              border: InputBorder.none),
        ),
      ),
    );
  }
}
