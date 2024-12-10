import 'package:equatable/equatable.dart';

abstract class SalesHomeStates extends Equatable {
  const SalesHomeStates(); // Immutable abstract state

  @override
  List<Object?> get props => [];
}

class SalesHomeInitial extends SalesHomeStates {
  const SalesHomeInitial();
}

class SalesHomeLoading extends SalesHomeStates {
  const SalesHomeLoading();
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
