import 'package:hive/hive.dart';
import 'package:tasker/models/item.dart';

import 'package:tasker/models/note.dart';
import 'package:tasker/models/tag.dart';
import 'package:tasker/models/task.dart';

// TODO enable sorting my creation date
class DatabaseManager {
  static const String boxName = "itemsDb";

  Box hiveBox = Hive.box(boxName);

  List<Item> getAllItems() {
    List<Task> tasks = getAllTasks();
    List<Note> notes = getAllNotes();

    tasks.sort((a,b)=> a.creationDate.compareTo(b.dueDate));
    notes.sort((a,b)=> b.creationDate.compareTo(a.creationDate));

    return [...tasks, ...notes];
  }

  List<Task> getAllTasks() => hiveBox.values.whereType<Task>().toList();
  List<Note> getAllNotes() => hiveBox.values.whereType<Note>().toList();
  List<Tag> getAllTags() => getAllItems().expand((element) => element.tags).toSet().toList();

  //List<Note> searchForNote(String query, {bool matchCase = false}) =>
  //    getAllNotes().where(
  //            (element) => matchCase?
  //        element.title.contains(query) || element.content.contains(query):
  //        element.title.toLowerCase().contains(query.toLowerCase()) ||
  //            element.content.toLowerCase().contains(query.toLowerCase())
  //    ).toList();
//
  //List<Task> searchForTask(String query, {bool matchCase = false}) =>
  //    getAllTasks().where(
  //            (element) => matchCase?
  //        element.title.contains(query) || element.content.contains(query):
  //        element.title.toLowerCase().contains(query.toLowerCase()) ||
  //            element.content.toLowerCase().contains(query.toLowerCase())
  //    ).toList();
//
  //List<Item> searchAllItems(String query, {bool matchCase = false}) =>
  //    [
  //      ...searchForTask(query, matchCase: matchCase),
  //      ...searchForNote(query, matchCase: matchCase)
  //    ];
//
  //List<Item> searchByTags(List<Tag> tagsToFind) =>
  //    getAllItems().where(
  //            (element) => element.tags.toSet().containsAll(tagsToFind)
  //    ).toList();

  List<Item> searchItem({String? query, List<Tag>? tagsToFind, bool matchCase = false}){
    String _query = query??"";
    List<Tag> _tags = tagsToFind?? List.empty();

    return [
      ...getAllNotes().where(
        (element) => matchCase?
          element.title.contains(_query) || element.content.contains(_query):
          element.title.toLowerCase().contains(_query.toLowerCase()) ||
            element.content.toLowerCase().contains(_query.toLowerCase())
      ),
      ...getAllTasks().where(
        (element) => matchCase?
          element.title.contains(_query) || element.content.contains(_query):
          element.title.toLowerCase().contains(_query.toLowerCase()) ||
              element.content.toLowerCase().contains(_query.toLowerCase())
      )
    ].where(
            (element) => element.tags.toSet().containsAll(_tags)
    ).toList();
  }


  Future<void> editItem(Item item) async => await item.save();

  Future<void> removeItem(Item item) async => await item.delete();

  Future<int> addItem(Item item) async => await hiveBox.add(item);
}