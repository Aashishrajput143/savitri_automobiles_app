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

class ReviewSalesScreen extends StatelessWidget {
  const ReviewSalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? id = ModalRoute.of(context)?.settings.arguments as String?;

    return BlocProvider(
      create: (context) => ReviewCubit(id ?? ""),
      child: const ReviewPage(),
    );
  }
}

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? id = ModalRoute.of(context)?.settings.arguments as String?;
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
          create: (_) => ReviewCubit(id ?? ""),
          child: BlocBuilder<ReviewCubit, ReviewState>(
            builder: (context, state) {
              final cubit = context.read<ReviewCubit>();
              if (state is ReviewLoading) {
                return const Center(child: CircularProgressIndicator());
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
                        if (state.getSalesEntryDetailsModel?.data?.tractor !=
                            null) ...[
                          _buildDetailRow(
                              "Model Name",
                              state.selectedTractor?.modelName?.isEmpty ?? true
                                  ? state.getSalesEntryDetailsModel?.data
                                          ?.tractor?.modelName ??
                                      "Not Available"
                                  : state.selectedTractor?.modelName),
                          _buildDetailRow(
                              "Manufacture Year",
                              state.selectedTractor?.yearOfManufacture ??
                                  state.getSalesEntryDetailsModel?.data?.tractor
                                      ?.yearOfManufacture ??
                                  "Not Available"),
                          _buildDetailRow("Price",
                              "₹${PriceFormatter.formatPrice(state.selectedTractor?.price ?? state.getSalesEntryDetailsModel?.data?.tractorBasePrice ?? 0)}"),
                          _buildDetailRow(
                              "Fuel Capacity",
                              state.selectedTractor?.fuelCapacity ??
                                  state.getSalesEntryDetailsModel?.data?.tractor
                                      ?.fuelCapacity ??
                                  "Not Available"),
                          _buildDetailRow(
                              "fuelType",
                              state.selectedTractor?.fuelType?.isEmpty ?? true
                                  ? state.getSalesEntryDetailsModel?.data
                                          ?.tractor?.fuelType ??
                                      "Not Available"
                                  : state.selectedTractor?.fuelType),
                          _buildDetailRow(
                              "features",
                              state.selectedTractor?.features?.isEmpty ?? true
                                  ? state.getSalesEntryDetailsModel?.data
                                          ?.tractor?.features ??
                                      "Not Available"
                                  : state.selectedTractor?.features),
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
                          selectedItem:
                              state.selectedTractormodel?.isEmpty ?? true
                                  ? state.getSalesEntryDetailsModel?.data
                                          ?.tractor?.modelName ??
                                      "Select Tractor Model"
                                  : state.selectedTractor?.modelName,
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
                            10),
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
                              "Model", cubit.exchangemodelController.text),
                          _buildDetailRow(
                              "Brand", cubit.exchangebrandController.text),
                          _buildDetailRow("Vehicle Age",
                              cubit.exchangevehicleageController.text),
                          _buildDetailRow("Vehicle Type",
                              cubit.exchangevehicleTypeController.text),
                          _buildDetailRow("Vehicle Amount",
                              "₹${PriceFormatter.formatPrice(int.parse(cubit.exchangevehicleamountController.text))}"),
                          _buildDetailRow("Vehicle Description",
                              cubit.exchangedescriptionController.text),
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
                              3),
                          _buildDetailRowWithTextField(
                              "Vehicle Type",
                              cubit.exchangevehicleTypeController,
                              "Enter Vehicle Type",
                              20),
                          _buildDetailAmountRowWithTextField(
                              "Vehicle Amount",
                              cubit.exchangevehicleamountController,
                              "Enter Vehicle Amount",
                              8),
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
                        _buildDetailRow(
                            "Registration Type",
                            state.registrationType ??
                                state.getSalesEntryDetailsModel?.data
                                    ?.registration?.registrationType),
                        _buildDetailRow("Registration Cost",
                            "₹${PriceFormatter.formatPrice(int.parse(cubit.registrationCostController.text))}"),
                      ],
                      if (state.registrationeditcheck ?? false) ...[
                        DropdownSearch<String>(
                          key: cubit.dropDownKeyRegistration,
                          selectedItem: state.registrationType?.isEmpty ?? true
                              ? state.getSalesEntryDetailsModel?.data
                                      ?.registration?.registrationType ??
                                  "Select registration"
                              : state.registrationType,
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
                        for (int i = 0;
                            i <
                                (state.getSalesEntryDetailsModel?.data
                                        ?.equipments?.length ??
                                    0);
                            i++)
                          _buildDetailRow(
                              state.getSalesEntryDetailsModel?.data
                                      ?.equipments?[i].modelName ??
                                  "Not Available",
                              "₹${PriceFormatter.formatPrice(state.getSalesEntryDetailsModel?.data?.equipments?[i].price ?? 0)} "),
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
                            "Select Equipments",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          initialValue: state.selectedEquipments ??
                              state.getSalesEntryDetailsModel?.data
                                  ?.equipments ??
                              [],
                          onConfirm: (results) {
                            print(results);
                            cubit.updateSelectedEquipments(
                                results.cast<String>());
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
                      if (state.registrationeditcheck == false) ...[
                        _buildDetailRow("Insurance Provider",
                            cubit.insuranceProviderController.text),
                        _buildDetailRow("Insurance Cost",
                            "₹${PriceFormatter.formatPrice(int.parse(cubit.insuranceCostController.text))}"),
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
                            10),
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
                            "Finance Tenure",
                            state.finance?.isEmpty ?? true
                                ? state.getSalesEntryDetailsModel?.data?.finance
                                        ?.tenure?.isEmpty ??
                                    "Not Available"
                                : "Not Available"),
                        _buildDetailRow("Finance Cost",
                            "₹${PriceFormatter.formatPrice(int.parse(cubit.financeamountController.text))}"),
                      ],
                      if (state.financeeditcheck ?? false) ...[
                        DropdownSearch<String>(
                          key: cubit.dropDownKeyfinance,
                          selectedItem: state.finance?.isEmpty ?? true
                              ? state.getSalesEntryDetailsModel?.data?.finance
                                      ?.tenure ??
                                  "Select Finance Tenure"
                              : state.finance,
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
                            "₹${PriceFormatter.formatPrice(int.parse(cubit.transportationCostController.text))}"),
                      ],
                      if (state.transportationeditcheck ?? false) ...[
                        _buildDetailAmountRowWithTextField(
                            "Transportation Cost",
                            cubit.transportationCostController,
                            "Enter transportation cost",
                            10),
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
                      if (state.transportationeditcheck == false) ...[
                        _buildDetailRow(
                            "Payment Method",
                            state.paymentmethod ??
                                state.getSalesEntryDetailsModel?.data
                                    ?.paymentMethod),
                        _buildDetailRow("Paid Amount",
                            "₹${PriceFormatter.formatPrice(int.parse(cubit.paidAmountController.text))}"),
                        _buildDetailRow("Due Amount",
                            "₹${PriceFormatter.formatPrice(cubit.dueamount(cubit.calculateTotalAmount(state, cubit), int.parse(cubit.paidAmountController.text.isNotEmpty ? cubit.paidAmountController.text : "0"), int.parse(cubit.financeamountController.text.isNotEmpty ? cubit.financeamountController.text : "0")))}"),
                      ],
                      if (state.transportationeditcheck ?? false) ...[
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
                          decoration: const InputDecoration(
                            label: Text("Paid Amount"),
                            counterText: "",
                            border: OutlineInputBorder(),
                            hintText: "Enter Payment Amount",
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildDetailRow("Due Amount",
                            "₹${PriceFormatter.formatPrice(cubit.dueamount(cubit.calculateTotalAmount(state, cubit), int.parse(cubit.paidAmountController.text.isNotEmpty ? cubit.paidAmountController.text : "0"), int.parse(cubit.financeamountController.text.isNotEmpty ? cubit.financeamountController.text : "0")))}"),
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
                          "₹${PriceFormatter.formatPrice(state.selectedTractor?.price ?? state.getSalesEntryDetailsModel?.data?.tractorBasePrice ?? 0)}",
                          false),
                      for (int i = 0;
                          i <
                              (state.getSalesEntryDetailsModel?.data?.equipments
                                      ?.length ??
                                  0);
                          i++)
                        _buildAmountRow(
                            state.getSalesEntryDetailsModel?.data
                                    ?.equipments?[i].modelName ??
                                "Not Available",
                            "+ ₹${PriceFormatter.formatPrice(state.getSalesEntryDetailsModel?.data?.equipments?[i].price ?? 0)} ",
                            false),
                      _buildAmountRow(
                          "Registration Cost",
                          "+ ₹${PriceFormatter.formatPrice(int.parse(cubit.registrationCostController.text.isNotEmpty ? cubit.registrationCostController.text : "0"))}",
                          false),
                      _buildAmountRow(
                          "Insurance Cost",
                          "+ ₹${PriceFormatter.formatPrice(int.parse(cubit.insuranceCostController.text.isNotEmpty ? cubit.insuranceCostController.text : "0"))}",
                          false),
                      _buildAmountRow(
                          "Transportation Cost",
                          "+ ₹${PriceFormatter.formatPrice(int.parse(cubit.transportationCostController.text.isNotEmpty ? cubit.transportationCostController.text : "0"))}",
                          false),

                      if (state.isChecked == true)
                        _buildAmountRow(
                            "Exchange Vehicle Cost",
                            "- ₹${PriceFormatter.formatPrice(int.parse(cubit.exchangevehicleamountController.text.isNotEmpty ? cubit.exchangevehicleamountController.text : "0"))}",
                            false),
                      const Divider(thickness: 1.5),
                      _buildAmountRow(
                          "Total Amount",
                          "₹${PriceFormatter.formatPrice(cubit.calculateTotalAmount(state, cubit))}",
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
                          "₹${PriceFormatter.formatPrice(cubit.calculateTotalAmount(state, cubit))}",
                          true),
                      _buildAmountPaidRow(
                          "Paid Amount",
                          "- ₹${PriceFormatter.formatPrice(int.parse(cubit.paidAmountController.text.isNotEmpty ? cubit.paidAmountController.text : "0"))}",
                          true),
                      if (cubit.financeamountController.text != "0")
                        _buildAmountPaidRow(
                            "Finance Cost",
                            "- ₹${PriceFormatter.formatPrice(int.parse(cubit.financeamountController.text))}",
                            true),
                      const Divider(thickness: 1.5),
                      _buildAmountPaidRow(
                          "Due Amount",
                          "₹${PriceFormatter.formatPrice(cubit.dueamount(cubit.calculateTotalAmount(state, cubit), int.parse(cubit.paidAmountController.text.isNotEmpty ? cubit.paidAmountController.text : "0"), int.parse(cubit.financeamountController.text.isNotEmpty ? cubit.financeamountController.text : "0")))}",
                          false),
                      const Divider(thickness: 1.5),

                      const SizedBox(height: 40),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 30),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            cubit.addSalesEntry(context,
                                cubit.calculateTotalAmount(state, cubit));
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
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(limit),
              ],
              controller: controller,
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

  // return Container(
  //   color: Colors.white,
  //   child: Container(
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(color: Colors.grey.withOpacity(0.3)),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.2),
  //           blurRadius: 3,
  //           offset: const Offset(0, 3),
  //         ),
  //       ],
  //     ),
  //     margin: const EdgeInsets.fromLTRB(10.0, 0, 10, 10),
  //     child: SingleChildScrollView(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           const SizedBox(height: 8),
  //           Container(
  //             margin: const EdgeInsets.symmetric(
  //                 horizontal: 10, vertical: 5),
  //             child: const Text(
  //               "Tractor Details",
  //               style: TextStyle(
  //                   fontSize: 14, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           const Divider(thickness: 1.5),
  //           _buildDetailRow(
  //               "Tractor Model",
  //               state.getSalesDetailsByIDModel.data?.tractor
  //                       ?.modelName ??
  //                   "Not Available"),

  //           _buildDetailRow("Price",
  //               "₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.paidAmount ?? 0)} "),
  //           _buildDetailRow(
  //               "Fuel Type",
  //               state.getSalesDetailsByIDModel.data?.tractor
  //                       ?.fuelType ??
  //                   "Not Available"),
  //           _buildDetailRow(
  //               "Fuel Capacity",
  //               state.getSalesDetailsByIDModel.data?.tractor
  //                       ?.fuelCapacity ??
  //                   "Not Available"),
  //           _buildDetailRow(
  //               "Engine Capacity",
  //               state.getSalesDetailsByIDModel.data?.tractor
  //                       ?.engineCapacity ??
  //                   "Not Available"),
  //           _buildDetailRow(
  //               "Engine Make And Type",
  //               state.getSalesDetailsByIDModel.data?.tractor
  //                       ?.engineMakeAndType ??
  //                   "Not Available"),
  //           _buildDetailRow(
  //               "Cooling System",
  //               state.getSalesDetailsByIDModel.data?.tractor
  //                       ?.coolingSystem ??
  //                   "Not Available"),
  //           _buildDetailRow(
  //             "Number Of Cylinders",
  //             state.getSalesDetailsByIDModel.data?.tractor
  //                     ?.numberOfCylinders ??
  //                 "Not Available",
  //           ),
  //           _buildDetailRow(
  //               "Horse power",
  //               state.getSalesDetailsByIDModel.data?.tractor
  //                       ?.horsepower ??
  //                   "Not Available"),

  //           const SizedBox(
  //             height: 20,
  //           ),
  //           const Divider(thickness: 1.5),
  //           Container(
  //             margin: const EdgeInsets.symmetric(
  //                 horizontal: 10, vertical: 5),
  //             child: const Text(
  //               "Customer Details",
  //               style: TextStyle(
  //                   fontSize: 14, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           const Divider(thickness: 1.5),
  //           _buildDetailRow(
  //               "Name",
  //               state.getSalesDetailsByIDModel.data
  //                       ?.customerName ??
  //                   "Not Available"),
  //           // _buildDetailRow(
  //           //     "Email", "ananyasrivastava9827@gmail.com"),
  //           _buildDetailRow(
  //               "contact",
  //               state.getSalesDetailsByIDModel.data
  //                       ?.customerContact ??
  //                   "Not Available"),
  //           _buildDetailRow("Address", "Noida"),
  //           const SizedBox(
  //             height: 20,
  //           ),
  //           const Divider(thickness: 1.5),
  //           Container(
  //             margin: const EdgeInsets.symmetric(
  //                 horizontal: 10, vertical: 5),
  //             child: const Text(
  //               "Registration Details",
  //               style: TextStyle(
  //                   fontSize: 14, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           const Divider(thickness: 1.5),
  //           _buildDetailRow(
  //               "Registration Type",
  //               state.getSalesDetailsByIDModel.data
  //                       ?.registration?.registrationType ??
  //                   "Not Available"),
  //           _buildDetailRow("Registration Cost",
  //               "₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.registration?.registrationCost ?? 0)} "),

  //           const SizedBox(
  //             height: 20,
  //           ),
  //           const Divider(thickness: 1.5),
  //           Container(
  //             margin: const EdgeInsets.symmetric(
  //                 horizontal: 10, vertical: 5),
  //             child: const Text(
  //               "Implements Details",
  //               style: TextStyle(
  //                   fontSize: 14, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           const Divider(thickness: 1.5),
  //           for (int i = 0;
  //               i <
  //                   (state.getSalesDetailsByIDModel.data
  //                           ?.equipments?.length ??
  //                       0);
  //               i++)
  //             _buildDetailRow(
  //                 state.getSalesDetailsByIDModel.data
  //                         ?.equipments?[i].modelName ??
  //                     "Not Available",
  //                 "₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.equipments?[i].price ?? 0)} "),
  //           const SizedBox(
  //             height: 20,
  //           ),
  //           const Divider(thickness: 1.5),
  //           Container(
  //             margin: const EdgeInsets.symmetric(
  //                 horizontal: 10, vertical: 5),
  //             child: const Text(
  //               "Insurance Details",
  //               style: TextStyle(
  //                   fontSize: 14, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           const Divider(thickness: 1.5),
  //           _buildDetailRow(
  //               "Insurance Provider",
  //               state.getSalesDetailsByIDModel.data?.insurance
  //                       ?.insuranceProvider ??
  //                   "Not Available"),
  //           //_buildDetailRow("Policy Number", "897678899"),
  //           _buildDetailRow("Insurance Cost",
  //               "₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.insurance?.insuranceCost ?? 0)} "),
  //           const SizedBox(
  //             height: 20,
  //           ),
  //           const Divider(thickness: 1.5),

  //           Container(
  //             margin: const EdgeInsets.symmetric(
  //                 horizontal: 10, vertical: 5),
  //             child: const Text(
  //               "Finance  Details",
  //               style: TextStyle(
  //                   fontSize: 14, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           const Divider(thickness: 1.5),
  //           _buildDetailRow("Finance Amount",
  //               "₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.finance?.amount ?? 0)} "),
  //           _buildDetailRow(
  //               "Finance Tenure",
  //               state.getSalesDetailsByIDModel.data?.finance
  //                       ?.tenure ??
  //                   "Not Available"),
  //           const SizedBox(
  //             height: 20,
  //           ),
  //           const Divider(thickness: 1.5),
  //           Container(
  //             margin: const EdgeInsets.symmetric(
  //                 horizontal: 10, vertical: 5),
  //             child: const Text(
  //               "Payment Method",
  //               style: TextStyle(
  //                   fontSize: 14, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           const Divider(thickness: 1.5),
  //           _buildDetailRow(
  //               "Payment Method",
  //               state.getSalesDetailsByIDModel.data
  //                       ?.paymentMethod ??
  //                   "Not Available"),

  //           const SizedBox(
  //             height: 20,
  //           ),
  //           const Divider(thickness: 1.5),
  //           Container(
  //             margin: const EdgeInsets.symmetric(
  //                 horizontal: 10, vertical: 5),
  //             child: const Text(
  //               "Pricing  Details",
  //               style: TextStyle(
  //                   fontSize: 14, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           const Divider(thickness: 1.5),
  //           _buildDetailRow("Tractor Price",
  //               "₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.tractorBasePrice ?? 0)}"),
  //           _buildDetailRow("Registration Cost",
  //               "₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.registration?.registrationCost ?? 0)} "),
  //           for (int i = 0;
  //               i <
  //                   (state.getSalesDetailsByIDModel.data
  //                           ?.equipments?.length ??
  //                       0);
  //               i++)
  //             _buildDetailRow(
  //                 state.getSalesDetailsByIDModel.data
  //                         ?.equipments?[i].modelName ??
  //                     "Not Available",
  //                 "₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.equipments?[i].price ?? 0)} "),

  //           _buildDetailRow("Insurance Cost",
  //               "₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.insurance?.insuranceCost ?? 0)} "),
  //           const Divider(thickness: 1.5),
  //           _buildDetailRow("Total Amount",
  //               "₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.totalAmount ?? 0)} "),
  //           _buildPriceRowBold(
  //               "Paid Amount",
  //               "- ₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.paidAmount ?? 0)} ",
  //               false),
  //           const Divider(thickness: 1.5),
  //           _buildPriceRowBold(
  //               "Due Amount",
  //               "₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.dueAmount ?? 0)} ",
  //               true),
  //           button == true
  //               ? Container(
  //                   width: double.infinity,
  //                   margin: const EdgeInsets.symmetric(
  //                       vertical: 30),
  //                   padding: const EdgeInsets.symmetric(
  //                       horizontal: 10),
  //                   child: ElevatedButton(
  //                     onPressed: () {
  //                       Navigator.pushReplacementNamed(
  //                           context, Routes.saleHome);
  //                     },
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: Colors.green[500],
  //                       padding: const EdgeInsets.symmetric(
  //                           vertical: 12),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius:
  //                             BorderRadius.circular(8.0),
  //                       ),
  //                     ),
  //                     child: const Text(
  //                       'Submit',
  //                       style: TextStyle(
  //                         color: Colors.white,
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ),
  //                 )
  //               : const SizedBox(height: 20),
  //         ],
  //       ),
  //     ),
  //   ),
  // );
}
