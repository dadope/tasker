import 'package:hive/hive.dart';
import 'package:tasker/models/item.dart';

import 'package:tasker/models/note.dart';
import 'package:tasker/models/task.dart';

// TODO enable sorting my creation date
class DatabaseManager {
  static const String boxName = "itemsDb";

  Box hiveBox = Hive.box(boxName);

  List<Item> getAllItems() => hiveBox.values.whereType<Item>().toList();
  List<Task> getAllTasks() => hiveBox.values.whereType<Task>().toList();
  List<Note> getAllNotes() => hiveBox.values.whereType<Note>().toList();

  List<Note> searchForNote(String query, {bool matchCase = false}) =>
      getAllNotes().where(
              (element) => matchCase?
          element.title.contains(query) || element.content.contains(query):
          element.title.toLowerCase().contains(query.toLowerCase()) ||
              element.content.toLowerCase().contains(query.toLowerCase())
      ).toList();

  List<Task> searchForTask(String query, {bool matchCase = false}) =>
      getAllTasks().where(
              (element) => matchCase?
          element.title.contains(query) || element.content.contains(query):
          element.title.toLowerCase().contains(query.toLowerCase()) ||
              element.content.toLowerCase().contains(query.toLowerCase())
      ).toList();

  List<Item> searchAllItems(String query, {bool matchCase = false}) =>
      [
        ...searchForTask(query, matchCase: matchCase),
        ...searchForNote(query, matchCase: matchCase)
      ];

  Future<void> editItem(Item item) async => await item.save();

  Future<void> removeItem(Item item) async => await item.delete();

  Future<int> addItem(Item item) async => await hiveBox.add(item);
}