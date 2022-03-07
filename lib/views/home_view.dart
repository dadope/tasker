import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tasker/components/fab/home_view_fab.dart';
import 'package:tasker/components/appbars/default_appbar.dart';
import 'package:tasker/components/appbars/delete_note_appbar.dart';
import 'package:tasker/components/list_views/note_selection_list_view.dart';
import 'package:tasker/bloc/note_manager/note_manager_bloc.dart';

class HomeView extends StatefulWidget {
  static const String routeName = "/";

  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<int> selectedIndices = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    final NoteManagerBloc dataBloc = BlocProvider.of<NoteManagerBloc>(context);

    // loading notes
    dataBloc.add(NoteManagerLoad());

    return BlocBuilder<NoteManagerBloc, NoteManagerState>(
      builder:(context, state) => Scaffold(
        appBar: selectedIndices.isEmpty?
          const DefaultAppBar() as PreferredSizeWidget :
          DeleteNoteAppBar(
            cancelDeletion: (){
              setState(() {
                selectedIndices = List.empty(growable: true);
              });
            },
            deleteNote: () {
              // to prevent indices from shifting due to deletion of greater indices
              selectedIndices.sort((a, b) => b.compareTo(a));
              for (int elementIndex in selectedIndices) {
                dataBloc.add(NoteManagerRemoveNote(elementIndex));
              }
              setState(() {
                selectedIndices = List.empty(growable: true);
              });
            },
          ),

        body: Builder(
          builder: (context) {
            if (state is NoteManagerLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (state is NoteManagerLoaded) {
              // no notes found or none exist
              if (state.notes.isEmpty){
                return Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      state is NoteManagerSearched?
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
                  state.notes,
                  selectedIndices,
                  onLongPress: (int index){
                    setState(() {
                      selectedIndices.contains(index)?
                        selectedIndices.remove(index):
                        selectedIndices.add(index);
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
            return state is NoteManagerLoaded?
              HomeViewFab(state.notes.length):
              const SizedBox.shrink();
          }
        ),
      ),
    );
  }
}
