import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Serviceman_cubit/add_service_entry_cubit/add_service_cubit.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Serviceman_cubit/add_service_entry_cubit/add_service_state.dart';
import 'package:savitri_automobiles_admin/resources/formatter.dart';

import '../../../routes/routes.dart';

class ServiceEntryScreen extends StatelessWidget {
  const ServiceEntryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddServiceCubit(),
      child: BlocConsumer<AddServiceCubit, AddServiceState>(
        builder: (context, state) => Scaffold(
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
          body: BlocBuilder<AddServiceCubit, AddServiceState>(
            builder: (context, state) {
              final cubit = context.read<AddServiceCubit>();
              if (state is AddServicesuccessLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AddServiceLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16.0),
                height: MediaQuery.of(context).size.height * 0.9,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select Tractor Model",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                        _buildDetailRow(
                            "Fuel Capacity",
                            state.selectedTractor?.fuelCapacity ??
                                "Not Available"),
                        _buildDetailRow("fuelType",
                            state.selectedTractor?.fuelType ?? "Not Available"),
                        _buildDetailRow("features",
                            state.selectedTractor?.features ?? "Not Available"),
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
                          "Name", cubit.nameController, "Enter Name", 20),
                      _buildDetailAmountRowWithTextField("Contact",
                          cubit.contactController, "Enter Contact Number", 10),
                      _buildDetailRowWithTextField("Address",
                          cubit.addressController, "Enter Address", 50),
                      const SizedBox(height: 20),
                      const Text(
                        "Service Details",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(thickness: 1.5),
                      const SizedBox(height: 10),
                      DropdownSearch<String>(
                        key: cubit.dropDownKeyservicetype,
                        selectedItem: "Select Service Type",
                        items: (value, c) => [
                          "Regular Maintenance",
                          "Engine Repair",
                          "Hydraulic Repair",
                          "Transmission Repair",
                          "Electrical Work",
                          "Oil Change",
                          "Tyre Replacement",
                          "General Checkup",
                          "Repair",
                          "Inspection",
                          "Emergency Service",
                          "Others"
                        ],
                        decoratorProps: const DropDownDecoratorProps(
                          decoration: InputDecoration(
                            labelText: 'Select Service Type',
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
                          print("Selected Service Type: $value");
                          cubit.selectservicetype(value);
                          print(cubit.state.selectedservicetype);
                        },
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(8),
                        ],
                        controller: cubit.servicechargeController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          print(value);
                          cubit.totalserviceamount(int.tryParse(value) ?? 0);
                          print(state.servicechargeamount);
                        },
                        maxLength: 8,
                        decoration: const InputDecoration(
                          label: Text("Service Charge"),
                          counterText: "",
                          border: OutlineInputBorder(),
                          hintText: "Enter Service Charge",
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        inputFormatters: [
                          NoLeadingSpaceFormatter(),
                          RemoveTrailingPeriodsFormatter(),
                          SpecialCharacterValidator(),
                          EmojiInputFormatter(),
                          LengthLimitingTextInputFormatter(255)
                        ],
                        controller: cubit.servicedescriptionController,
                        decoration: const InputDecoration(
                          label: Text("Service Description"),
                          counterText: "",
                          border: OutlineInputBorder(),
                          hintText: "Enter Service Description",
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Spare Parts Details",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(thickness: 1.5),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: DropdownButtonFormField<String>(
                              dropdownColor: Colors.white,
                              value: cubit.selectedPart,
                              hint: const Text('Select Spare Part'),
                              items: state.spareparts?.data?.docs?.map((part) {
                                    return DropdownMenuItem(
                                      value:
                                          "${part.sId}|${part.partName}|${part.price}",
                                      child: Container(
                                        width: 225,
                                        alignment: Alignment.topLeft,
                                        child: Text(part.partName ?? ""),
                                      ),
                                    );
                                  }).toList() ??
                                  [],
                              onChanged: (value) {
                                cubit.selectedPart = value;
                              },
                              menuMaxHeight: 300,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.only(left: 8, right: 8),
                                constraints: BoxConstraints(
                                  maxHeight: 225,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 13),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              style: const TextStyle(height: 1),
                              keyboardType: TextInputType.number,
                              focusNode: cubit.focusNode,
                              controller: cubit.qtyController,
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
                            if (cubit.selectedPart != null) {
                              // Split the selectedPart string to get ID and name
                              final selectedParts =
                                  cubit.selectedPart!.split('|');
                              final partId = selectedParts[0];
                              final partName = selectedParts[1];
                              final partprice = selectedParts[2];

                              cubit.updateSparePart(
                                partId,
                                partName,
                                partprice,
                                cubit.qtyController.text.isEmpty
                                    ? "1"
                                    : cubit.qtyController.text,
                              );

                              cubit.selectedPart = null;
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Please Select Sparepart")),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[500],
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
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
                      state.selectedspareparts != null
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.selectedspareparts!.length,
                                itemBuilder: (context, index) {
                                  final part = state.selectedspareparts![index];
                                  return Card(
                                    color: Colors.white,
                                    elevation: 2,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Text(
                                              part['name']!,
                                              style: const TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              "Qty : ${part['quantity']!}",
                                              style: const TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 15,
                                            ),
                                            onPressed: () {
                                              cubit.removeSparePart(
                                                  part['name']!);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 20),
                      const Text(
                        "Oil Details",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(thickness: 1.5),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: DropdownButtonFormField<String>(
                              value: cubit.selectedoil,
                              dropdownColor: Colors.white,
                              hint: const Text('Select Oil'),
                              items: state.oilsnames?.data?.docs?.map((oil) {
                                    return DropdownMenuItem(
                                      value:
                                          "${oil.sId}|${oil.oilName}|${oil.price}",
                                      child: Container(
                                        width: 225,
                                        alignment: Alignment.centerLeft,
                                        child: Text(oil.oilName ?? ""),
                                      ),
                                    );
                                  }).toList() ??
                                  [],
                              onChanged: (value) {
                                cubit.selectedoil = value;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.only(left: 8, right: 8),
                                constraints: BoxConstraints(
                                  maxHeight: 225,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 13),
                          Expanded(
                            child: TextField(
                              style: const TextStyle(height: 1),
                              keyboardType: TextInputType.number,
                              focusNode: cubit.focusNodeoil,
                              controller: cubit.qtyoilController,
                              decoration: const InputDecoration(
                                labelText: 'ltr',
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
                            if (cubit.selectedoil != null) {
                              final selectedoil = cubit.selectedoil!.split('|');
                              final oilId = selectedoil[0];
                              final oilName = selectedoil[1];
                              final oilprice = selectedoil[2];

                              cubit.updateoil(
                                oilId,
                                oilName,
                                oilprice,
                                cubit.qtyoilController.text.isEmpty
                                    ? "1"
                                    : cubit.qtyoilController.text,
                              );
                              cubit.selectedoil = null;
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Please Select Oil")),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[500],
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
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
                      state.selectedoils != null
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.selectedoils!.length,
                                itemBuilder: (context, index) {
                                  final oil = state.selectedoils![index];
                                  return Card(
                                    color: Colors.white,
                                    elevation: 2,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Text(
                                              oil['name']!,
                                              style: const TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              "Litres : ${oil['quantity']!}",
                                              style: const TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 15,
                                            ),
                                            onPressed: () {
                                              cubit.removeoil(oil['name']!);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 10),
                      if (state.servicechargeamount != 0 ||
                          state.selectedoils!.isNotEmpty ||
                          state.selectedspareparts!.isNotEmpty) ...[
                        const Text(
                          "Total Payment",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Divider(thickness: 1.5),
                        const SizedBox(height: 8),
                        _buildAmountRow(
                            "Service Charge",
                            "₹${PriceFormatter.formatPrice(state.servicechargeamount ?? 0)} ",
                            false),
                        for (int i = 0;
                            i < (state.selectedspareparts?.length ?? 0);
                            i++)
                          _buildAmountRow(
                              state.selectedspareparts?[i]['name'] ??
                                  "Not Available",
                              "+ ₹${PriceFormatter.formatPrice(int.tryParse(state.selectedspareparts?[i]['price'] ?? "0") ?? 0)} X ${state.selectedspareparts?[i]['quantity'] ?? "0"}",
                              false),
                        for (int i = 0;
                            i < (state.selectedoils?.length ?? 0);
                            i++)
                          _buildAmountRow(
                              state.selectedoils?[i]['name'] ?? "Not Available",
                              "+ ₹${PriceFormatter.formatPrice(int.tryParse(state.selectedoils?[i]['price'] ?? "0") ?? 0)} X ${state.selectedoils?[i]['quantity'] ?? "0"}",
                              false),
                        const Divider(thickness: 1.5),
                        _buildAmountRow(
                            "Total Amount",
                            "₹${PriceFormatter.formatPrice((state.totalsparepartsprice ?? 0.0) + (state.totaloilprice ?? 0.0) + (state.servicechargeamount ?? 0.0))} ",
                            true),
                        const Divider(thickness: 1.5),
                      ],
                      const SizedBox(height: 20),
                      const Text(
                        "Payment Details",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(thickness: 1.5),
                      const SizedBox(height: 8),
                      DropdownSearch<String>(
                        key: cubit.dropDownKeypaymentmethod,
                        selectedItem: "Select Payment Method",
                        items: (value, c) => [
                          "Cash",
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
                        decoration: const InputDecoration(
                          label: Text("Paid Amount"),
                          counterText: "",
                          border: OutlineInputBorder(),
                          hintText: "Enter Payment Amount",
                        ),
                      ),
                      const SizedBox(height: 50),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            if (state.selectedTractormodel != null &&
                                state.servicechargeamount != 0.0 &&
                                state.selectedservicetype != null &&
                                cubit.nameController.text.isNotEmpty &&
                                cubit.contactController.text.isNotEmpty &&
                                cubit.paidAmountController.text.isNotEmpty &&
                                state.paymentmethod != null) {
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
                                      content:
                                          Text("Contact Should be 10 digits")),
                                );
                              } else {
                                cubit.addServiceEntry(context);
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Please fill all the details")),
                              );
                            }
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
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        listener: (BuildContext context, AddServiceState state) {
          if (state is AddServiceSuccess) {
            Navigator.pushReplacementNamed(context, Routes.serviceHome);
          }
          if (state is AddServiceError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? "")),
            );
          }
        },
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
}
