import 'package:equatable/equatable.dart';
import 'package:savitri_automobiles_admin/modules/model/servicecountmodel.dart';

abstract class ServiceDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServiceDetailsInitial extends ServiceDetailsState {}

class ServiceDetailsLoading extends ServiceDetailsState {}

class ServiceDetailsSuccess extends ServiceDetailsState {
  final String message;

  ServiceDetailsSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class ServiceDetailsLoaded extends ServiceDetailsState {
  final ServiceCountModel? servicecount;
  final String? message;
  ServiceDetailsLoaded({this.servicecount, this.message});

  @override
  List<Object?> get props => [servicecount];
}

class ServiceDetailsError extends ServiceDetailsState {
  final String message;

  ServiceDetailsError({required this.message});

  @override
  List<Object?> get props => [message];
}
