import 'package:equatable/equatable.dart';
import 'package:savitri_automobiles_admin/modules/model/getserviceentrymodel.dart';

abstract class CollectionServiceDueStates extends Equatable {
  const CollectionServiceDueStates(); // Immutable abstract state

  @override
  List<Object?> get props => [];
}

class CollectionServiceDueInitial extends CollectionServiceDueStates {
  const CollectionServiceDueInitial();
}

class CollectionServiceDueLoading extends CollectionServiceDueStates {
  const CollectionServiceDueLoading();
}

class CollectionServiceDueSuccess extends CollectionServiceDueStates {
  final String message;

  const CollectionServiceDueSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class CollectionServiceDueLoaded extends CollectionServiceDueStates {
  final GetServiceEntryModel getserviceEntries;
  const CollectionServiceDueLoaded({required this.getserviceEntries});

  @override
  List<Object?> get props => [getserviceEntries];
}

class CollectionServiceDueError extends CollectionServiceDueStates {
  final String message;

  const CollectionServiceDueError({required this.message});

  @override
  List<Object?> get props => [message];
}
