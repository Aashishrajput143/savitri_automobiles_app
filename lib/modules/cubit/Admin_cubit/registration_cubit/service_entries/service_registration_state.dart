import 'package:equatable/equatable.dart';
import 'package:savitri_automobiles_admin/modules/model/getserviceentrymodel.dart';

abstract class ServiceRegistrationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServiceRegistrationInitial extends ServiceRegistrationState {}

class ServiceRegistrationLoading extends ServiceRegistrationState {}

class ServiceRegistrationSuccess extends ServiceRegistrationState {
  final String message;

  ServiceRegistrationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class ServiceRegistrationLoaded extends ServiceRegistrationState {
  final GetServiceEntryModel? getServiceEntries;
  final String? message;
  ServiceRegistrationLoaded({this.getServiceEntries, this.message});

  @override
  List<Object?> get props => [getServiceEntries];
}

class ServiceRegistrationError extends ServiceRegistrationState {
  final String message;

  ServiceRegistrationError({required this.message});

  @override
  List<Object?> get props => [message];
}
