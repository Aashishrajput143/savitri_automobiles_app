import 'package:equatable/equatable.dart';
import 'package:savitri_automobiles_admin/modules/model/getserviceentrymodel.dart';

abstract class ServiceHomeStates extends Equatable {
  const ServiceHomeStates();

  @override
  List<Object?> get props => [];
}

class ServiceHomeLoading extends ServiceHomeStates {
  const ServiceHomeLoading();
}

class ServiceHomeLogout extends ServiceHomeStates {
  final String message;

  const ServiceHomeLogout({required this.message});

  @override
  List<Object?> get props => [];
}

class ServiceHomeLoaded extends ServiceHomeStates {
  final GetServiceEntryModel getServiceEntries;
  const ServiceHomeLoaded({required this.getServiceEntries});

  @override
  List<Object?> get props => [getServiceEntries];
}

class ServiceHomeSuccess extends ServiceHomeStates {
  final String message;

  const ServiceHomeSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class ServiceHomeError extends ServiceHomeStates {
  final String message;

  const ServiceHomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
