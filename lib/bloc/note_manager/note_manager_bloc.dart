import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:tasker/components/database_manager.dart';
import 'package:tasker/models/note.dart';

part 'note_manager_event.dart';
part 'note_manager_state.dart';

class NoteManagerBloc extends Bloc<NoteManagerEvent, NoteManagerState> {
  DatabaseManager databaseManager;

  NoteManagerBloc()
      : databaseManager = DatabaseManager(),
        super(NoteManagerInitial()){
          on<NoteManagerLoad>((event, emit) => _onNoteManagerLoad(event, emit));
          on<NoteManagerAddNote>((event, emit) => _onNoteManagerAddNote(event, emit));
          on<NoteManagerEditNote>((event, emit) => _onNoteManagerEditNote(event, emit));
          on<NoteManagerRemoveNote>((event, emit) => _onNoteManagerRemoveNote(event, emit));
          on<NoteManagerSearchNote>((event, emit) => _onNoteManagerSearchNote(event, emit));
        }

  void _onNoteManagerLoad(NoteManagerLoad event, Emitter<NoteManagerState> emit) {
    emit(NoteManagerLoading());
    emit(NoteManagerLoaded(databaseManager.getAllNotes()));
  }

  void _onNoteManagerAddNote(NoteManagerAddNote event, Emitter<NoteManagerState> emit) async {
    emit(NoteManagerLoading());
    databaseManager.addNote(event.noteToAdd);
    emit(NoteManagerReloaded(databaseManager.getAllNotes()));
  }

  void _onNoteManagerEditNote(NoteManagerEditNote event, Emitter<NoteManagerState> emit) {
    emit(NoteManagerLoading());
    databaseManager.editNote(event.indexToEdit, event.noteToEdit);
    emit(NoteManagerReloaded(databaseManager.getAllNotes()));
  }

  void _onNoteManagerRemoveNote(NoteManagerRemoveNote event, Emitter<NoteManagerState> emit) {
    emit(NoteManagerLoading());
    databaseManager.removeNote(event.indexToRemove);
    emit(NoteManagerReloaded(databaseManager.getAllNotes()));
  }

  void _onNoteManagerSearchNote(NoteManagerSearchNote event, Emitter<NoteManagerState> emit) {
    emit(NoteManagerLoading());
    emit(NoteManagerSearched(databaseManager.searchNote(event.query)));
  }

}
