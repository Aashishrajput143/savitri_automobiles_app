import 'package:savitri_automobiles_admin/modules/model/getservicegraphmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/servicecountmodel.dart';

class ServiceGraphState {
  final ServiceCountModel? getservicecount;
  final GetServiceGraphModel? getServiceGraph;
  final List<Map<String, dynamic>>? sparePartData;
  final List<Map<String, dynamic>>? oilData;
  final String? message;
  ServiceGraphState({
    this.getservicecount,
    this.getServiceGraph,
    this.sparePartData,
    this.oilData,
    this.message = "",
  });
  ServiceGraphState copyWith({
    ServiceCountModel? getservicecount,
    GetServiceGraphModel? getServiceGraph,
    List<Map<String, dynamic>>? sparePartData,
    List<Map<String, dynamic>>? oilData,
    String? message,
  }) {
    return ServiceGraphState(
      getservicecount: getservicecount ?? this.getservicecount,
      getServiceGraph: getServiceGraph ?? this.getServiceGraph,
      sparePartData: sparePartData ?? this.sparePartData,
      oilData: oilData ?? this.oilData,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ServiceGraphState &&
        other.getservicecount == getservicecount &&
        other.getServiceGraph == getServiceGraph &&
        other.sparePartData == sparePartData &&
        other.oilData == oilData &&
        other.message == message;
  }

  @override
  int get hashCode {
    return getservicecount.hashCode ^
        getServiceGraph.hashCode ^
        sparePartData.hashCode ^
        oilData.hashCode ^
        message.hashCode;
  }
}

class ServiceGraphSuccess extends ServiceGraphState {
  ServiceGraphSuccess(String message)
      : super(
          getservicecount: null,
          getServiceGraph: null,
          sparePartData: [],
          oilData: [],
          message: message,
        );
}

class ServiceGraphError extends ServiceGraphState {
  ServiceGraphError(String message)
      : super(
          getservicecount: null,
          getServiceGraph: null,
          sparePartData: [],
          oilData: [],
          message: message,
        );
}

class ServiceGraphLoading extends ServiceGraphState {
  ServiceGraphLoading()
      : super(
          getservicecount: null,
          getServiceGraph: null,
          sparePartData: [],
          oilData: [],
          message: 'Loading...',
        );
}
