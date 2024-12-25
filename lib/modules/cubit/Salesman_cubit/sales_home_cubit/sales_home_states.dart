import 'package:equatable/equatable.dart';
import 'package:savitri_automobiles_admin/modules/model/getsalesentrymodel.dart';

abstract class SalesHomeStates extends Equatable {
  const SalesHomeStates();

  @override
  List<Object?> get props => [];
}

class SalesHomeLoading extends SalesHomeStates {
  const SalesHomeLoading();
}

class SalesHomeLogout extends SalesHomeStates {
  final String message;

  const SalesHomeLogout({required this.message});

  @override
  List<Object?> get props => [];
}

class SalesHomeLoaded extends SalesHomeStates {
  final GetSalesEntryModel getSalesEntries;
  const SalesHomeLoaded({required this.getSalesEntries});

  @override
  List<Object?> get props => [getSalesEntries];
}

class SalesHomeSuccess extends SalesHomeStates {
  final String message;

  const SalesHomeSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class SalesHomeError extends SalesHomeStates {
  final String message;

  const SalesHomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
