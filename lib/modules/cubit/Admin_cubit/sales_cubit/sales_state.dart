import 'package:equatable/equatable.dart';

abstract class SalesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SalesInitial extends SalesState {}

class SalesLoading extends SalesState {}

class SalesSuccess extends SalesState {
  final String message;

  SalesSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class SalesError extends SalesState {
  final String message;

  SalesError({required this.message});

  @override
  List<Object?> get props => [message];
}
