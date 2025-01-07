import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/Constants/utils.dart';
import 'package:savitri_automobiles_admin/common/commonmethods.dart';
import 'package:savitri_automobiles_admin/data/response/status.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/sales_cubit/service_graph_state.dart';
import 'package:savitri_automobiles_admin/modules/model/getservicegraphmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/servicecountmodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/Service_repository.dart';
import 'package:savitri_automobiles_admin/resources/strings.dart';

class ServiceGraphCubit extends Cubit<ServiceGraphState> {
  final ServiceRepository servicerepository = ServiceRepository();
  ServiceGraphCubit() : super(ServiceGraphLoading()) {
    getServiceCountApi();
    getServiceGraphApi();
  }

  List<Map<String, dynamic>> processChartData(List<Datagraph> rawData) {
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
        'sparePartsCount': item.sparePartsCount ?? 0,
        'oilsCount': item.oilsCount ?? 0,
      };
    }).toList();
  }

  void updateChartData(data) {
    if (data != null) {
      final processedData = processChartData(data ?? []);

      emit(state.copyWith(
          sparePartData: processedData
              .map((item) =>
                  {'month': item['month'], 'sales': item['sparePartsCount']})
              .toList(),
          oilData: processedData
              .map((item) =>
                  {'month': item['month'], 'sales': item['oilsCount']})
              .toList()));
    }
  }

  void setError(String value) => error = value;
  String error = '';

  var isLoading = false;
  var rxRequestStatus = Status.COMPLETED;

  void setRxRequestStatus(Status value) => rxRequestStatus = value;

  Future<void> getServiceCountApi() async {
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);
      try {
        ServiceCountModel response =
            await servicerepository.getServiceCountallApi();
        emit(state.copyWith(getservicecount: response));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(ServiceGraphError(errorResponse['message']));
            return;
          } else {
            emit(ServiceGraphError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(ServiceGraphError("${error.toString()} Login failed..."));
          return;
        }
      }
    } else {
      emit(ServiceGraphError(appStrings.weUnableCheckData));
      return;
    }
  }

  Future<void> getServiceGraphApi() async {
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);
      try {
        GetServiceGraphModel response =
            await servicerepository.getServiceGraphApi();
        emit(state.copyWith(getServiceGraph: response));
        updateChartData(response.data);

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(ServiceGraphError(errorResponse['message']));
            return;
          } else {
            emit(ServiceGraphError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(ServiceGraphError("${error.toString()} Login failed..."));
          return;
        }
      }
    } else {
      emit(ServiceGraphError(appStrings.weUnableCheckData));
      return;
    }
  }
}
