import 'package:equatable/equatable.dart';
import 'package:savitri_automobiles_admin/modules/model/getusersmodel.dart';

abstract class ServicePersonState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServicePersonInitial extends ServicePersonState {}

class ServicePersonLoading extends ServicePersonState {}

class ServicePersonSuccess extends ServicePersonState {
  final String message;

  ServicePersonSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class ServicePersonLoaded extends ServicePersonState {
  final GetUsersModel? getusers;
  final String? message;
  ServicePersonLoaded({this.getusers, this.message});

  @override
  List<Object?> get props => [getusers];
}

class ServicePersonError extends ServicePersonState {
  final String message;

  ServicePersonError({required this.message});

  @override
  List<Object?> get props => [message];
}
