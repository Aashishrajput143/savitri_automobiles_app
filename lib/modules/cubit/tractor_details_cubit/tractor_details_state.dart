import 'package:equatable/equatable.dart';

abstract class TractorDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TractorDetailsInitial extends TractorDetailsState {}

class TractorDetailsLoading extends TractorDetailsState {}

class TractorDetailsSuccess extends TractorDetailsState {
  final String message;

  TractorDetailsSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class TractorDetailsError extends TractorDetailsState {
  final String message;

  TractorDetailsError({required this.message});

  @override
  List<Object?> get props => [message];
}
