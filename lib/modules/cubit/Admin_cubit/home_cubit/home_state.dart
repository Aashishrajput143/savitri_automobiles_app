import 'package:savitri_automobiles_admin/modules/model/getsalesentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getserviceentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/salescounttractorimplementmodel.dart';

class HomeState {
  final GetSalesEntryModel? getSalesEntries;
  final SalesCountTractorImplementModel? getSalesCount;

  final GetServiceEntryModel? getServiceEntries;
  final String? message;
  HomeState({
    this.getSalesEntries,
    this.getSalesCount,
    this.getServiceEntries,
    this.message = "",
  });
  HomeState copyWith({
    GetSalesEntryModel? getSalesEntries,
    GetServiceEntryModel? getServiceEntries,
    SalesCountTractorImplementModel? getSalesCount,
    String? message,
  }) {
    return HomeState(
      getSalesEntries: getSalesEntries ?? this.getSalesEntries,
      getServiceEntries: getServiceEntries ?? this.getServiceEntries,
      getSalesCount: getSalesCount ?? this.getSalesCount,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HomeState &&
        other.getSalesCount == getSalesCount &&
        other.getSalesEntries == getSalesEntries &&
        other.getServiceEntries == getServiceEntries &&
        other.message == message;
  }

  @override
  int get hashCode {
    return message.hashCode ^
        getSalesEntries.hashCode ^
        getSalesCount.hashCode ^
        getServiceEntries.hashCode;
  }
}

class HomeSuccess extends HomeState {
  HomeSuccess(String message)
      : super(
          getSalesEntries: null,
          getServiceEntries: null,
          getSalesCount: null,
          message: message,
        );
}

class HomeLogout extends HomeState {
  HomeLogout(String message)
      : super(
          getSalesEntries: null,
          getServiceEntries: null,
          getSalesCount: null,
          message: message,
        );
}

class HomeError extends HomeState {
  HomeError(String message)
      : super(
          getSalesEntries: null,
          getServiceEntries: null,
          getSalesCount: null,
          message: message,
        );
}

class HomeLoading extends HomeState {
  HomeLoading()
      : super(
          getSalesEntries: null,
          getServiceEntries: null,
          getSalesCount: null,
          message: 'Loading...',
        );
}
