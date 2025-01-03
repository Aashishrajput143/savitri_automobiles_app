import 'package:savitri_automobiles_admin/modules/model/getsalesentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getserviceentrymodel.dart';

class HomeState {
  final List<Map<String, dynamic>>? salesperson;
  final GetSalesEntryModel? getSalesEntries;
  final GetServiceEntryModel? getServiceEntries;
  final String? message;
  HomeState({
    this.salesperson,
    this.getSalesEntries,
    this.getServiceEntries,
    this.message = "",
  });
  HomeState copyWith({
    List<Map<String, dynamic>>? salesperson,
    GetSalesEntryModel? getSalesEntries,
    GetServiceEntryModel? getServiceEntries,
    String? message,
  }) {
    return HomeState(
      salesperson: salesperson ?? this.salesperson,
      getSalesEntries: getSalesEntries ?? this.getSalesEntries,
      getServiceEntries: getServiceEntries ?? this.getServiceEntries,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HomeState &&
        other.salesperson == salesperson &&
        other.getSalesEntries == getSalesEntries &&
        other.getServiceEntries == getServiceEntries &&
        other.message == message;
  }

  @override
  int get hashCode {
    return salesperson.hashCode ^
        message.hashCode ^
        getSalesEntries.hashCode ^
        getServiceEntries.hashCode;
  }
}

class HomeSuccess extends HomeState {
  HomeSuccess(String message)
      : super(
          getSalesEntries: null,
          getServiceEntries: null,
          message: message,
        );
}

class HomeLogout extends HomeState {
  HomeLogout(String message)
      : super(
          getSalesEntries: null,
          getServiceEntries: null,
          message: message,
        );
}

class HomeError extends HomeState {
  HomeError(String message)
      : super(
          getSalesEntries: null,
          getServiceEntries: null,
          message: message,
        );
}

class HomeLoading extends HomeState {
  HomeLoading()
      : super(
          getSalesEntries: null,
          getServiceEntries: null,
          message: 'Loading...',
        );
}
