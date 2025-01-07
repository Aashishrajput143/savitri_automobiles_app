import 'package:savitri_automobiles_admin/modules/model/getserviceentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/servicecountmodel.dart';

class ServiceExecutiveDetailsState {
  final ServiceCountModel? getServicecount;
  final GetServiceEntryModel? getServiceentries;
  final String? message;
  ServiceExecutiveDetailsState({
    this.getServicecount,
    this.getServiceentries,
    this.message = "",
  });
  ServiceExecutiveDetailsState copyWith({
    ServiceCountModel? getServicecount,
    GetServiceEntryModel? getServiceentries,
    String? message,
  }) {
    return ServiceExecutiveDetailsState(
      getServicecount: getServicecount ?? this.getServicecount,
      getServiceentries: getServiceentries ?? this.getServiceentries,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ServiceExecutiveDetailsState &&
        other.getServicecount == getServicecount &&
        other.getServiceentries == getServiceentries &&
        other.message == message;
  }

  @override
  int get hashCode {
    return getServicecount.hashCode ^
        getServiceentries.hashCode ^
        message.hashCode;
  }
}

class ServiceExecutiveDetailsSuccess extends ServiceExecutiveDetailsState {
  ServiceExecutiveDetailsSuccess(String message)
      : super(
          getServicecount: null,
          getServiceentries: null,
          message: message,
        );
}

class ServiceExecutiveDetailsError extends ServiceExecutiveDetailsState {
  ServiceExecutiveDetailsError(String message)
      : super(
          getServicecount: null,
          getServiceentries: null,
          message: message,
        );
}

class ServiceExecutiveDetailsLoading extends ServiceExecutiveDetailsState {
  ServiceExecutiveDetailsLoading()
      : super(
          getServicecount: null,
          getServiceentries: null,
          message: 'Loading...',
        );
}
