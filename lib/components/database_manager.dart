import 'package:hive/hive.dart';
import 'package:tasker/models/note.dart';

// TODO: only write to db on exit and handle most operations in memory
class DatabaseManager {
  static const String boxName = "notesDb";
  static const String notesArray = "notesArray";

  Box hiveBox = Hive.box(boxName);

  DatabaseManager() {
    if (!hiveBox.containsKey(notesArray)) {
      hiveBox.put(notesArray, List<Note>.empty());
    }
  }

  //TODO: save notes in an array as to not always call getAllNotes

  void removeNote(int indexToRemove) async {
    List<Note> notes = getAllNotes();
    notes.removeAt(indexToRemove);
    await hiveBox.put(notesArray, notes);
  }

  void addNote(Note note) async {
    await hiveBox.put(notesArray, [...getAllNotes(), note]);  }

  void editNote(int indexToEdit, Note noteToEdit) async {
    List<Note> notes = getAllNotes();
    notes[indexToEdit] = noteToEdit;
    await hiveBox.put(notesArray, notes);
  }

  List<Note> searchNote(String query, [bool matchCase = false]){
    List<Note> notes = hiveBox.get(notesArray).cast<Note>();
    notes = notes.where(
            (element) => matchCase?
            element.title.contains(query) || element.content.contains(query):
                element.title.toLowerCase().contains(query.toLowerCase()) ||
                element.content.toLowerCase().contains(query.toLowerCase())
    ).toList();

    // TODO enable sorting my creation date
    // sorts all notes by creationDate
    //notes.sort((a,b)=> a.creationDate.compareTo(b.creationDate));

    return notes;
  }

  List<Note> getAllNotes() {
    List<Note> notes = hiveBox.get(notesArray).cast<Note>();

    // sorts all notes by creationDate
    //notes.sort((a,b)=> a.creationDate.compareTo(b.creationDate));

    return notes;
  }
}