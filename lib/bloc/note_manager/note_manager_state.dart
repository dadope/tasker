part of 'note_manager_bloc.dart';

abstract class NoteManagerState extends Equatable {
  const NoteManagerState();

  @override
  List get props => [];
}

class NoteManagerInitial extends NoteManagerState {}

class NoteManagerLoading extends NoteManagerState {}

class NoteManagerErrorState extends NoteManagerState {
  final String errorMessage;

  const NoteManagerErrorState(this.errorMessage);

  @override
  List<String> get props => [errorMessage];
}

class NoteManagerLoaded extends NoteManagerState {
  final List<Note> notes;

  const NoteManagerLoaded(this.notes);

  @override
  List<Note> get props => notes;
}

class NoteManagerSearched extends NoteManagerLoaded{
  const NoteManagerSearched(List<Note> notes) : super(notes);
}

class NoteManagerReloaded extends NoteManagerLoaded {
  final bool taskSuccessful;

  const NoteManagerReloaded(List<Note> notes, [this.taskSuccessful = true])
      : super(notes);
}
