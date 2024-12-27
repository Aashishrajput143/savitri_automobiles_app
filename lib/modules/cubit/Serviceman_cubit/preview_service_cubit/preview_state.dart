import 'package:equatable/equatable.dart';
import 'package:savitri_automobiles_admin/modules/model/getserviceentrydetailmodel.dart';

abstract class PreviewServiceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PreviewServiceInitial extends PreviewServiceState {}

class PreviewServiceLoading extends PreviewServiceState {}

class PreviewServiceSuccess extends PreviewServiceState {
  final GetServiceEntryDetailModel getServiceDetailsByIDModel;

  PreviewServiceSuccess({required this.getServiceDetailsByIDModel});
}

class PreviewServiceError extends PreviewServiceState {
  final String message;

  PreviewServiceError({required this.message});

  @override
  List<Object?> get props => [message];
}
