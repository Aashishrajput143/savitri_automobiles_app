import 'package:equatable/equatable.dart';
import 'package:savitri_automobiles_admin/modules/model/getsalesentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getserviceentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/salescountpendingpaidmodel.dart';

abstract class CollectionHomeStates extends Equatable {
  const CollectionHomeStates();

  @override
  List<Object?> get props => [];
}

class CollectionHomeLoading extends CollectionHomeStates {
  const CollectionHomeLoading();
}

class CollectionHomeLogout extends CollectionHomeStates {
  final String message;

  const CollectionHomeLogout({required this.message});

  @override
  List<Object?> get props => [];
}

class CollectionHomeLoaded extends CollectionHomeStates {
  final GetSalesEntryModel? getSalesEntries;
  final GetServiceEntryModel? getServiceEntries;

  final SalesCountPendingPaidModel? salescount;
  const CollectionHomeLoaded(
      {this.getSalesEntries, this.getServiceEntries, this.salescount});

  @override
  List<Object?> get props => [getSalesEntries, getServiceEntries, salescount];
}

class CollectionHomeSuccess extends CollectionHomeStates {
  final String message;

  const CollectionHomeSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class CollectionHomeError extends CollectionHomeStates {
  final String message;

  const CollectionHomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
