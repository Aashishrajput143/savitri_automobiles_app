import 'package:savitri_automobiles_admin/modules/model/getsparepartsmodel.dart';

class SparepartsInventoryState {
  final GetSparePartsModel? getSparepartsmodel;
  final bool? isLoading;
  final bool? isSuccess;
  final String? message;
  SparepartsInventoryState({
    this.getSparepartsmodel,
    this.isLoading = false,
    this.isSuccess = false,
    this.message = "",
  });
  SparepartsInventoryState copyWith({
    GetSparePartsModel? getSparepartsmodel,
    bool? isLoading,
    bool? isSuccess,
    String? message,
  }) {
    return SparepartsInventoryState(
      getSparepartsmodel: getSparepartsmodel ?? this.getSparepartsmodel,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SparepartsInventoryState &&
        other.getSparepartsmodel == getSparepartsmodel &&
        other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        other.message == message;
  }

  @override
  int get hashCode {
    return getSparepartsmodel.hashCode ^
        isLoading.hashCode ^
        isSuccess.hashCode ^
        message.hashCode;
  }
}

class SparepartsInventorySuccess extends SparepartsInventoryState {
  SparepartsInventorySuccess(String message)
      : super(
          message: message,
        );
}

class SparepartsInventoryloaded extends SparepartsInventoryState {
  @override
  final GetSparePartsModel? getSparepartsmodel;
  @override
  final String? message;
  SparepartsInventoryloaded({this.getSparepartsmodel, this.message});
}

class SparepartsInventoryError extends SparepartsInventoryState {
  SparepartsInventoryError(String message)
      : super(
          isLoading: false,
          message: message,
        );
}

class SparepartsInventoryLoading extends SparepartsInventoryState {
  SparepartsInventoryLoading()
      : super(
          isLoading: true,
          message: 'Loading...',
        );
}
