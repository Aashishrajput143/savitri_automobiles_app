import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Salesman_cubit/add_sale_entry_cubit/add_sale_cubit.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Salesman_cubit/add_sale_entry_cubit/add_sale_state.dart';
import 'package:savitri_automobiles_admin/resources/priceformatter.dart';

import '../../../routes/routes.dart';

class SalesEntryScreen extends StatelessWidget {
  const SalesEntryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddSaleCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("Add Sales Entry"),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.notification);
                },
                icon: const Icon(Icons.notifications_outlined),
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: BlocBuilder<AddSaleCubit, AddSaleState>(
          builder: (context, state) {
            final cubit = context.read<AddSaleCubit>();
            if (state is AddSaleLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
              height: MediaQuery.of(context).size.height * 0.9,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select Tractor Model",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    DropdownSearch<String>(
                      key: cubit.dropDownKey,
                      selectedItem: "Select a Tractor",
                      items: (value, c) =>
                          state.gettractormodel?.data?.docs?.map((tractor) {
                            return tractor.modelName ?? 'Unknown';
                          }).toList() ??
                          [],
                      decoratorProps: const DropDownDecoratorProps(
                        decoration: InputDecoration(
                          labelText: 'Select Tractor Model',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      popupProps: const PopupProps.menu(
                        fit: FlexFit.loose,
                        constraints: BoxConstraints(
                          maxHeight:
                              225, // Set the max height for the dropdown menu
                        ),
                        menuProps: MenuProps(
                          backgroundColor: Colors.white,
                          elevation: 2,
                        ),
                      ),
                      onChanged: (value) {
                        if (value != null) {
                          final selectedTractor =
                              state.gettractormodel?.data?.docs?.firstWhere(
                            (tractor) => tractor.modelName == value,
                          );

                          if (selectedTractor != null) {
                            cubit.selectTractor(selectedTractor.sId ?? "");
                            print(
                                "Selected Tractor ID: ${selectedTractor.sId}");
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 30),

                    if (state.selectedTractor != null) ...[
                      const Text(
                        "Tractor Details",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(thickness: 1.5),
                      const SizedBox(height: 8),
                      _buildDetailRow("Model Name",
                          state.selectedTractor?.modelName ?? "Not Available"),
                      _buildDetailRow(
                          "Manufacture Year",
                          state.selectedTractor?.yearOfManufacture ??
                              "Not Available"),
                      _buildDetailRow("Price",
                          "₹${PriceFormatter.formatPrice(state.selectedTractor?.price ?? 0)}"),
                      _buildDetailRow(
                          "Fuel Capacity",
                          state.selectedTractor?.fuelCapacity ??
                              "Not Available"),
                      _buildDetailRow("fuelType",
                          state.selectedTractor?.fuelType ?? "Not Available"),
                      _buildDetailRow("features",
                          state.selectedTractor?.features ?? "Not Available"),
                    ],
                    const SizedBox(height: 40),

                    // Customer Details
                    const Text(
                      "Customer Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(thickness: 1.5),
                    const SizedBox(height: 8),
                    _buildDetailRowWithTextField(
                        "Name", cubit.nameController, "Enter Name"),
                    _buildDetailAmountRowWithTextField("Contact",
                        cubit.contactController, "Enter Contact Number"),
                    // _buildDetailRowWithTextField(
                    //     "Email", cubit.emailController),
                    _buildDetailRowWithTextField(
                        "Address", cubit.addressController, "Enter Address"),
                    const SizedBox(height: 40),

                    CheckboxListTile(
                      title: const Text("Include Exchange Item"),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                      activeColor: Colors.green,
                      value: state.isChecked ?? false,
                      onChanged: (bool? value) {
                        cubit.toggleExchangeItem(value ?? false);
                      },
                    ),

                    // Exchange Item Details
                    if (state.isChecked ?? false) ...[
                      const SizedBox(height: 20),
                      const Text(
                        "Exchange Item Details",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(thickness: 1.5),
                      const SizedBox(height: 8),
                      // _buildDetailRowWithTextField(
                      //     "Name", cubit.exchangeItemController,"Enter name"),
                      _buildDetailRowWithTextField("Model",
                          cubit.exchangemodelController, "Enter Tractor Model"),
                      _buildDetailRowWithTextField("Brand",
                          cubit.exchangebrandController, "Enter Brand"),
                      _buildDetailAmountRowWithTextField(
                          "Vehicle Age",
                          cubit.exchangevehicleageController,
                          "Enter Vehicle Age"),
                      _buildDetailRowWithTextField(
                          "Vehicle Type",
                          cubit.exchangevehicleTypeController,
                          "Enter Vehicle Type"),
                      _buildDetailAmountRowWithTextField(
                          "Vehicle Amount",
                          cubit.exchangevehicleamountController,
                          "Enter Vehicle Amount"),
                      _buildDetailRowWithTextField(
                          "Vehicle Description",
                          cubit.exchangedescriptionController,
                          "Enter Vehicle Description"),
                    ],
                    const SizedBox(height: 40),
                    const Text(
                      "Registration Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(thickness: 1.5),
                    const SizedBox(height: 8),
                    DropdownSearch<String>(
                      key: cubit.dropDownKeyRegistration,
                      selectedItem: "Select registration",
                      items: (value, c) => ["COMMERCIAL", "AGRICULTURE"],
                      decoratorProps: const DropDownDecoratorProps(
                        decoration: InputDecoration(
                          labelText: 'Select Registration',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      popupProps: const PopupProps.menu(
                        fit: FlexFit.loose,
                        constraints: BoxConstraints(),
                      ),
                      onChanged: (value) {
                        print("Selected Registration type: $value");
                        cubit.selectRegistrationType(value);
                        print(cubit.state.registrationType);
                      },
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      maxLength: 5,
                      controller: cubit.registrationCostController,
                      decoration: const InputDecoration(
                        label: Text("Registration cost"),
                        counterText: "",
                        border: OutlineInputBorder(),
                        hintText: "Enter Registration Cost",
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      "Equipments",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(thickness: 1.5),
                    const SizedBox(height: 8),

                    MultiSelectDialogField(
                      items:
                          state.getimplementmodel?.data?.docs?.map((equipment) {
                                return MultiSelectItem<String>(
                                  equipment.sId.toString(),
                                  "${equipment.modelName.toString()}  (₹${PriceFormatter.formatPrice(equipment.price ?? 0)})",
                                );
                              }).toList() ??
                              [],
                      title: const Text("Equipments"),
                      selectedColor: Colors.black,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      buttonText: const Text(
                        "Equipments",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      initialValue: state.selectedEquipments ?? [],
                      onConfirm: (results) {
                        print(results);
                        cubit.updateSelectedEquipments(results.cast<String>());
                      },
                      chipDisplay: MultiSelectChipDisplay(
                        items: state.selectedEquipments?.map((name) {
                          print(name);
                          return MultiSelectItem<String>(
                            name,
                            name,
                          );
                        }).toList(),
                        chipColor: Colors.grey[300],
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        chipWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                    ),

                    const SizedBox(height: 40),
                    const Text(
                      "Insurance Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(thickness: 1.5),
                    const SizedBox(height: 8),
                    _buildDetailRowWithTextField(
                        "Insurance Provider",
                        cubit.insuranceProviderController,
                        "Enter Insurance Provider"),
                    // _buildDetailRowWithTextField(
                    //     "Policy Number", cubit.policyNumberController),
                    _buildDetailAmountRowWithTextField("Insurance Cost",
                        cubit.insuranceCostController, "Enter Insurance Cost"),

                    const SizedBox(height: 40),

                    const Text(
                      "Finance Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(thickness: 1.5),
                    const SizedBox(height: 8),
                    _buildDetailAmountRowWithTextField("Finance Cost",
                        cubit.financeamountController, "Enter Finance Cost"),
                    _buildDetailRowWithTextField(
                        "Finance Tenure",
                        cubit.financetenureController,
                        "Enter Tenure (in Years)"),

                    const SizedBox(height: 40),

                    const Text(
                      "Transportation",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(thickness: 1.5),
                    const SizedBox(height: 8),
                    _buildDetailAmountRowWithTextField(
                        "Transportation Cost",
                        cubit.transportationCostController,
                        "Enter transportation cost"),
                    const SizedBox(height: 40),

                    const Text(
                      "Total Payment",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(thickness: 1.5),
                    const SizedBox(height: 8),
                    _buildAmountRow(
                        "Tractor Price",
                        "₹${PriceFormatter.formatPrice(state.selectedTractor?.price ?? 0)}",
                        false),
                    _buildAmountRow(
                        "Registration Cost",
                        "+ ₹${PriceFormatter.formatPrice(int.parse(cubit.registrationCostController.text.isNotEmpty ? cubit.registrationCostController.text : "0"))}",
                        false),
                    _buildAmountRow("Swaraj Rotary Price", "+ ₹90,000", false),
                    _buildAmountRow("Swaraj Harrow Price", "+ ₹75,000", false),
                    _buildAmountRow("Swaraj Pillow Price", "+ ₹65,000", false),
                    _buildAmountRow("Insurance Cost", "+ ₹35,259", false),
                    _buildAmountRow("Transportation Cost", "+ ₹35,259", false),
                    const Divider(thickness: 1.5),
                    _buildAmountRow("Total Amount", "₹32,50,000", true),
                    const Divider(thickness: 1.5),

                    const SizedBox(height: 40),

                    const Text(
                      "Payment Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(thickness: 1.5),
                    const SizedBox(height: 8),
                    _buildDetailRowWithTextField("Payment Method",
                        cubit.paymentMethodController, "Enter Payment Method"),
                    _buildDetailAmountRowWithTextField("Paid Amount",
                        cubit.paidAmountController, "Enter Payment Amount"),
                    _buildDetailAmountRowWithTextField("Due Amount",
                        cubit.dueAmountController, "Enter Due Amount"),

                    const SizedBox(height: 40),

                    const Text(
                      "Payment Summary",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(thickness: 1.5),
                    const SizedBox(height: 8),
                    _buildAmountRow("Total Amount", "₹32,50,000", true),
                    _buildAmountPaidRow("Paid Amount", "- ₹12,50,000", true),
                    const Divider(thickness: 1.5),
                    _buildAmountPaidRow("Due Amount", "- ₹20,00,000", false),
                    const Divider(thickness: 1.5),

                    const SizedBox(height: 40),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          cubit.addSalesEntry(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[500],
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          'Preview & Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            width: 170,
            child: Text(
              overflow: TextOverflow.clip,
              value.toString(),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountRow(String label, String value, bool bold) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: bold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          Text(
            overflow: TextOverflow.clip,
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: bold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountPaidRow(String label, String value, bool paid) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            overflow: TextOverflow.clip,
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: paid ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRowWithTextField(
      String label, TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: hint,
                  hintStyle: const TextStyle(fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailAmountRowWithTextField(
      String label, TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: TextField(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              controller: controller,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: hint,
                  hintStyle: const TextStyle(fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }
}
