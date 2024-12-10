part of 'sales_entry_cubit.dart';

@immutable
abstract class SalesEntryState {
  final List<Map<String, dynamic>> salesEntryListing;

  const SalesEntryState({this.salesEntryListing = const []});
}

class SalesEntryInitial extends SalesEntryState {
  const SalesEntryInitial();
}

class SalesEntryLoading extends SalesEntryState {
  const SalesEntryLoading();
}

class SalesEntrySuccess extends SalesEntryState {
  final String message;

  const SalesEntrySuccess({
    required this.message,
    super.salesEntryListing,
  });
}

class SalesEntryFailure extends SalesEntryState {
  final String errorMessage;

  const SalesEntryFailure({
    required this.errorMessage,
    List<Map<String, dynamic>> salesEntryListing = const [],
  }) : super(salesEntryListing: salesEntryListing);
}
