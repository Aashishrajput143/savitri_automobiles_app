import 'package:equatable/equatable.dart';

abstract class ReviewServiceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReviewServiceInitial extends ReviewServiceState {}

class ReviewServiceLoading extends ReviewServiceState {}

class ReviewServiceSuccess extends ReviewServiceState {
  final String message;

  ReviewServiceSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class ReviewServiceError extends ReviewServiceState {
  final String message;

  ReviewServiceError({required this.message});

  @override
  List<Object?> get props => [message];
}
