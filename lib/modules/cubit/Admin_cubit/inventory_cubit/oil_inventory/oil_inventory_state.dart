import 'package:savitri_automobiles_admin/modules/model/getoilmodel.dart';

class OilInventoryState {
  final GetOilModel? getOilmodel;
  final bool? isLoading;
  final bool? isSuccess;
  final String? message;
  OilInventoryState({
    this.getOilmodel,
    this.isLoading = false,
    this.isSuccess = false,
    this.message = "",
  });
  OilInventoryState copyWith({
    GetOilModel? getOilmodel,
    bool? isLoading,
    bool? isSuccess,
    String? message,
  }) {
    return OilInventoryState(
      getOilmodel: getOilmodel ?? this.getOilmodel,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OilInventoryState &&
        other.getOilmodel == getOilmodel &&
        other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        other.message == message;
  }

  @override
  int get hashCode {
    return getOilmodel.hashCode ^
        isLoading.hashCode ^
        isSuccess.hashCode ^
        message.hashCode;
  }
}

class OilInventorySuccess extends OilInventoryState {
  OilInventorySuccess(String message)
      : super(
          message: message,
        );
}

class OilInventoryloaded extends OilInventoryState {
  @override
  final GetOilModel? getOilmodel;
  @override
  final String? message;
  OilInventoryloaded({this.getOilmodel, this.message});
}

class OilInventoryError extends OilInventoryState {
  OilInventoryError(String message)
      : super(
          isLoading: false,
          message: message,
        );
}

class OilInventoryLoading extends OilInventoryState {
  OilInventoryLoading()
      : super(
          isLoading: true,
          message: 'Loading...',
        );
}
