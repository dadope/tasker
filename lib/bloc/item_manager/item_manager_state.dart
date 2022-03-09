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

  const ItemManagerLoaded(this.items);

  @override
  List<Item> get props => items;
}

class ItemManagerSearched extends ItemManagerLoaded{
  const ItemManagerSearched(List<Item> items) : super(items);
}

class ItemManagerReloaded extends ItemManagerLoaded {
  final bool taskSuccessful;

  const ItemManagerReloaded(List<Item> items, [this.taskSuccessful = true])
      : super(items);
}