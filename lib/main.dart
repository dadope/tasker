import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tasker/views/home_view.dart';
import 'package:tasker/components/routes.dart';
import 'package:tasker/bloc/note_manager/note_manager_bloc.dart';
import 'package:tasker/components/database_manager.dart';

import 'models/note.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox(DatabaseManager.boxName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteManagerBloc>(
            create: (BuildContext context) => NoteManagerBloc()
        )
      ],
      child: MaterialApp(
        title: 'Tasker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomeView.routeName,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}