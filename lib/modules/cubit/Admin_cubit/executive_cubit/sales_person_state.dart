import 'package:equatable/equatable.dart';

abstract class SalesPersonState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SalesPersonInitial extends SalesPersonState {}

class SalesPersonLoading extends SalesPersonState {}

class SalesPersonSuccess extends SalesPersonState {
  final String message;

  SalesPersonSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class SalesPersonError extends SalesPersonState {
  final String message;

  SalesPersonError({required this.message});

  @override
  List<Object?> get props => [message];
}
