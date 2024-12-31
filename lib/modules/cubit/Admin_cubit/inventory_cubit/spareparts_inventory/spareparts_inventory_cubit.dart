import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:savitri_automobiles_admin/Constants/utils.dart';
import 'package:savitri_automobiles_admin/common/commonmethods.dart';
import 'package:savitri_automobiles_admin/data/response/status.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/inventory_cubit/spareparts_inventory/spareparts_inventory_state.dart';
import 'package:savitri_automobiles_admin/modules/model/getsparepartsmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/sparepartsinventorymodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/select_spareparts_repository.dart';
import 'package:savitri_automobiles_admin/resources/strings.dart';

class SparepartsInventoryCubit extends Cubit<SparepartsInventoryState> {
  final SparePartsRepository sparepartsrepository = SparePartsRepository();

  SparepartsInventoryCubit() : super(SparepartsInventoryLoading()) {
    getSpareParts();
  }

  var priceController = TextEditingController();
  var stockController = TextEditingController();
  var id = "";
  void setError(String value) => error = value;
  String error = '';

  var isLoading = false;
  var rxRequestStatus = Status.COMPLETED;

  void setRxRequestStatus(Status value) => rxRequestStatus = value;

  Future<void> getSpareParts() async {
    await Future.delayed(const Duration(seconds: 2));
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> requestData = {"page": 1, "pageSize": 20};

      try {
        GetSparePartsModel response =
            await sparepartsrepository.getsparepartsApi(requestData);
        emit(state.copyWith(getSparepartsmodel: response));
        print(
            "fjksnflkjdsf=??${state.getSparepartsmodel?.data?.docs?[0].partName}");

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
        emit(SparepartsInventoryloaded(
            getSparepartsmodel: response, message: "Successfully fetch...."));
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(SparepartsInventoryError(errorResponse['message']));
            return;
          } else {
            emit(SparepartsInventoryError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
        }
      }
    } else {
      emit(SparepartsInventoryError(appStrings.weUnableCheckData));
      return;
    }
  }

  void showUpdateDialog(BuildContext context, int index) {
    priceController.text =
        state.getSparepartsmodel?.data?.docs?[index].price.toString() ?? "0";
    stockController.text =
        state.getSparepartsmodel?.data?.docs?[index].quantity.toString() ?? "0";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text("Update Inventory"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: "Update Price",
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: stockController,
                decoration: const InputDecoration(
                  labelText: "Update Stock",
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.green)),
                    onPressed: () {
                      addSpecificationSpareParts(context,
                          state.getSparepartsmodel?.data?.docs?[index].sId);
                    },
                    child: const Text(
                      "Update",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> addSpecificationSpareParts(context, id) async {
    Navigator.pop(context);
    emit(SparepartsInventoryLoading());
    await Future.delayed(const Duration(seconds: 2));
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> requestData = {
        "_id": id.toString(),
        "price": int.parse(priceController.text),
        "quantity": int.parse(stockController.text)
      };

      try {
        SparePartsInventoryModel response =
            await sparepartsrepository.sparepartsinventory(requestData);

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
        getSpareParts();
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            Utils.printLog("errorResponse===> ${errorResponse['message']}");
            emit(SparepartsInventoryError(errorResponse['message']));
            return;
          } else {
            Utils.printLog("errorResponse===> ${errorResponse['message']}");
            emit(SparepartsInventoryError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
        }
      }
    } else {
      emit(SparepartsInventoryError(appStrings.weUnableCheckData));
      return;
    }
  }
}
