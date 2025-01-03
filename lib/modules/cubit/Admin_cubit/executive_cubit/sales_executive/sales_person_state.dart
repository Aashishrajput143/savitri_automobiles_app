import 'package:equatable/equatable.dart';
import 'package:savitri_automobiles_admin/modules/model/getusersmodel.dart';

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

class SalesPersonLoaded extends SalesPersonState {
  final GetUsersModel? getusers;
  final String? message;
  SalesPersonLoaded({this.getusers, this.message});

  @override
  List<Object?> get props => [getusers];
}

class SalesPersonError extends SalesPersonState {
  final String message;

  SalesPersonError({required this.message});

  @override
  List<Object?> get props => [message];
}
