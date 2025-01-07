import 'package:savitri_automobiles_admin/modules/model/getsalesentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/salescounttractorimplementmodel.dart';

class SalesExecutiveDetailsState {
  final SalesCountTractorImplementModel? getSalescount;
  final GetSalesEntryModel? getSalesentries;
  final String? message;
  SalesExecutiveDetailsState({
    this.getSalescount,
    this.getSalesentries,
    this.message = "",
  });
  SalesExecutiveDetailsState copyWith({
    SalesCountTractorImplementModel? getSalescount,
    GetSalesEntryModel? getSalesentries,
    String? message,
  }) {
    return SalesExecutiveDetailsState(
      getSalescount: getSalescount ?? this.getSalescount,
      getSalesentries: getSalesentries ?? this.getSalesentries,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SalesExecutiveDetailsState &&
        other.getSalescount == getSalescount &&
        other.getSalesentries == getSalesentries &&
        other.message == message;
  }

  @override
  int get hashCode {
    return getSalescount.hashCode ^ getSalesentries.hashCode ^ message.hashCode;
  }
}

class SalesExecutiveDetailsSuccess extends SalesExecutiveDetailsState {
  SalesExecutiveDetailsSuccess(String message)
      : super(
          getSalescount: null,
          getSalesentries: null,
          message: message,
        );
}

class SalesExecutiveDetailsError extends SalesExecutiveDetailsState {
  SalesExecutiveDetailsError(String message)
      : super(
          getSalescount: null,
          getSalesentries: null,
          message: message,
        );
}

class SalesExecutiveDetailsLoading extends SalesExecutiveDetailsState {
  SalesExecutiveDetailsLoading()
      : super(
          getSalescount: null,
          getSalesentries: null,
          message: 'Loading...',
        );
}
