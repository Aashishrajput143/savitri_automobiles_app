import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Serviceman_cubit/add_service_entry_cubit/add_service_cubit.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Serviceman_cubit/add_service_entry_cubit/add_service_state.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Serviceman_cubit/add_service_entry_cubit/add_spareparts_cubit.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Serviceman_cubit/add_service_entry_cubit/add_spareparts_state.dart';
import 'package:savitri_automobiles_admin/resources/formatter.dart';

import '../../../routes/routes.dart';

class ServiceEntryScreen extends StatelessWidget {
  const ServiceEntryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddServiceCubit(),
      child: BlocProvider(
        create: (_) => AddSpareCubit(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text("Add Service Entry"),
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
          body: BlocListener<AddServiceCubit, AddServiceState>(
            listener: (context, state) {
              if (state is AddServiceSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              } else if (state is AddServiceError) {
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
                    BlocBuilder<AddServiceCubit, AddServiceState>(
                      builder: (context, state) {
                        final cubit = context.read<AddServiceCubit>();

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
                                  .read<AddServiceCubit>()
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
                                context
                                    .read<AddServiceCubit>()
                                    .selectTractor(value);
                              },
                            ),
                            const SizedBox(height: 20),
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
                              _buildDetailRow("Model",
                                  state.selectedTractor?["model"] ?? ""),
                              _buildDetailRow("Number",
                                  state.selectedTractor?["number"] ?? ""),
                              _buildDetailRow("Price",
                                  state.selectedTractor?["price"] ?? ""),
                              _buildDetailRow("PTO HP",
                                  state.selectedTractor?["ptoHP"] ?? ""),
                              _buildDetailRow("Gear Box",
                                  state.selectedTractor?["gearBox"] ?? ""),
                            ],
                            const SizedBox(height: 20),
                            const Text(
                              "Customer Details",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const Divider(thickness: 1.5),
                            const SizedBox(height: 8),
                            _buildDetailRowWithTextField(
                                "Name", cubit.nameController, "Enter Name"),
                            _buildDetailRowWithTextField(
                                "Contact",
                                cubit.contactController,
                                "Enter Contact Number"),
                            _buildDetailRowWithTextField("Address",
                                cubit.addressController, "Enter Address"),
                            const SizedBox(height: 40),
                            const Text(
                              "Spare Parts Details",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const Divider(thickness: 1.5),
                            const SizedBox(height: 16),
                            BlocBuilder<AddSpareCubit, AddSpareState>(
                              builder: (context, statespare) {
                                final sparecubit =
                                    context.read<AddSpareCubit>();
                                cubit.state.selectedspareparts =
                                    state.selectedspareparts;

                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child:
                                              DropdownButtonFormField<String>(
                                            value: sparecubit.selectedPart,
                                            hint:
                                                const Text('Select Spare Part'),
                                            items: statespare.spareparts
                                                .map((part) {
                                              return DropdownMenuItem(
                                                  value: part,
                                                  child: Text(part));
                                            }).toList(),
                                            onChanged: (value) {
                                              sparecubit.selectedPart = value;
                                            },
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 13),
                                        Expanded(
                                          flex: 1,
                                          child: TextField(
                                            style: const TextStyle(height: 1),
                                            keyboardType: TextInputType.number,
                                            focusNode: sparecubit.focusNode,
                                            controller:
                                                sparecubit.qtyController,
                                            decoration: const InputDecoration(
                                              labelText: 'Qty',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (sparecubit.selectedPart != null) {
                                            sparecubit.updateSparePart(
                                                sparecubit.selectedPart!,
                                                sparecubit.qtyController.text
                                                        .isEmpty
                                                    ? "1"
                                                    : sparecubit
                                                        .qtyController.text);

                                            sparecubit.selectedPart = null;
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green[500],
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        child: const Text(
                                          'Add',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    statespare.selectedspareparts != null
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: statespare
                                                .selectedspareparts!.length,
                                            itemBuilder: (context, index) {
                                              final part = statespare
                                                  .selectedspareparts![index];
                                              return Card(
                                                color: Colors.white,
                                                elevation: 2,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 5),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          part['name']!,
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          "Qty : ${part['quantity']!}",
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      IconButton(
                                                        icon: const Icon(
                                                            Icons.delete,
                                                            color: Colors.red),
                                                        onPressed: () {
                                                          sparecubit
                                                              .removeSparePart(
                                                                  part[
                                                                      'name']!);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : const SizedBox(
                                            height: 20,
                                          ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 30),
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
                              keyboardType:
                                  const TextInputType.numberWithOptions(
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
                            _buildAmountRow(
                                "Tractor Price", "₹15,00,000", false),
                            _buildAmountRow(
                                "Registration Cost", "₹8,976", false),
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
                                "Payment Method",
                                cubit.paymentMethodController,
                                "Enter Payment Method"),
                            _buildDetailRowWithTextField(
                                "Paid Amount",
                                cubit.paidAmountController,
                                "Enter Payment Amount"),
                            _buildDetailRowWithTextField("Due Amount",
                                cubit.dueAmountController, "Enter Due Amount"),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  cubit.addSale();

                                  Navigator.pushNamed(
                                      context, Routes.servicereview,
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
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(8),
                RangeInputFormatter(),
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
              inputFormatters: [
                NoLeadingSpaceFormatter(),
                RemoveTrailingPeriodsFormatter(),
                SpecialCharacterValidator(),
                EmojiInputFormatter(),
                LengthLimitingTextInputFormatter(50)
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
