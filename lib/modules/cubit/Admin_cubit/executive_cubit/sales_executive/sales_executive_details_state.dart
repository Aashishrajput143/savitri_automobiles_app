import 'package:equatable/equatable.dart';
import 'package:savitri_automobiles_admin/modules/model/salescounttractorimplementmodel.dart';

abstract class SalesDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SalesDetailsInitial extends SalesDetailsState {}

class SalesDetailsLoading extends SalesDetailsState {}

class SalesDetailsSuccess extends SalesDetailsState {
  final String message;

  SalesDetailsSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class SalesDetailsLoaded extends SalesDetailsState {
  final SalesCountTractorImplementModel? countractorimplement;
  final String? message;
  SalesDetailsLoaded({this.countractorimplement, this.message});

  @override
  List<Object?> get props => [countractorimplement];
}

class SalesDetailsError extends SalesDetailsState {
  final String message;

  SalesDetailsError({required this.message});

  @override
  List<Object?> get props => [message];
}
