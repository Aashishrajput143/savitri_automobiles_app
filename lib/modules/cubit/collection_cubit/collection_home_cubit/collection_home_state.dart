import 'package:equatable/equatable.dart';
import 'package:savitri_automobiles_admin/modules/model/getsalesentrymodel.dart';

abstract class CollectionHomeStates extends Equatable {
  const CollectionHomeStates(); // Immutable abstract state

  @override
  List<Object?> get props => [];
}

class CollectionHomeInitial extends CollectionHomeStates {
  const CollectionHomeInitial();
}

class CollectionHomeLoading extends CollectionHomeStates {
  const CollectionHomeLoading();
}

class CollectionHomeSuccess extends CollectionHomeStates {
  final String message;

  const CollectionHomeSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class CollectionHomeLoaded extends CollectionHomeStates {
  final GetSalesEntryModel getSalesEntries;
  const CollectionHomeLoaded({required this.getSalesEntries});

  @override
  List<Object?> get props => [getSalesEntries];
}

class CollectionHomeLogout extends CollectionHomeStates {
  final String message;

  const CollectionHomeLogout({required this.message});

  @override
  List<Object?> get props => [];
}

class CollectionHomeError extends CollectionHomeStates {
  final String message;

  const CollectionHomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
