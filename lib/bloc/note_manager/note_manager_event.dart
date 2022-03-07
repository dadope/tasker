part of 'note_manager_bloc.dart';

abstract class NoteManagerEvent extends Equatable {
  const NoteManagerEvent();

  @override
  List<Object> get props => [];
}

class NoteManagerLoad extends NoteManagerEvent {}

class NoteManagerAddNote extends NoteManagerEvent {
  final Note noteToAdd;

  const NoteManagerAddNote(this.noteToAdd);

  @override
  List<Note> get props => [noteToAdd];
}

class NoteManagerEditNote extends NoteManagerEvent {
  final int indexToEdit;
  final Note noteToEdit;

  const NoteManagerEditNote(this.indexToEdit, this.noteToEdit);

  @override
  List<Object> get props => [indexToEdit, noteToEdit];
}

class NoteManagerRemoveNote extends NoteManagerEvent {
  final int indexToRemove;

  const NoteManagerRemoveNote(this.indexToRemove);

  @override
  List<int> get props => [indexToRemove];
}

class NoteManagerSearchNote extends NoteManagerEvent{
  final String query;

  const NoteManagerSearchNote(this.query);

  @override
  List<String> get props => [query];
}