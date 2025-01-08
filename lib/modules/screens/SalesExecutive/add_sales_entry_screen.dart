import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Salesman_cubit/add_sale_entry_cubit/add_sale_cubit.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Salesman_cubit/add_sale_entry_cubit/add_sale_state.dart';
import 'package:savitri_automobiles_admin/resources/defaultfocusnode.dart';
import 'package:savitri_automobiles_admin/resources/formatter.dart';

import '../../../routes/routes.dart';

class SalesEntryScreen extends StatelessWidget {
  const SalesEntryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddSaleCubit(),
      child: dismissKeyboardOnTap(
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
          body: BlocConsumer<AddSaleCubit, AddSaleState>(
            listener: (BuildContext context, AddSaleState state) {
              if (State is AddSaleSuccess) {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.reviewSalesEntry,
                  arguments: state.addSalesEntryModel?.data?.id ?? "",
                );
              }
              if (state is AddSaleError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message ?? "")),
                );
              }
            },
            builder: (context, state) {
              final cubit = context.read<AddSaleCubit>();
              if (state is AddSalesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is AddSaleError) {
                return const Center(
                  child: Text(
                    "Data Not Found...",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              } else if (state is AddSaleLoading) {
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
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Select Tractor Model",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            " *",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(thickness: 1.5),
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
                      if (state.selectedTractor != null) ...[
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Tractor Details",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Divider(thickness: 1.5),
                        const SizedBox(height: 8),
                        _buildDetailRow(
                            "Model Name",
                            state.selectedTractor?.modelName ??
                                "Not Available"),
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
                        _buildDetailRow("Fuel Type",
                            state.selectedTractor?.fuelType ?? "Not Available"),
                        _buildDetailRow("Features",
                            state.selectedTractor?.features ?? "Not Available"),
                      ],
                      const SizedBox(height: 40),

                      // Customer Details
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Customer Details",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            " *",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const Divider(thickness: 1.5),
                      const SizedBox(height: 8),
                      _buildDetailRowWithTextField(
                          "Name", cubit.nameController, "Enter Name", 50),
                      _buildDetailAmountRowWithTextField(
                          "Contact",
                          cubit.contactController,
                          "Enter Contact Number",
                          10,
                          cubit,
                          ""),
                      // _buildDetailRowWithTextField(
                      //     "Email", cubit.emailController),
                      _buildDetailRowWithTextField("Address",
                          cubit.addressController, "Enter Address", 255),
                      const SizedBox(height: 40),

                      CheckboxListTile(
                        title: const Text("Include Exchange Item"),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
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
                        _buildDetailRowWithTextField(
                            "Model",
                            cubit.exchangemodelController,
                            "Enter Tractor Model",
                            20),
                        _buildDetailRowWithTextField("Brand",
                            cubit.exchangebrandController, "Enter Brand", 30),
                        _buildDetailAmountRowWithTextField(
                            "Vehicle Age",
                            cubit.exchangevehicleageController,
                            "Enter Vehicle Age",
                            3,
                            cubit,
                            ""),
                        _buildDetailRowWithTextField(
                            "Vehicle Type",
                            cubit.exchangevehicleTypeController,
                            "Enter Vehicle Type",
                            20),
                        _buildDetailAmountRowWithTextField(
                            "Vehicle Amount",
                            cubit.exchangevehicleamountController,
                            "Enter Vehicle Amount",
                            10,
                            cubit,
                            "exchange"),
                        _buildDetailRowWithTextField(
                            "Vehicle Description",
                            cubit.exchangedescriptionController,
                            "Enter Vehicle Description",
                            100),
                      ],
                      const SizedBox(height: 40),
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Registration Details",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            " *",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                          menuProps: MenuProps(
                            backgroundColor: Colors.white,
                            elevation: 2,
                          ),
                        ),
                        onChanged: (value) {
                          print("Selected Registration type: $value");
                          cubit.selectRegistrationType(value);
                          print(cubit.state.registrationType);
                        },
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        controller: cubit.registrationCostController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        onChanged: (value) {
                          cubit.selectedregistrationcost(
                              int.tryParse(value) ?? 0);
                        },
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(thickness: 1.5),
                      const SizedBox(height: 8),

                      InkWell(
                        onTap: () =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        child: MultiSelectDialogField(
                          items: state.getimplementmodel?.data?.docs
                                  ?.map((equipment) {
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
                            cubit.updateSelectedEquipments(
                                results.cast<String>());
                            int totalPrice = 0;
                            List<String> names = [];
                            List<int> prices = [];
                            for (var selectedId in results.cast<String>()) {
                              var equipment = state
                                  .getimplementmodel?.data?.docs
                                  ?.firstWhere(
                                (doc) => doc.sId == selectedId,
                              );
                              if (equipment != null) {
                                names.add(
                                    equipment.modelName ?? "Not Available");
                                prices.add(equipment.price ?? 0);
                                totalPrice += equipment.price ?? 0;
                              }
                            }
                            cubit.selectedequipmentname(names);
                            cubit.selectedequipmentprice(prices);
                            cubit.selectedequipmentcost(totalPrice);
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
                      ),

                      const SizedBox(height: 40),
                      const Text(
                        "Insurance Details",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(thickness: 1.5),
                      const SizedBox(height: 8),
                      _buildDetailRowWithTextField(
                          "Insurance Provider",
                          cubit.insuranceProviderController,
                          "Enter Insurance Provider",
                          20),
                      // _buildDetailRowWithTextField(
                      //     "Policy Number", cubit.policyNumberController),
                      _buildDetailAmountRowWithTextField(
                          "Insurance Cost",
                          cubit.insuranceCostController,
                          "Enter Insurance Cost",
                          10,
                          cubit,
                          "insurance"),

                      const SizedBox(height: 40),

                      const Text(
                        "Finance Details",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(thickness: 1.5),
                      const SizedBox(height: 8),
                      DropdownSearch<String>(
                        key: cubit.dropDownKeyfinance,
                        selectedItem: "Select Finance Tenure",
                        items: (value, c) => [
                          "3 Months",
                          "6 Months",
                          "1 Year",
                          "2 Years",
                          "3 Years",
                          "5 Years"
                        ],
                        decoratorProps: const DropDownDecoratorProps(
                          decoration: InputDecoration(
                            labelText: 'Select Finance Tenure',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        popupProps: const PopupProps.menu(
                          fit: FlexFit.tight,
                          constraints: BoxConstraints(
                            maxHeight: 225,
                          ),
                          menuProps: MenuProps(
                            backgroundColor: Colors.white,
                            elevation: 2,
                          ),
                        ),
                        onChanged: (value) {
                          print("Selected Finance Tenure Years: $value");
                          cubit.selectFinanceTenure(value);
                          print(cubit.state.finance);
                        },
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        controller: cubit.financeamountController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        onChanged: (value) {
                          cubit.selectedfinancecost(int.tryParse(value) ?? 0);
                        },
                        decoration: const InputDecoration(
                          label: Text("Finance Cost"),
                          counterText: "",
                          border: OutlineInputBorder(),
                          hintText: "Enter Finance Cost",
                        ),
                      ),

                      const SizedBox(height: 40),

                      const Text(
                        "Transportation",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(thickness: 1.5),
                      const SizedBox(height: 8),
                      _buildDetailAmountRowWithTextField(
                          "Transportation Cost",
                          cubit.transportationCostController,
                          "Enter transportation cost",
                          10,
                          cubit,
                          "transportation"),
                      const SizedBox(height: 40),
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Payment Details",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            " *",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(thickness: 1.5),
                      const SizedBox(height: 8),
                      DropdownSearch<String>(
                        key: cubit.dropDownKeypaymentmethod,
                        selectedItem: "Select Payment Method",
                        items: (value, c) => [
                          "CASH",
                          "UPI",
                          "Net Banking",
                          "Card",
                          "Other",
                        ],
                        decoratorProps: const DropDownDecoratorProps(
                          decoration: InputDecoration(
                            labelText: 'Select Payment Method',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        popupProps: const PopupProps.menu(
                          fit: FlexFit.tight,
                          constraints: BoxConstraints(
                            maxHeight: 225,
                          ),
                          menuProps: MenuProps(
                            backgroundColor: Colors.white,
                            elevation: 2,
                          ),
                        ),
                        onChanged: (value) {
                          print("Selected Payment Method: $value");
                          cubit.selectpaymentMethod(value);
                          print(cubit.state.paymentmethod);
                        },
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        controller: cubit.paidAmountController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        onChanged: (value) {
                          cubit.paidAmount(int.tryParse(value) ?? 0);
                        },
                        decoration: const InputDecoration(
                          label: Text("Paid Amount"),
                          counterText: "",
                          border: OutlineInputBorder(),
                          hintText: "Enter Payment Amount",
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(thickness: 1.5),
                      _buildAmountRow(
                          "Total Payable Amount",
                          "₹${PriceFormatter.formatPrice((state.tractorprice ?? 0.0) + (state.registrationprice ?? 0.0) + (state.implementprice ?? 0.0) + (state.insuranceprice ?? 0.0) - (state.financeprice ?? 0.0) + (state.isChecked == true ? -(state.exchangeprice ?? 0.0) : 0) + (state.transportationprice ?? 0.0))} ",
                          true),
                      const Divider(thickness: 1.5),
                      const SizedBox(height: 40),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            if (state.selectedTractormodel != null &&
                                cubit.nameController.text.isNotEmpty &&
                                cubit.contactController.text.isNotEmpty &&
                                cubit.registrationCostController.text
                                    .isNotEmpty &&
                                cubit.paidAmountController.text.isNotEmpty &&
                                state.paymentmethod != null) {
                              if (state.isChecked == true) {
                                if (cubit.exchangebrandController.text.isNotEmpty &&
                                    cubit.exchangemodelController.text
                                        .isNotEmpty &&
                                    cubit.exchangevehicleTypeController.text
                                        .isNotEmpty &&
                                    cubit.exchangevehicleamountController.text
                                        .isNotEmpty &&
                                    cubit.exchangevehicleageController.text
                                        .isNotEmpty) {
                                  print(cubit.prepareSalesEntryData());
                                  Navigator.pushReplacementNamed(
                                    context,
                                    Routes.reviewSalesEntry,
                                    arguments: cubit.prepareSalesEntryData(),
                                  );
                                  //cubit.addSalesEntry(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Please fill all Exchange details")),
                                  );
                                }
                              } else {
                                if (cubit.nameController.text.length < 5) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Name Should atleast 5 character")),
                                  );
                                } else if (cubit.addressController.text.length <
                                    12) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Address Should atleast 12 character")),
                                  );
                                } else if (cubit.contactController.text.length <
                                    10) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Contact Should be 10 digits")),
                                  );
                                } else {
                                  print(cubit.prepareSalesEntryData());
                                  //cubit.addSalesEntry(context);
                                  Navigator.pushReplacementNamed(
                                    context,
                                    Routes.reviewSalesEntry,
                                    arguments: cubit.prepareSalesEntryData(),
                                  );
                                }
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Please fill all the details")),
                              );
                            }
                            // Navigator.pushReplacementNamed(
                            //   context,
                            //   Routes.reviewSalesEntry,
                            //   arguments: state.addSalesEntryModel?.data?.id ??
                            //       "676aace4fb8a2d03c87b62ef",
                            // );
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

  Widget _buildDetailAmountRowWithTextField(
      String label,
      TextEditingController controller,
      String hint,
      int limit,
      cubit,
      String name) {
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
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(limit),
              ],
              controller: controller,
              onChanged: (value) {
                if (name == "finance") {
                  cubit.selectedfinancecost(int.tryParse(value) ?? 0);
                } else if (name == "transportation") {
                  cubit.selectedtransportationcost(int.tryParse(value) ?? 0);
                } else if (name == "exchange") {
                  cubit.selectedexchangecost(int.tryParse(value) ?? 0);
                } else if (name == "insurance") {
                  cubit.selectedinsurancecost(int.tryParse(value) ?? 0);
                }
              },
              keyboardType: TextInputType.number,
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

  Widget _buildDetailRowWithTextField(
      String label, TextEditingController controller, String hint, int limit) {
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
              inputFormatters: [
                NoLeadingSpaceFormatter(),
                RemoveTrailingPeriodsFormatter(),
                SpecialCharacterValidator(),
                EmojiInputFormatter(),
                LengthLimitingTextInputFormatter(limit)
              ],
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
