import 'package:equatable/equatable.dart';

abstract class RegistrationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {
  final String message;

  RegistrationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class RegistrationError extends RegistrationState {
  final String message;

  RegistrationError({required this.message});

  @override
  List<Object?> get props => [message];
}
