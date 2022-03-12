import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasker/models/note.dart';
import 'package:tasker/models/task.dart';
import 'package:tasker/views/create_item_view.dart';

import 'expandable_fab.dart';

class HomeViewFab extends StatelessWidget {
  const HomeViewFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      children: [
        ActionButton(
          onPressed: () {
            Navigator.pushNamed(
                context,
                CreateItemView.routeName,
                arguments: [Task()]
            );
          },
          icon: const Icon(Icons.calendar_today),
        ),
        ActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              CreateItemView.routeName,
              arguments: [Note()]
            );
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
