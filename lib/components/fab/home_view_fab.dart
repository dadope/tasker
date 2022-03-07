import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasker/views/create_note_view.dart';

import 'expandable_fab.dart';

class HomeViewFab extends StatelessWidget {
  final int listLen;

  const HomeViewFab(this.listLen, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      children: [
        ActionButton(
          onPressed: () {
            // TODO add events
          },
          icon: const Icon(Icons.calendar_today),
        ),
        ActionButton(
          onPressed: () {
            Navigator.pushNamed(context, CreateNoteView.routeName, arguments: [listLen]);
          },
          icon: const Icon(Icons.note_add),
        ),
        ActionButton(
          onPressed: () {
            // TODO add tags
          },
          icon: const Icon(Icons.tag),
        ),
      ],
    );
  }
}
