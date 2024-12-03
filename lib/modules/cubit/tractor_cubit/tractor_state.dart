import 'package:equatable/equatable.dart';

abstract class TractorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TractorInitial extends TractorState {}

class TractorLoading extends TractorState {}

class TractorSuccess extends TractorState {
  final String message;

  TractorSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class TractorError extends TractorState {
  final String message;

  TractorError({required this.message});

  @override
  List<Object?> get props => [message];
}
