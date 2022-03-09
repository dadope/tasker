import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasker/models/item.dart';

import 'package:tasker/components/fab/home_view_fab.dart';
import 'package:tasker/components/appbars/default_appbar.dart';
import 'package:tasker/components/appbars/delete_note_appbar.dart';
import 'package:tasker/components/list_views/note_selection_list_view.dart';
import 'package:tasker/bloc/item_manager/item_manager_bloc.dart';

class HomeView extends StatefulWidget {
  static const String routeName = "/";

  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Item> selectedItems = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    final ItemManagerBloc dataBloc = BlocProvider.of<ItemManagerBloc>(context);

    // loading notes
    dataBloc.add(ItemManagerLoad());

    return BlocBuilder<ItemManagerBloc, ItemManagerState>(
      builder:(context, state) => Scaffold(
        appBar: selectedItems.isEmpty?
          const DefaultAppBar() as PreferredSizeWidget :
          DeleteNoteAppBar(
            cancelDeletion: (){
              setState(() {
                selectedItems = List.empty(growable: true);
              });
            },
            deleteItem: () {
              for (Item item in selectedItems) {
                dataBloc.add(ItemManagerRemoveItem(item));
              }
              setState(() {
                selectedItems = List.empty(growable: true);
              });
            },
          ),

        body: Builder(
          builder: (context) {
            if (state is ItemManagerLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (state is ItemManagerLoaded) {
              // no notes found or none exist
              if (state.items.isEmpty){
                return Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      state is ItemManagerSearched?
                        "No matching notes": "Could not find any saved notes",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black54
                      ),
                    ),
                  ),
                );
              }
              return NoteSelectionListView(
                  state.items,
                  selectedItems,
                  onLongPress: (Item selectedItem){
                    setState(() {
                      selectedItems.contains(selectedItem)?
                        selectedItems.remove(selectedItem):
                        selectedItems.add(selectedItem);
                    });
              });
            }
            else {
              return const Center(
                  child: CircularProgressIndicator()
              );
            }
          },
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return state is ItemManagerLoaded?
              const HomeViewFab():
              const SizedBox.shrink();
          }
        ),
      ),
    );
  }
}
