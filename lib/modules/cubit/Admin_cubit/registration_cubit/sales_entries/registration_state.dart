import 'package:equatable/equatable.dart';
import 'package:savitri_automobiles_admin/modules/model/getsalesentrymodel.dart';

abstract class RegistrationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {
  final String message;

  RegistrationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class RegistrationLoaded extends RegistrationState {
  final GetSalesEntryModel? getSalesEntries;
  final String? message;
  RegistrationLoaded({this.getSalesEntries, this.message});

  @override
  List<Object?> get props => [getSalesEntries];
}

class RegistrationError extends RegistrationState {
  final String message;

  RegistrationError({required this.message});

  @override
  List<Object?> get props => [message];
}
