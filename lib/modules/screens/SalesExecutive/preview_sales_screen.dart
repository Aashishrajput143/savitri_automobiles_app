import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Salesman_cubit/preview_sales_cubit/preview_cubit.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Salesman_cubit/preview_sales_cubit/preview_state.dart';
import 'package:savitri_automobiles_admin/resources/formatter.dart';

class PreviewSalesScreen extends StatelessWidget {
  const PreviewSalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? id = ModalRoute.of(context)?.settings.arguments as String?;
    return BlocProvider(
      create: (_) => PreviewCubit(id ?? ""),
      child: const PreviewPage(),
    );
  }
}

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? id = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Sales Preview Screen'),
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
            create: (_) => PreviewCubit(id ?? ""),
            child: BlocBuilder<PreviewCubit, PreviewState>(
              builder: (context, state) {
                if (state is PreviewLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is PreviewError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                } else if (state is PreviewSuccess) {
                  print("000000");
                  return Container(
                    color: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 3,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.fromLTRB(10.0, 0, 10, 10),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: const Text(
                                "Tractor Details",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Divider(thickness: 1.5),
                            _buildDetailRow(
                                "Tractor Model",
                                state.getSalesDetailsByIDModel.data?.tractor
                                        ?.modelName ??
                                    "Not Available"),

                            _buildDetailRow("Price",
                                "₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.tractorBasePrice ?? 0)} "),
                            _buildDetailRow(
                                "Fuel Type",
                                state.getSalesDetailsByIDModel.data?.tractor
                                        ?.fuelType ??
                                    "Not Available"),
                            _buildDetailRow(
                                "Fuel Capacity",
                                state.getSalesDetailsByIDModel.data?.tractor
                                            ?.fuelCapacity ==
                                        null
                                    ? "Not Available"
                                    : "${state.getSalesDetailsByIDModel.data?.tractor?.fuelCapacity} Litres"),
                            _buildDetailRow(
                                "Engine Capacity",
                                state.getSalesDetailsByIDModel.data?.tractor
                                        ?.engineCapacity ??
                                    "Not Available"),
                            _buildDetailRow(
                                "Engine Make And Type",
                                state.getSalesDetailsByIDModel.data?.tractor
                                        ?.engineMakeAndType ??
                                    "Not Available"),
                            _buildDetailRow(
                                "Cooling System",
                                state.getSalesDetailsByIDModel.data?.tractor
                                        ?.coolingSystem ??
                                    "Not Available"),
                            _buildDetailRow(
                              "Number Of Cylinders",
                              state.getSalesDetailsByIDModel.data?.tractor
                                          ?.numberOfCylinders ==
                                      null
                                  ? "Not Available"
                                  : state.getSalesDetailsByIDModel.data?.tractor
                                          ?.numberOfCylinders
                                          .toString() ??
                                      "",
                            ),
                            _buildDetailRow(
                                "Horse power",
                                state.getSalesDetailsByIDModel.data?.tractor
                                            ?.horsepower !=
                                        null
                                    ? state.getSalesDetailsByIDModel.data
                                            ?.tractor?.horsepower
                                            .toString() ??
                                        ""
                                    : "Not Available"),

                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(thickness: 1.5),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: const Text(
                                "Customer Details",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Divider(thickness: 1.5),
                            _buildDetailRow(
                                "Name",
                                state.getSalesDetailsByIDModel.data
                                        ?.customerName ??
                                    "Not Available"),
                            // _buildDetailRow(
                            //     "Email", "ananyasrivastava9827@gmail.com"),
                            _buildDetailRow(
                                "contact",
                                state.getSalesDetailsByIDModel.data
                                        ?.customerContact ??
                                    "Not Available"),
                            _buildDetailRow("Address", "Noida"),
                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(thickness: 1.5),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: const Text(
                                "Registration Details",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Divider(thickness: 1.5),
                            _buildDetailRow(
                                "Registration Type",
                                state.getSalesDetailsByIDModel.data
                                        ?.registration?.registrationType ??
                                    "Not Available"),
                            _buildDetailRow("Registration Cost",
                                "₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.registration?.registrationCost ?? 0)} "),

                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(thickness: 1.5),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: const Text(
                                "Implements Details",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Divider(thickness: 1.5),
                            for (int i = 0;
                                i <
                                    (state.getSalesDetailsByIDModel.data
                                            ?.equipments?.length ??
                                        0);
                                i++)
                              _buildDetailRow(
                                  state.getSalesDetailsByIDModel.data
                                          ?.equipments?[i].modelName ??
                                      "Not Available",
                                  "₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.equipments?[i].price ?? 0)} "),
                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(thickness: 1.5),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: const Text(
                                "Insurance Details",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Divider(thickness: 1.5),
                            _buildDetailRow(
                                "Insurance Provider",
                                state.getSalesDetailsByIDModel.data?.insurance
                                        ?.insuranceProvider ??
                                    "Not Available"),
                            //_buildDetailRow("Policy Number", "897678899"),
                            _buildDetailRow("Insurance Cost",
                                "₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.insurance?.insuranceCost ?? 0)} "),
                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(thickness: 1.5),

                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: const Text(
                                "Finance  Details",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Divider(thickness: 1.5),
                            _buildDetailRow("Finance Amount",
                                "₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.finance?.amount ?? 0)} "),
                            _buildDetailRow(
                                "Finance Tenure",
                                state.getSalesDetailsByIDModel.data?.finance
                                        ?.tenure ??
                                    "Not Available"),
                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(thickness: 1.5),

                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: const Text(
                                "Transportation  Details",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Divider(thickness: 1.5),
                            _buildDetailRow("Transportation Cost",
                                "₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.transportationCost ?? 0)} "),
                            const SizedBox(
                              height: 20,
                            ),

                            const Divider(thickness: 1.5),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: const Text(
                                "Payment Method",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Divider(thickness: 1.5),
                            _buildDetailRow(
                                "Payment Method",
                                state.getSalesDetailsByIDModel.data
                                        ?.paymentMethod ??
                                    "Not Available"),

                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(thickness: 1.5),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: const Text(
                                "Pricing  Details",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Divider(thickness: 1.5),
                            _buildDetailRow("Tractor Price",
                                "₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.tractorBasePrice ?? 0)}"),
                            _buildDetailRow("Registration Cost",
                                "₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.registration?.registrationCost ?? 0)} "),
                            for (int i = 0;
                                i <
                                    (state.getSalesDetailsByIDModel.data
                                            ?.equipments?.length ??
                                        0);
                                i++)
                              _buildDetailRow(
                                  state.getSalesDetailsByIDModel.data
                                          ?.equipments?[i].modelName ??
                                      "Not Available",
                                  "₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.equipments?[i].price ?? 0)} "),

                            _buildDetailRow("Insurance Cost",
                                "₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.insurance?.insuranceCost ?? 0)} "),
                            const Divider(thickness: 1.5),
                            _buildDetailRow("Total Amount",
                                "₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.totalAmount ?? 0)} "),
                            const Divider(thickness: 1.5),
                            _buildPriceRowBold(
                                "Paid Amount",
                                "- ₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.paidAmount ?? 0)} ",
                                false),
                            _buildPriceRowBold(
                                "Finance Amount",
                                "- ₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.finance?.amount ?? 0)} ",
                                false),
                            const Divider(thickness: 1.5),
                            _buildPriceRowBold(
                                "Due Amount",
                                "₹${PriceFormatter.formatPrice(state.getSalesDetailsByIDModel.data?.dueAmount ?? 0)} ",
                                true),
                            const SizedBox(
                              height: 16,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return const Center(child: Text("No tractors available."));
              },
            )));
  }

  Widget _buildDetailRow(
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Flexible(
            child: SizedBox(
              width: 120,
              child: Text(
                overflow: TextOverflow.clip,
                value,
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

  Widget _buildPriceRowBold(String label, String value, bool due) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Flexible(
            child: SizedBox(
              width: 120,
              child: Text(
                overflow: TextOverflow.clip,
                value,
                style: TextStyle(
                    fontSize: 16, color: due ? Colors.red : Colors.green),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
