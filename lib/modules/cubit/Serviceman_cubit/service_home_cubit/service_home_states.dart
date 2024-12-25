import 'package:equatable/equatable.dart';

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
