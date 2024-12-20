part of 'sales_entry_cubit.dart';

abstract class SalesEntryState extends Equatable {
  const SalesEntryState();

  @override
  List<Object?> get props => [];
}

class SalesEntryLoading extends SalesEntryState {
  const SalesEntryLoading();
}

class SalesEntryLoaded extends SalesEntryState {
  final GetSalesEntryModel? getSalesEntries;
  final String? message;
  const SalesEntryLoaded({this.getSalesEntries, this.message});

  @override
  List<Object?> get props => [getSalesEntries];
}

class SalesEntryError extends SalesEntryState {
  final String message;

  const SalesEntryError({required this.message});

  @override
  List<Object?> get props => [message];
}
