import 'package:equatable/equatable.dart';

abstract class ServiceHomeStates extends Equatable {
  const ServiceHomeStates(); // Immutable abstract state

  @override
  List<Object?> get props => [];
}

class ServiceHomeInitial extends ServiceHomeStates {
  const ServiceHomeInitial();
}

class ServiceHomeLoading extends ServiceHomeStates {
  const ServiceHomeLoading();
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
