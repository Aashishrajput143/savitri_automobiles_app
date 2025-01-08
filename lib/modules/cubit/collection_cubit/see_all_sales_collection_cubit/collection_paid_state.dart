import 'package:equatable/equatable.dart';
import 'package:savitri_automobiles_admin/modules/model/getsalesentrymodel.dart';

abstract class CollectionPaidStates extends Equatable {
  const CollectionPaidStates(); // Immutable abstract state

  @override
  List<Object?> get props => [];
}

class CollectionPaidInitial extends CollectionPaidStates {
  const CollectionPaidInitial();
}

class CollectionPaidLoading extends CollectionPaidStates {
  const CollectionPaidLoading();
}

class CollectionPaidSuccess extends CollectionPaidStates {
  final String message;

  const CollectionPaidSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class CollectionPaidLoaded extends CollectionPaidStates {
  final GetSalesEntryModel getSalesEntries;
  const CollectionPaidLoaded({required this.getSalesEntries});

  @override
  List<Object?> get props => [getSalesEntries];
}

class CollectionPaidError extends CollectionPaidStates {
  final String message;

  const CollectionPaidError({required this.message});

  @override
  List<Object?> get props => [message];
}
