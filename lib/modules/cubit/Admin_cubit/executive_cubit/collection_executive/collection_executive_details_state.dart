import 'package:savitri_automobiles_admin/modules/model/getsalesentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/salescountpendingpaidmodel.dart';

class CollectionExecutiveDetailsState {
  final SalesCountPendingPaidModel? getpendingpaidcount;
  final GetSalesEntryModel? getSalesentries;
  final String? message;
  CollectionExecutiveDetailsState({
    this.getpendingpaidcount,
    this.getSalesentries,
    this.message = "",
  });
  CollectionExecutiveDetailsState copyWith({
    SalesCountPendingPaidModel? getpendingpaidcount,
    GetSalesEntryModel? getSalesentries,
    String? message,
  }) {
    return CollectionExecutiveDetailsState(
      getpendingpaidcount: getpendingpaidcount ?? this.getpendingpaidcount,
      getSalesentries: getSalesentries ?? this.getSalesentries,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CollectionExecutiveDetailsState &&
        other.getpendingpaidcount == getpendingpaidcount &&
        other.getSalesentries == getSalesentries &&
        other.message == message;
  }

  @override
  int get hashCode {
    return getpendingpaidcount.hashCode ^
        getSalesentries.hashCode ^
        message.hashCode;
  }
}

class CollectionExecutiveDetailsSuccess
    extends CollectionExecutiveDetailsState {
  CollectionExecutiveDetailsSuccess(String message)
      : super(
          getpendingpaidcount: null,
          getSalesentries: null,
          message: message,
        );
}

class CollectionExecutiveDetailsError extends CollectionExecutiveDetailsState {
  CollectionExecutiveDetailsError(String message)
      : super(
          getpendingpaidcount: null,
          getSalesentries: null,
          message: message,
        );
}

class CollectionExecutiveDetailsLoading
    extends CollectionExecutiveDetailsState {
  CollectionExecutiveDetailsLoading()
      : super(
          getpendingpaidcount: null,
          getSalesentries: null,
          message: 'Loading...',
        );
}
