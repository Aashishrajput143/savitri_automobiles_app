import 'package:savitri_automobiles_admin/modules/model/getsalesgraph.dart';
import 'package:savitri_automobiles_admin/modules/model/salescounttractorimplementmodel.dart';

class SalesGraphState {
  final SalesCountTractorImplementModel? getSalescount;
  final SalesGraphModel? getSalesGraph;
  final List<Map<String, dynamic>>? tractorData;
  final List<Map<String, dynamic>>? accessoryData;
  final String? message;
  SalesGraphState({
    this.getSalescount,
    this.getSalesGraph,
    this.tractorData,
    this.accessoryData,
    this.message = "",
  });
  SalesGraphState copyWith({
    SalesCountTractorImplementModel? getSalescount,
    SalesGraphModel? getSalesGraph,
    List<Map<String, dynamic>>? tractorData,
    List<Map<String, dynamic>>? accessoryData,
    String? message,
  }) {
    return SalesGraphState(
      getSalescount: getSalescount ?? this.getSalescount,
      getSalesGraph: getSalesGraph ?? this.getSalesGraph,
      tractorData: tractorData ?? this.tractorData,
      accessoryData: accessoryData ?? this.accessoryData,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SalesGraphState &&
        other.getSalescount == getSalescount &&
        other.getSalesGraph == getSalesGraph &&
        other.tractorData == tractorData &&
        other.accessoryData == accessoryData &&
        other.message == message;
  }

  @override
  int get hashCode {
    return getSalescount.hashCode ^
        getSalesGraph.hashCode ^
        tractorData.hashCode ^
        accessoryData.hashCode ^
        message.hashCode;
  }
}

class SalesGraphSuccess extends SalesGraphState {
  SalesGraphSuccess(String message)
      : super(
          getSalescount: null,
          getSalesGraph: null,
          tractorData: [],
          accessoryData: [],
          message: message,
        );
}

class SalesGraphError extends SalesGraphState {
  SalesGraphError(String message)
      : super(
          getSalescount: null,
          getSalesGraph: null,
          tractorData: [],
          accessoryData: [],
          message: message,
        );
}

class SalesGraphLoading extends SalesGraphState {
  SalesGraphLoading()
      : super(
          getSalescount: null,
          getSalesGraph: null,
          tractorData: [],
          accessoryData: [],
          message: 'Loading...',
        );
}
