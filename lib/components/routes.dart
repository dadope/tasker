import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasker/views/create_note_view.dart';
import 'package:tasker/views/edit_note_view.dart';
import 'package:tasker/views/home_view.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeView.routeName: // => "/"
        return MaterialPageRoute(builder: (_) => HomeView());

      case EditNoteView.routeName: // => "/editNoteView"
        final args = settings.arguments as List;

        return MaterialPageRoute(
            builder: (_) => EditNoteView(args.elementAt(0), args.elementAt(1))
        );

      case CreateNoteView.routeName: // => "/createNoteView"
        final args = settings.arguments as List;
        return MaterialPageRoute(
            builder: (_) => CreateNoteView(args.elementAt(0))
        );
//
     //ase CreateNoteView.route: // => "/createNoteView"
      //  return MaterialPageRoute(
      //      builder: (_) => CreateNoteView()
      //  );
//
      //case EditEventView.route: // => "/editEventView"
      //  final args = settings.arguments as Event;
//
      //  return MaterialPageRoute(
      //      builder: (_) => EditEventView(
      //        args
      //      )
      //  );
//
      //case CreateEventView.route: // => "/createEventView"
      //  return MaterialPageRoute(
      //      builder: (_) => CreateEventView()
      //  );

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