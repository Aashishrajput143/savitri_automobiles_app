import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Salesman_cubit/review_sale/review_sale_cubit.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Salesman_cubit/review_sale/review_sale_state.dart';
import 'package:savitri_automobiles_admin/resources/defaultfocusnode.dart';
import 'package:savitri_automobiles_admin/resources/formatter.dart';
import 'package:savitri_automobiles_admin/routes/routes.dart';

class ReviewSalesScreen extends StatelessWidget {
  const ReviewSalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? salesEntryData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    // String? id = ModalRoute.of(context)?.settings.arguments as String?;

    return BlocProvider(
      create: (context) => ReviewCubit(salesEntryData ?? {}),
      child: const ReviewPage(),
    );
  }
}

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    // String? id = ModalRoute.of(context)?.settings.arguments as String?;
    final Map<String, dynamic>? salesEntryData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return dismissKeyboardOnTap(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sales Review Screen'),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          automaticallyImplyLeading: true,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: BlocProvider(
          create: (_) => ReviewCubit(salesEntryData ?? {}),
          child: BlocConsumer<ReviewCubit, ReviewState>(
            listener: (BuildContext context, ReviewState state) {
              if (state is ReviewSuccess) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        "Entry Updated Successfully",
                        style: TextStyle(fontSize: 14),
                      ),
                      content: const Text(
                          "The sales entry has been updated successfully."),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, Routes.saleHome);
                              },
                              child: const Text(
                                "Home",
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
              if (state is ReviewError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Failed to Apply....")),
                );
              }
            },
            builder: (context, state) {
              final cubit = context.read<ReviewCubit>();
              if (state is ReviewSaleLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ReviewLoading) {
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
                      if (state.tractoreditcheck == false) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Selected Tractor Model",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                                color: Colors.green,
                                onPressed: () {
                                  cubit.tractoreditcheck(true);
                                },
                                icon: const Icon(Icons.edit))
                          ],
                        ),
                        const Divider(thickness: 1.5),
                        const SizedBox(height: 8),
                        if (state.selectedTractor != null) ...[
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
                          _buildDetailRow(
                              "fuelType",
                              state.selectedTractor?.fuelType ??
                                  "Not Available"),
                          _buildDetailRow(
                              "features",
                              state.selectedTractor?.features ??
                                  "Not Available"),
                        ],
                      ],
                      if (state.tractoreditcheck ?? false) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Select Tractor Model",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                                onPressed: () {
                                  cubit.tractoreditcheck(false);
                                },
                                color: Colors.green,
                                icon: const Icon(Icons.done))
                          ],
                        ),
                        const Divider(thickness: 1.5),
                        const SizedBox(height: 8),
                        DropdownSearch<String>(
                          key: cubit.dropDownKey,
                          selectedItem: state.selectedTractor?.modelName ??
                              "Select Tractor Model",
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
                      ],
                      if ((state.selectedTractor != null) &&
                          (state.tractoreditcheck == true)) ...[
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
                        _buildDetailRow("fuelType",
                            state.selectedTractor?.fuelType ?? "Not Available"),
                        _buildDetailRow("features",
                            state.selectedTractor?.features ?? "Not Available"),
                      ],
                      const SizedBox(height: 40),

                      // Customer Details
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Customer Details",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          state.customereditcheck ?? false
                              ? IconButton(
                                  color: Colors.green,
                                  onPressed: () {
                                    cubit.customereditcheck(false);
                                  },
                                  icon: const Icon(Icons.done),
                                )
                              : IconButton(
                                  color: Colors.green,
                                  onPressed: () {
                                    cubit.customereditcheck(true);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                        ],
                      ),
                      const Divider(thickness: 1.5),
                      const SizedBox(height: 8),
                      if (state.customereditcheck == false) ...[
                        _buildDetailRow("Name", cubit.nameController.text),
                        _buildDetailRow(
                          "Contact",
                          cubit.contactController.text,
                        ),
                        _buildDetailRow(
                          "Address",
                          cubit.addressController.text,
                        ),
                      ],
                      if (state.customereditcheck ?? false) ...[
                        _buildDetailRowWithTextField(
                            "Name", cubit.nameController, "Enter Name", 20),
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
                            cubit.addressController, "Enter Address", 40),
                      ],
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Exchange Item Details",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            state.exhangeeditcheck ?? false
                                ? IconButton(
                                    color: Colors.green,
                                    onPressed: () {
                                      cubit.exhangeeditcheck(false);
                                    },
                                    icon: const Icon(Icons.done),
                                  )
                                : IconButton(
                                    color: Colors.green,
                                    onPressed: () {
                                      cubit.exhangeeditcheck(true);
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                          ],
                        ),
                        const Divider(thickness: 1.5),
                        const SizedBox(height: 8),
                        if (state.exhangeeditcheck == false) ...[
                          _buildDetailRow(
                              "Model",
                              cubit.exchangemodelController.text.isNotEmpty
                                  ? cubit.exchangemodelController.text
                                  : "Not Available"),
                          _buildDetailRow(
                              "Brand",
                              cubit.exchangebrandController.text.isNotEmpty
                                  ? cubit.exchangebrandController.text
                                  : "Not Available"),
                          _buildDetailRow(
                              "Vehicle Age",
                              cubit.exchangevehicleageController.text.isNotEmpty
                                  ? cubit.exchangevehicleageController.text
                                  : "Not Available"),
                          _buildDetailRow(
                              "Vehicle Type",
                              cubit.exchangevehicleTypeController.text
                                      .isNotEmpty
                                  ? cubit.exchangevehicleTypeController.text
                                  : "Not Available"),
                          _buildDetailRow("Vehicle Amount",
                              "₹${PriceFormatter.formatPrice(state.exchangeprice ?? 0)}"),
                          _buildDetailRow(
                              "Vehicle Description",
                              cubit.exchangedescriptionController.text
                                      .isNotEmpty
                                  ? cubit.exchangedescriptionController.text
                                  : "Not Available"),
                        ],
                        if (state.exhangeeditcheck ?? false) ...[
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
                      ],
                      const SizedBox(height: 40),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Registration Details",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          state.registrationeditcheck ?? false
                              ? IconButton(
                                  color: Colors.green,
                                  onPressed: () {
                                    cubit.registrationeditcheck(false);
                                  },
                                  icon: const Icon(Icons.done),
                                )
                              : IconButton(
                                  color: Colors.green,
                                  onPressed: () {
                                    cubit.registrationeditcheck(true);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                        ],
                      ),
                      const Divider(thickness: 1.5),
                      const SizedBox(height: 8),
                      if (state.registrationeditcheck == false) ...[
                        _buildDetailRow("Registration Type",
                            state.registrationType ?? "Not Available"),
                        _buildDetailRow("Registration Cost",
                            "₹${PriceFormatter.formatPrice(state.registrationprice ?? 0)}"),
                      ],
                      if (state.registrationeditcheck ?? false) ...[
                        DropdownSearch<String>(
                          key: cubit.dropDownKeyRegistration,
                          selectedItem:
                              state.registrationType ?? "Select registration",
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
                      ],

                      const SizedBox(height: 40),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.equipmenteditcheck ?? false
                                ? "Select Equipments"
                                : "Selected Equipments",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          state.equipmenteditcheck ?? false
                              ? IconButton(
                                  color: Colors.green,
                                  onPressed: () {
                                    cubit.equipmenteditcheck(false);
                                  },
                                  icon: const Icon(Icons.done),
                                )
                              : IconButton(
                                  color: Colors.green,
                                  onPressed: () {
                                    cubit.equipmenteditcheck(true);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                        ],
                      ),
                      const Divider(thickness: 1.5),
                      const SizedBox(height: 8),
                      if (state.equipmenteditcheck == false) ...[
                        if (state.selectedEquipmentsname?.isEmpty ?? true) ...[
                          for (int i = 0;
                              i < (state.selectedEquipmentsname?.length ?? 0);
                              i++)
                            _buildDetailRow(
                                state.selectedEquipmentsname?[i] ??
                                    "Not Available",
                                "₹${PriceFormatter.formatPrice(state.selectedEquipmentsprice?[i] ?? 0)} "),
                        ] else if (state.selectedEquipmentsname?.isNotEmpty ??
                            true) ...[
                          for (int i = 0;
                              i < (state.selectedEquipmentsname?.length ?? 0);
                              i++)
                            _buildDetailRow(
                                state.selectedEquipmentsname?[i] ??
                                    "Not Available",
                                "₹${PriceFormatter.formatPrice(state.selectedEquipmentsprice?[i] ?? "0")} "),
                        ]
                      ],
                      if (state.equipmenteditcheck ?? false) ...[
                        MultiSelectDialogField(
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
                      ],

                      const SizedBox(height: 40),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Insurance Details",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          state.insuranceeditcheck ?? false
                              ? IconButton(
                                  color: Colors.green,
                                  onPressed: () {
                                    cubit.insuranceeditcheck(false);
                                  },
                                  icon: const Icon(Icons.done),
                                )
                              : IconButton(
                                  color: Colors.green,
                                  onPressed: () {
                                    cubit.insuranceeditcheck(true);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                        ],
                      ),
                      const Divider(thickness: 1.5),
                      const SizedBox(height: 8),
                      if (state.insuranceeditcheck == false) ...[
                        _buildDetailRow(
                            "Insurance Provider",
                            cubit.insuranceProviderController.text.isEmpty
                                ? "Not Available"
                                : cubit.insuranceProviderController.text),
                        _buildDetailRow("Insurance Cost",
                            "₹${PriceFormatter.formatPrice(state.insuranceprice ?? 0)}"),
                      ],
                      if (state.insuranceeditcheck ?? false) ...[
                        _buildDetailRowWithTextField(
                            "Insurance Provider",
                            cubit.insuranceProviderController,
                            "Enter Insurance Provider",
                            20),
                        _buildDetailAmountRowWithTextField(
                            "Insurance Cost",
                            cubit.insuranceCostController,
                            "Enter Insurance Cost",
                            10,
                            cubit,
                            "insurance"),
                      ],

                      const SizedBox(height: 40),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Finance Details",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          state.financeeditcheck ?? false
                              ? IconButton(
                                  color: Colors.green,
                                  onPressed: () {
                                    cubit.financeeditcheck(false);
                                  },
                                  icon: const Icon(Icons.done),
                                )
                              : IconButton(
                                  color: Colors.green,
                                  onPressed: () {
                                    cubit.financeeditcheck(true);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                        ],
                      ),

                      const Divider(thickness: 1.5),
                      const SizedBox(height: 8),
                      if (state.financeeditcheck == false) ...[
                        _buildDetailRow(
                            "Finance Tenure", state.finance ?? "Not Available"),
                        _buildDetailRow("Finance Cost",
                            "₹${PriceFormatter.formatPrice(state.financeprice ?? 0)}"),
                      ],
                      if (state.financeeditcheck ?? false) ...[
                        DropdownSearch<String>(
                          key: cubit.dropDownKeyfinance,
                          selectedItem:
                              state.finance ?? "Select Finance Tenure",
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
                      ],

                      const SizedBox(height: 40),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Transportation",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          state.transportationeditcheck ?? false
                              ? IconButton(
                                  color: Colors.green,
                                  onPressed: () {
                                    cubit.transportationeditcheck(false);
                                  },
                                  icon: const Icon(Icons.done),
                                )
                              : IconButton(
                                  color: Colors.green,
                                  onPressed: () {
                                    cubit.transportationeditcheck(true);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                        ],
                      ),

                      const Divider(thickness: 1.5),
                      const SizedBox(height: 8),
                      if (state.transportationeditcheck == false) ...[
                        _buildDetailRow("Transportation Cost",
                            "₹${PriceFormatter.formatPrice(state.transportationprice ?? 0)}"),
                      ],
                      if (state.transportationeditcheck ?? false) ...[
                        _buildDetailAmountRowWithTextField(
                            "Transportation Cost",
                            cubit.transportationCostController,
                            "Enter transportation cost",
                            10,
                            cubit,
                            "transportation"),
                      ],

                      const SizedBox(height: 40),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Payment Details",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          state.paymenteditcheck ?? false
                              ? IconButton(
                                  color: Colors.green,
                                  onPressed: () {
                                    cubit.paymenteditcheck(false);
                                  },
                                  icon: const Icon(Icons.done),
                                )
                              : IconButton(
                                  color: Colors.green,
                                  onPressed: () {
                                    cubit.paymenteditcheck(true);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                        ],
                      ),
                      const Divider(thickness: 1.5),
                      const SizedBox(height: 8),
                      if (state.paymenteditcheck == false) ...[
                        _buildDetailRow("Payment Method",
                            state.paymentmethod ?? "Not Available"),
                        _buildDetailRow("Paid Amount",
                            "₹${PriceFormatter.formatPrice(state.paidamount ?? 0)}"),
                        _buildDetailRow("Due Amount",
                            "₹${PriceFormatter.formatPrice((state.tractorprice ?? 0.0) + (state.registrationprice ?? 0.0) + (state.implementprice ?? 0.0) + (state.insuranceprice ?? 0.0) - (state.financeprice ?? 0.0) + (state.isChecked == true ? -(state.exchangeprice ?? 0.0) : 0) + (state.transportationprice ?? 0.0) - (state.paidamount ?? 0))}"),
                      ],
                      if (state.paymenteditcheck ?? false) ...[
                        DropdownSearch<String>(
                          key: cubit.dropDownKeypaymentmethod,
                          selectedItem: "Select Payment Method",
                          items: (value, c) => [
                            "CASH",
                            "UPI",
                            "Net Banking",
                            "Card",
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
                        const SizedBox(height: 8),
                        _buildDetailRow("Due Amount",
                            "₹${PriceFormatter.formatPrice((state.tractorprice ?? 0.0) + (state.registrationprice ?? 0.0) + (state.implementprice ?? 0.0) + (state.insuranceprice ?? 0.0) - (state.financeprice ?? 0.0) + (state.isChecked == true ? -(state.exchangeprice ?? 0.0) : 0.0) + (state.transportationprice ?? 0.0) - (state.paidamount ?? 0))}"),
                      ],

                      const SizedBox(height: 40),

                      const Text(
                        "Total Payment",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(thickness: 1.5),
                      const SizedBox(height: 8),
                      _buildAmountRow(
                          "Tractor Price",
                          "₹${PriceFormatter.formatPrice(state.tractorprice ?? 0)}",
                          false),
                      for (int i = 0;
                          i < (state.selectedEquipmentsname?.length ?? 0);
                          i++)
                        _buildAmountRow(
                            state.selectedEquipmentsname?[i] ?? "Not Available",
                            "+ ₹${PriceFormatter.formatPrice(state.selectedEquipmentsprice?[i] ?? 0)} ",
                            false),
                      _buildAmountRow(
                          "Registration Cost",
                          "+ ₹${PriceFormatter.formatPrice(state.registrationprice ?? 0)}",
                          false),
                      _buildAmountRow(
                          "Insurance Cost",
                          "+ ₹${PriceFormatter.formatPrice(state.insuranceprice ?? 0)}",
                          false),
                      _buildAmountRow(
                          "Transportation Cost",
                          "+ ₹${PriceFormatter.formatPrice(state.transportationprice ?? 0)}",
                          false),

                      if (state.isChecked == true)
                        _buildAmountRow(
                            "Exchange Vehicle Cost",
                            "- ₹${PriceFormatter.formatPrice(state.exchangeprice ?? 0)}",
                            false),
                      const Divider(thickness: 1.5),
                      _buildAmountRow(
                          "Total Amount",
                          "₹${PriceFormatter.formatPrice((state.tractorprice ?? 0.0) + (state.registrationprice ?? 0.0) + (state.implementprice ?? 0.0) + (state.insuranceprice ?? 0.0) + (state.isChecked == true ? -(state.exchangeprice ?? 0.0) : 0) + (state.transportationprice ?? 0.0))}",
                          true),
                      const Divider(thickness: 1.5),

                      const SizedBox(height: 40),

                      const Text(
                        "Payment Summary",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(thickness: 1.5),
                      const SizedBox(height: 8),
                      _buildAmountRow(
                          "Total Amount",
                          "₹${PriceFormatter.formatPrice((state.tractorprice ?? 0.0) + (state.registrationprice ?? 0.0) + (state.implementprice ?? 0.0) + (state.insuranceprice ?? 0.0) + (state.isChecked == true ? -(state.exchangeprice ?? 0.0) : 0) + (state.transportationprice ?? 0.0))}",
                          true),
                      _buildAmountPaidRow(
                          "Paid Amount",
                          "- ₹${PriceFormatter.formatPrice(state.paidamount ?? 0)}",
                          true),
                      if (cubit.financeamountController.text != "0")
                        _buildAmountPaidRow(
                            "Finance Cost",
                            "- ₹${PriceFormatter.formatPrice(state.financeprice ?? 0)}",
                            true),
                      const Divider(thickness: 1.5),
                      _buildAmountPaidRow(
                          "Due Amount",
                          "₹${PriceFormatter.formatPrice((state.tractorprice ?? 0.0) + (state.registrationprice ?? 0.0) + (state.implementprice ?? 0.0) + (state.insuranceprice ?? 0.0) - (state.financeprice ?? 0.0) + (state.isChecked == true ? -(state.exchangeprice ?? 0.0) : 0) + (state.transportationprice ?? 0.0) - (state.paidamount ?? 0))}",
                          false),
                      const Divider(thickness: 1.5),

                      const SizedBox(height: 40),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 30),
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
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
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
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Flexible(
            child: SizedBox(
              width: 110,
              child: Text(
                overflow: TextOverflow.clip,
                value.toString(),
                style: const TextStyle(
                  fontSize: 16,
                ),
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
          SizedBox(
            width: 100,
            child: Text(
              overflow: TextOverflow.clip,
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: bold ? FontWeight.bold : FontWeight.w500,
              ),
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
          SizedBox(
            width: 100,
            child: Text(
              overflow: TextOverflow.clip,
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: paid ? Colors.green : Colors.red,
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
