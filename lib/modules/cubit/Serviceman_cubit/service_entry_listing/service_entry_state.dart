part of 'service_entry_cubit.dart';

@immutable
abstract class ServiceEntryState {
  final List<Map<String, dynamic>> serviceEntryListing;

  const ServiceEntryState({this.serviceEntryListing = const []});
}

class ServiceEntryInitial extends ServiceEntryState {
  const ServiceEntryInitial();
}

class ServiceEntryLoading extends ServiceEntryState {
  const ServiceEntryLoading();
}

class ServiceEntrySuccess extends ServiceEntryState {
  final String message;

  const ServiceEntrySuccess({
    required this.message,
    super.serviceEntryListing,
  });
}

class ServiceEntryFailure extends ServiceEntryState {
  final String errorMessage;

  const ServiceEntryFailure({
    required this.errorMessage,
    super.serviceEntryListing,
  });
}
