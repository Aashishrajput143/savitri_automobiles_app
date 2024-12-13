import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:savitri_automobiles_admin/modules/cubit/add_sale_entry_cubit/add_sale_cubit.dart';
import 'package:savitri_automobiles_admin/modules/cubit/add_sale_entry_cubit/add_sale_state.dart';

import '../../../routes/routes.dart';

class SalesEntryScreen extends StatelessWidget {
  const SalesEntryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddSaleCubit(),
      child: Scaffold(
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
        body: BlocListener<AddSaleCubit, AddSaleState>(
          listener: (context, state) {
            if (state is AddSaleSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is AddSaleError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            height: MediaQuery.of(context).size.height * 0.9,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<AddSaleCubit, AddSaleState>(
                    builder: (context, state) {
                      final cubit = context.read<AddSaleCubit>();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Select Tractor Model",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          DropdownSearch<String>(
                            key: cubit.dropDownKey,
                            selectedItem: "Select a Tractor",
                            items: (value, c) => context
                                .read<AddSaleCubit>()
                                .getTractors()
                                .map((tractor) {
                              return tractor['model'] ?? 'Unknown';
                            }).toList(),
                            decoratorProps: const DropDownDecoratorProps(
                              decoration: InputDecoration(
                                labelText: 'Select Tractor Model',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            popupProps: const PopupProps.menu(
                              fit: FlexFit.loose,
                              constraints: BoxConstraints(),
                              menuProps: MenuProps(
                                backgroundColor: Colors.white,
                              ),
                            ),
                            onChanged: (value) {
                              print("Selected tractor model: $value");
                              context.read<AddSaleCubit>().selectTractor(value);
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
                            _buildDetailRow(
                                "Name", state.selectedTractor?["name"] ?? ""),
                            _buildDetailRow(
                                "Model", state.selectedTractor?["model"] ?? ""),
                            _buildDetailRow("Number",
                                state.selectedTractor?["number"] ?? ""),
                            _buildDetailRow(
                                "Price", state.selectedTractor?["price"] ?? ""),
                            _buildDetailRow("PTO HP",
                                state.selectedTractor?["ptoHP"] ?? ""),
                            _buildDetailRow("Gear Box",
                                state.selectedTractor?["gearBox"] ?? ""),
                          ],
                          const SizedBox(height: 40),

                          // Customer Details
                          const Text(
                            "Customer Details",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const Divider(thickness: 1.5),
                          const SizedBox(height: 8),
                          _buildDetailRowWithTextField(
                              "Name", cubit.nameController),
                          _buildDetailRowWithTextField(
                              "Contact", cubit.contactController),
                          _buildDetailRowWithTextField(
                              "Email", cubit.emailController),
                          _buildDetailRowWithTextField(
                              "Address", cubit.addressController),
                          const SizedBox(height: 40),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: CheckboxListTile(
                              title: const Text("Include Exchange Item"),
                              value: state.isChecked,
                              onChanged: (value) {
                                cubit.toggleExchangeItem(value ?? false);
                              },
                            ),
                          ),

                          // Exchange Item Details
                          if (state.isChecked) ...[
                            const SizedBox(height: 40),
                            const Text(
                              "Exchange Item Details",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const Divider(thickness: 1.5),
                            const SizedBox(height: 8),
                            _buildDetailRowWithTextField(
                                "Name", cubit.exchangeItemController),
                            _buildDetailRowWithTextField(
                                "Model", cubit.exchangeItemController),
                            _buildDetailRowWithTextField(
                                "Brand", cubit.exchangeItemController),
                            _buildDetailRowWithTextField(
                                "Vehicle Age", cubit.exchangeItemController),
                            _buildDetailRowWithTextField(
                                "Vehicle Type", cubit.exchangeItemController),
                            _buildDetailRowWithTextField(
                                "Vehicle Amount", cubit.exchangeItemController),
                          ],
                          const SizedBox(height: 40),
                          const Text(
                            "Registration Details",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                              print("Selected tractor model: $value");
                              context
                                  .read<AddSaleCubit>()
                                  .selectRegistrationType(value);
                            },
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            maxLength: 5,
                            controller: cubit.registrationCostController,
                            decoration: const InputDecoration(
                              label: Text("Registration cost"),
                              counterText: "",
                              border: OutlineInputBorder(),
                              hintText: "Enter Registration Cost",
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            keyboardType: TextInputType.text,
                            controller: cubit.registrationNumberController,
                            decoration: const InputDecoration(
                              label: Text("Registration Number"),
                              counterText: "",
                              border: OutlineInputBorder(),
                              hintText: "Enter Registration Number",
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

                          MultiSelectDialogField(
                            items: context
                                .read<AddSaleCubit>()
                                .state
                                .availableEquipments
                                .map((equipment) {
                              final price = context
                                      .read<AddSaleCubit>()
                                      .state
                                      .equipmentPrices[equipment] ??
                                  0.0;
                              return MultiSelectItem<String>(
                                equipment,
                                "$equipment  -  ₹$price",
                              );
                            }).toList(),
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
                            initialValue: context
                                .read<AddSaleCubit>()
                                .state
                                .selectedEquipments,
                            onConfirm: (results) {
                              context
                                  .read<AddSaleCubit>()
                                  .updateSelectedEquipments(
                                      results.cast<String>());
                            },
                            chipDisplay: MultiSelectChipDisplay(
                              items: context
                                  .read<AddSaleCubit>()
                                  .state
                                  .selectedEquipments
                                  .map((name) {
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
                              chipWidth:
                                  MediaQuery.of(context).size.width * 0.32,
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
                          _buildDetailRowWithTextField("Insurance Provider",
                              cubit.insuranceProviderController),
                          _buildDetailRowWithTextField(
                              "Policy Number", cubit.policyNumberController),
                          _buildDetailRowWithTextField(
                              "Insurance Cost", cubit.insuranceCostController),

                          const SizedBox(height: 40),

                          const Text(
                            "Discount Details",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const Divider(thickness: 1.5),
                          const SizedBox(height: 8),
                          DropdownSearch<String>(
                            items: (filter, infiniteScrollProps) =>
                                ["In Percent(%)", "In Value"],
                            selectedItem: state.discountType,
                            onChanged: (value) {
                              cubit.selectDiscountType(value);
                            },
                            decoratorProps: const DropDownDecoratorProps(
                              decoration: InputDecoration(
                                labelText: 'Discount:',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            popupProps: const PopupProps.menu(
                              fit: FlexFit.loose,
                              constraints: BoxConstraints(),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            maxLength: 5,
                            controller: cubit.discountController,
                            decoration: const InputDecoration(
                              label: Text("Discount"),
                              counterText: "",
                              border: OutlineInputBorder(),
                              hintText: "Enter Discount in values",
                            ),
                          ),

                          const SizedBox(height: 40),

                          const Text(
                            "Total Payment",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const Divider(thickness: 1.5),
                          const SizedBox(height: 8),
                          _buildAmountRow("Tractor Price", "₹15,00,000", false),
                          _buildAmountRow("Registration Cost", "₹8,976", false),
                          _buildAmountRow(
                              "Swaraj Rotary Cost", "₹90,000", false),
                          _buildAmountRow(
                              "Swaraj Harrow Cost", "₹75,000", false),
                          _buildAmountRow(
                              "Swaraj Pillow Cost", "₹65,000", false),
                          _buildAmountRow("Insurance Cost", "₹35,259", false),
                          const Divider(thickness: 1.5),
                          _buildAmountRow("Total Amount", "₹32,50,000", true),
                          const Divider(thickness: 1.5),

                          const SizedBox(height: 40),

                          const Text(
                            "Payment Details",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const Divider(thickness: 1.5),
                          const SizedBox(height: 8),
                          _buildDetailRowWithTextField(
                              "Payment Method", cubit.paymentMethodController),
                          _buildDetailRowWithTextField(
                              "Paid Amount", cubit.paidAmountController),
                          _buildDetailRowWithTextField(
                              "Due Amount", cubit.dueAmountController),
                          _buildDetailRowWithTextField(
                              "Due Interest", cubit.loanInterestController),

                          const SizedBox(height: 40),

                          const Text(
                            "Payment Summary",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const Divider(thickness: 1.5),
                          const SizedBox(height: 8),
                          _buildAmountRow("Total Amount", "₹32,50,000", true),
                          _buildAmountPaidRow(
                              "Paid Amount", "- ₹12,50,000", true),
                          const Divider(thickness: 1.5),
                          _buildAmountPaidRow(
                              "Due Amount", "- ₹20,00,000", false),
                          const Divider(thickness: 1.5),

                          const SizedBox(height: 40),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                cubit.addSale();
                                Navigator.pushNamed(context, Routes.review,
                                    arguments: true);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[500],
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
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
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
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
            width: 200,
            child: Text(
              overflow: TextOverflow.clip,
              value,
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
      String label, TextEditingController controller) {
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter value",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
