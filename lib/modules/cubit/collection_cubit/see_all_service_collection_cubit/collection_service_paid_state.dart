import 'package:equatable/equatable.dart';
import 'package:savitri_automobiles_admin/modules/model/getserviceentrymodel.dart';

abstract class CollectionServicePaidStates extends Equatable {
  const CollectionServicePaidStates(); // Immutable abstract state

  @override
  List<Object?> get props => [];
}

class CollectionServicePaidInitial extends CollectionServicePaidStates {
  const CollectionServicePaidInitial();
}

class CollectionServicePaidLoading extends CollectionServicePaidStates {
  const CollectionServicePaidLoading();
}

class CollectionServicePaidSuccess extends CollectionServicePaidStates {
  final String message;

  const CollectionServicePaidSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class CollectionServicePaidLoaded extends CollectionServicePaidStates {
  final GetServiceEntryModel getServiceEntries;
  const CollectionServicePaidLoaded({required this.getServiceEntries});

  @override
  List<Object?> get props => [getServiceEntries];
}

class CollectionServicePaidError extends CollectionServicePaidStates {
  final String message;

  const CollectionServicePaidError({required this.message});

  @override
  List<Object?> get props => [message];
}
