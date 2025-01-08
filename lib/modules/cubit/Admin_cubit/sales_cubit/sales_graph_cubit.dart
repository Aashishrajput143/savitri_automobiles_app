import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/Constants/utils.dart';
import 'package:savitri_automobiles_admin/common/commonmethods.dart';
import 'package:savitri_automobiles_admin/data/response/status.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/sales_cubit/sales_graph_state.dart';
import 'package:savitri_automobiles_admin/modules/model/getsalesgraph.dart';
import 'package:savitri_automobiles_admin/modules/model/salescounttractorimplementmodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/Sales_repository.dart';
import 'package:savitri_automobiles_admin/resources/strings.dart';

class SalesGraphCubit extends Cubit<SalesGraphState> {
  final SalesRepository salesrepository = SalesRepository();
  SalesGraphCubit() : super(SalesGraphLoading()) {
    getSalesCountApi();
    getSalesGraphApi();
  }

  List<Map<String, dynamic>> processChartData(List<DataSalesGraph> rawData) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sept',
      'Oct',
      'Nov',
      'Dec',
    ];

    return rawData.map((item) {
      return {
        'month':
            monthNames[(item.month ?? 1) - 1], // Convert month number to name
        'equipmentCount': item.equipmentCount ?? 0,
        'tractorCount': item.tractorCount ?? 0,
      };
    }).toList();
  }

  void updateChartData(data) {
    if (data != null) {
      final processedData = processChartData(data ?? []);

      emit(state.copyWith(
          tractorData: processedData
              .map((item) =>
                  {'month': item['month'], 'sales': item['tractorCount']})
              .toList(),
          accessoryData: processedData
              .map((item) =>
                  {'month': item['month'], 'sales': item['equipmentCount']})
              .toList()));
    }
  }

  void setError(String value) => error = value;
  String error = '';

  var isLoading = false;
  var rxRequestStatus = Status.COMPLETED;

  void setRxRequestStatus(Status value) => rxRequestStatus = value;

  Future<void> getSalesCountApi() async {
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);
      try {
        SalesCountTractorImplementModel response =
            await salesrepository.getSalesCountAllApi();
        emit(state.copyWith(getSalescount: response));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(SalesGraphError(errorResponse['message']));
            return;
          } else {
            emit(SalesGraphError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(SalesGraphError("${error.toString()} failed..."));
          return;
        }
      }
    } else {
      emit(SalesGraphError(appStrings.weUnableCheckData));
      return;
    }
  }

  Future<void> getSalesGraphApi() async {
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);
      try {
        SalesGraphModel response = await salesrepository.getSalesGraphApi();
        emit(state.copyWith(getSalesGraph: response));
        updateChartData(response.data);

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(SalesGraphError(errorResponse['message']));
            return;
          } else {
            emit(SalesGraphError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(SalesGraphError("${error.toString()} failed..."));
          return;
        }
      }
    } else {
      emit(SalesGraphError(appStrings.weUnableCheckData));
      return;
    }
  }
}
