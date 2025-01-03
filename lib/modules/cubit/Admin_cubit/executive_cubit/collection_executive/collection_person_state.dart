import 'package:equatable/equatable.dart';
import 'package:savitri_automobiles_admin/modules/model/getusersmodel.dart';

abstract class CollectionPersonState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CollectionPersonInitial extends CollectionPersonState {}

class CollectionPersonLoading extends CollectionPersonState {}

class CollectionPersonSuccess extends CollectionPersonState {
  final String message;

  CollectionPersonSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class CollectionPersonLoaded extends CollectionPersonState {
  final GetUsersModel? getusers;
  final String? message;
  CollectionPersonLoaded({this.getusers, this.message});

  @override
  List<Object?> get props => [getusers];
}

class CollectionPersonError extends CollectionPersonState {
  final String message;

  CollectionPersonError({required this.message});

  @override
  List<Object?> get props => [message];
}
