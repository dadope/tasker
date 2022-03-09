import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:tasker/views/home_view.dart';
import 'package:tasker/views/edit_note_view.dart';
import 'package:tasker/views/edit_task_view.dart';
import 'package:tasker/views/create_note_view.dart';
import 'package:tasker/views/create_task_view.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case HomeView.routeName: // => "/"
        return MaterialPageRoute(
            builder: (_) => const HomeView()
        );

      case EditNoteView.routeName: // => "/editNoteView"
        final args = settings.arguments as List;
        return MaterialPageRoute(
            builder: (_) => EditNoteView(args.elementAt(0))
        );

      case CreateNoteView.routeName: // => "/createNoteView"
        return MaterialPageRoute(
            builder: (_) => const CreateNoteView()
        );

      case EditTaskView.routeName: // => "/editTaskView"
        final args = settings.arguments as List;
        return MaterialPageRoute(
            builder: (_) => EditTaskView(args.elementAt(0))
        );

      case CreateTaskView.routeName: // => "/createTaskView"
        return MaterialPageRoute(
            builder: (_) => const CreateTaskView()
        );

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            )
        );
    }
  }
}