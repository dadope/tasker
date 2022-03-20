part of 'item_manager_bloc.dart';

abstract class ItemManagerState extends Equatable {
  const ItemManagerState();

  @override
  List get props => [];
}

class ItemManagerInitial extends ItemManagerState {}

class ItemManagerLoading extends ItemManagerState {}

class ItemManagerErrorState extends ItemManagerState {
  final String errorMessage;

  const ItemManagerErrorState(this.errorMessage);

  @override
  List<String> get props => [errorMessage];
}

class ItemManagerLoaded extends ItemManagerState {
  final List<Item> items;
  final List<Tag> tags;

  const ItemManagerLoaded(this.items, this.tags);

  @override
  List<Item> get props => items;
}

class ItemManagerSearched extends ItemManagerLoaded{
  const ItemManagerSearched(List<Item> items, List<Tag> tags) : super(items, tags);
}

class ItemManagerReloaded extends ItemManagerLoaded {
  const ItemManagerReloaded(List<Item> items, List<Tag> tags)
      : super(items, tags);
}