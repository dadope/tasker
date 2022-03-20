part of 'item_manager_bloc.dart';

abstract class ItemManagerEvent extends Equatable {
  const ItemManagerEvent();

  @override
  List get props => [];
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

class ItemManagerSearch extends ItemManagerEvent{
  final String? query;
  final List<Tag>? queryTags;

  const ItemManagerSearch({this.query, this.queryTags});

  @override
  List<Object?> get props => [query, queryTags];
}