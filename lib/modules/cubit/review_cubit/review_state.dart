import 'package:equatable/equatable.dart';

abstract class ReviewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewSuccess extends ReviewState {
  final String message;

  ReviewSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class ReviewError extends ReviewState {
  final String message;

  ReviewError({required this.message});

  @override
  List<Object?> get props => [message];
}
