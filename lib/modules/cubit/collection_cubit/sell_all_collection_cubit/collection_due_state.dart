import 'package:equatable/equatable.dart';
import 'package:savitri_automobiles_admin/modules/model/getsalesentrymodel.dart';

abstract class CollectionDueStates extends Equatable {
  const CollectionDueStates(); // Immutable abstract state

  @override
  List<Object?> get props => [];
}

class CollectionDueInitial extends CollectionDueStates {
  const CollectionDueInitial();
}

class CollectionDueLoading extends CollectionDueStates {
  const CollectionDueLoading();
}

class CollectionDueSuccess extends CollectionDueStates {
  final String message;

  const CollectionDueSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class CollectionDueLoaded extends CollectionDueStates {
  final GetSalesEntryModel getSalesEntries;
  const CollectionDueLoaded({required this.getSalesEntries});

  @override
  List<Object?> get props => [getSalesEntries];
}

class CollectionDueError extends CollectionDueStates {
  final String message;

  const CollectionDueError({required this.message});

  @override
  List<Object?> get props => [message];
}
