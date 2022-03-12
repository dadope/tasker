import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:tasker/views/home_view.dart';
import 'package:tasker/views/edit_item_view.dart';
import 'package:tasker/views/create_item_view.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case HomeView.routeName: // => "/"
        return MaterialPageRoute(
            builder: (_) => const HomeView()
        );


      case EditItemView.routeName: // => "/editTaskView"
        final args = settings.arguments as List;
        return MaterialPageRoute(
            builder: (_) => EditItemView(args.elementAt(0))
        );

      case CreateItemView.routeName: // => "/createItemView"
        final args = settings.arguments as List;
        return MaterialPageRoute(
            builder: (_) => CreateItemView(args.elementAt(0))
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