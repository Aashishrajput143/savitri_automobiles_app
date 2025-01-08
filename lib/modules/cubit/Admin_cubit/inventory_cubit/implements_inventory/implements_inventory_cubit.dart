import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:savitri_automobiles_admin/Constants/utils.dart';
import 'package:savitri_automobiles_admin/common/commonmethods.dart';
import 'package:savitri_automobiles_admin/data/response/status.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/inventory_cubit/implements_inventory/implements_inventory_state.dart';
import 'package:savitri_automobiles_admin/modules/model/getimplementsmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/implementinventorymodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/select_implement_repository.dart';
import 'package:savitri_automobiles_admin/resources/strings.dart';

class ImplementsInventoryCubit extends Cubit<ImplementInventoryState> {
  final ImplementsRepository implementrepository = ImplementsRepository();

  ImplementsInventoryCubit() : super(ImplementsInventoryLoading()) {
    getImplement();
  }

  var priceController = TextEditingController();
  var stockController = TextEditingController();
  var id = "";
  void setError(String value) => error = value;
  String error = '';

  var isLoading = false;
  var rxRequestStatus = Status.COMPLETED;

  void setRxRequestStatus(Status value) => rxRequestStatus = value;

  Future<void> getImplement() async {
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> requestData = {"page": 1, "pageSize": 20};

      try {
        GetImplementModel response =
            await implementrepository.getImplementApi(requestData);
        emit(state.copyWith(getImplementsmodel: response));
        print(
            "fjksnflkjdsf=??${state.getImplementsmodel?.data?.docs?[0].modelName}");

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
        emit(ImplementsInventoryloaded(
            getImplementsmodel: response, message: "Successfully fetch...."));
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(ImplementsInventoryError(errorResponse['message']));
            return;
          } else {
            emit(ImplementsInventoryError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(ImplementsInventoryError("${error.toString()} failed..."));
          return;
        }
      }
    } else {
      emit(ImplementsInventoryError(appStrings.weUnableCheckData));
      return;
    }
  }

  void showUpdateDialog(BuildContext context, int index) {
    priceController.text =
        state.getImplementsmodel?.data?.docs?[index].price.toString() ?? "0";
    stockController.text =
        state.getImplementsmodel?.data?.docs?[index].quantity.toString() ?? "0";

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
                      addSpecificationImplement(context,
                          state.getImplementsmodel?.data?.docs?[index].sId);
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

  Future<void> addSpecificationImplement(context, id) async {
    Navigator.pop(context);
    emit(ImplementsInventoryLoading());
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
        ImplementInventoryModel response =
            await implementrepository.implementinventory(requestData);

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
        getImplement();
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            Utils.printLog("errorResponse===> ${errorResponse['message']}");
            emit(ImplementsInventoryError(errorResponse['message']));
            return;
          } else {
            Utils.printLog("errorResponse===> ${errorResponse['message']}");
            emit(ImplementsInventoryError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(ImplementsInventoryError("${error.toString()} failed..."));
          return;
        }
      }
    } else {
      emit(ImplementsInventoryError(appStrings.weUnableCheckData));
      return;
    }
  }
}
