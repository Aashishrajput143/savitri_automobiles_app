import 'package:savitri_automobiles_admin/modules/model/getsalesentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getserviceentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/salescountpendingpaidmodel.dart';

class CollectionHomeStates {
  final GetSalesEntryModel? getSalesEntries;
  final GetServiceEntryModel? getServiceEntries;

  final SalesCountPendingPaidModel? salescount;

  CollectionHomeStates({
    this.getServiceEntries,
    this.getSalesEntries,
    this.salescount,
  });

  CollectionHomeStates copyWith({
    GetSalesEntryModel? getSalesEntries,
    GetServiceEntryModel? getServiceEntries,
    SalesCountPendingPaidModel? salescount,
  }) {
    return CollectionHomeStates(
      getServiceEntries: getServiceEntries ?? this.getServiceEntries,
      getSalesEntries: getSalesEntries ?? this.getSalesEntries,
      salescount: salescount ?? this.salescount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CollectionHomeStates &&
        other.getSalesEntries == getSalesEntries &&
        other.getServiceEntries == getServiceEntries &&
        other.salescount == salescount;
  }

  @override
  int get hashCode {
    return getSalesEntries.hashCode ^
        getServiceEntries.hashCode ^
        salescount.hashCode;
  }
}

class CollectionHomeLoading extends CollectionHomeStates {
  CollectionHomeLoading()
      : super(
          getSalesEntries: null,
          getServiceEntries: null,
          salescount: null,
        );
}

class CollectionHomeLogout extends CollectionHomeStates {
  final String message;

  CollectionHomeLogout({required this.message});
}

class CollectionHomeError extends CollectionHomeStates {
  final String message;

  CollectionHomeError({required this.message});
}
