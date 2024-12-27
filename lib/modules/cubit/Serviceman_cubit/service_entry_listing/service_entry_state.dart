import 'package:equatable/equatable.dart';
import 'package:savitri_automobiles_admin/modules/model/getserviceentrymodel.dart';

abstract class ServiceEntryState extends Equatable {
  const ServiceEntryState();

  @override
  List<Object?> get props => [];
}

class ServiceEntryInitial extends ServiceEntryState {
  const ServiceEntryInitial();
}

class ServiceEntryLoaded extends ServiceEntryState {
  final GetServiceEntryModel getServiceEntries;
  const ServiceEntryLoaded({required this.getServiceEntries});
}

class ServiceEntryLoading extends ServiceEntryState {
  const ServiceEntryLoading();
}

class ServiceEntrySuccess extends ServiceEntryState {
  final String message;

  const ServiceEntrySuccess({
    required this.message,
  });
}

class ServiceEntryError extends ServiceEntryState {
  final String message;

  const ServiceEntryError({
    required this.message,
  });
}
