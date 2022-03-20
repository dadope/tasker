import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:tasker/components/database_manager.dart';
import 'package:tasker/models/item.dart';
import 'package:tasker/models/tag.dart';

part 'item_manager_event.dart';
part 'item_manager_state.dart';

class ItemManagerBloc extends Bloc<ItemManagerEvent, ItemManagerState> {
  DatabaseManager databaseManager;

  ItemManagerBloc(): databaseManager = DatabaseManager(),
        super(ItemManagerInitial()){
    on<ItemManagerLoad>((event, emit) => _onItemManagerLoad(event, emit));
    on<ItemManagerAddItem>((event, emit) => _onItemManagerAddItem(event, emit));
    on<ItemManagerEditItem>((event, emit) => _onItemManagerEditItem(event, emit));
    on<ItemManagerRemoveItem>((event, emit) => _onItemManagerRemoveItem(event, emit));
    on<ItemManagerSearchItem>((event, emit) => _onItemManagerSearchItem(event, emit));
    on<ItemManagerSearchByTag>((event, emit) => _onItemManagerSearchByTag(event, emit));
  }

  void _onItemManagerLoad(ItemManagerLoad event, Emitter<ItemManagerState> emit) {
    emit(ItemManagerLoading());
    emit(ItemManagerLoaded(databaseManager.getAllItems(), databaseManager.getAllTags()));
  }

  void _onItemManagerAddItem(ItemManagerAddItem event, Emitter<ItemManagerState> emit) async {
    emit(ItemManagerLoading());
    databaseManager.addItem(event.itemToAdd);
    emit(ItemManagerReloaded(databaseManager.getAllItems(), databaseManager.getAllTags()));
  }

  void _onItemManagerEditItem(ItemManagerEditItem event, Emitter<ItemManagerState> emit) {
    emit(ItemManagerLoading());
    databaseManager.editItem(event.itemToEdit);
    emit(ItemManagerReloaded(databaseManager.getAllItems(), databaseManager.getAllTags()));
  }

  void _onItemManagerRemoveItem(ItemManagerRemoveItem event, Emitter<ItemManagerState> emit) {
    emit(ItemManagerLoading());
    databaseManager.removeItem(event.itemToRemove);
    emit(ItemManagerReloaded(databaseManager.getAllItems(), databaseManager.getAllTags()));
  }

  void _onItemManagerSearchItem(ItemManagerSearchItem event, Emitter<ItemManagerState> emit) {
    emit(ItemManagerLoading());
    emit(ItemManagerSearched(databaseManager.searchAllItems(event.query), databaseManager.getAllTags()));
  }

  void _onItemManagerSearchByTag(ItemManagerSearchByTag event, Emitter<ItemManagerState> emit) {
    emit(ItemManagerLoading());
    emit(ItemManagerSearched(databaseManager.searchByTags(event.queryTags), databaseManager.getAllTags(), queryTags: event.queryTags));
  }
}