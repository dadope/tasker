part of 'item_manager_bloc.dart';

abstract class ItemManagerEvent extends Equatable {
  const ItemManagerEvent();

  @override
  List<Object> get props => [];
}

class ItemManagerLoad extends ItemManagerEvent {}

class ItemManagerAddItem extends ItemManagerEvent {
  final Item itemToAdd;

  const ItemManagerAddItem(this.itemToAdd);

  @override
  List<Item> get props => [itemToAdd];
}

class ItemManagerEditItem extends ItemManagerEvent {
  final Item itemToEdit;

  const ItemManagerEditItem(this.itemToEdit);

  @override
  List<Item> get props => [itemToEdit];
}

class ItemManagerRemoveItem extends ItemManagerEvent {
  final Item itemToRemove;

  const ItemManagerRemoveItem(this.itemToRemove);

  @override
  List<Item> get props => [itemToRemove];
}

class ItemManagerSearchItem extends ItemManagerEvent{
  final String query;

  const ItemManagerSearchItem(this.query);

  @override
  List<String> get props => [query];
}