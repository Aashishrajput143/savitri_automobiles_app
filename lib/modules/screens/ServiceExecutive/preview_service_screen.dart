import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Serviceman_cubit/preview_service_cubit/preview_cubit.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Serviceman_cubit/preview_service_cubit/preview_state.dart';
import 'package:savitri_automobiles_admin/resources/formatter.dart';

class PreviewServiceScreen extends StatelessWidget {
  const PreviewServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? id = ModalRoute.of(context)?.settings.arguments as String?;
    return BlocProvider(
      create: (_) => PreviewServiceCubit(id ?? ""),
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
        appBar: AppBar(
          title: const Text('Service Review Screen'),
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
            create: (_) => PreviewServiceCubit(id ?? ""),
            child: BlocBuilder<PreviewServiceCubit, PreviewServiceState>(
              builder: (context, state) {
                if (state is PreviewServiceLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PreviewServiceSuccess) {
                  if (state.getServiceDetailsByIDModel.data?.tractor?.modelName
                          ?.isEmpty ??
                      true) {
                    return const Center(child: Text("No Service available."));
                  } else {
                    return Container(
                      color: Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.3)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 3,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                  "Service Details",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Divider(thickness: 1.5),
                              _buildDetailRow(
                                  "Tractor Model",
                                  state.getServiceDetailsByIDModel.data?.tractor
                                          ?.modelName ??
                                      "Not Available"),
                              _buildDetailRow(
                                  "ServiceType",
                                  state.getServiceDetailsByIDModel.data
                                          ?.serviceType ??
                                      "Not Available"),
                              _buildDetailRow(
                                  "Service Description",
                                  state.getServiceDetailsByIDModel.data
                                          ?.serviceDescription ??
                                      "Not Available"),
                              _buildDetailRow("Service Charge",
                                  "₹${PriceFormatter.formatPrice(state.getServiceDetailsByIDModel.data?.serviceCost ?? 0)} "),
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Divider(thickness: 1.5),
                              _buildDetailRow(
                                  "Name",
                                  state.getServiceDetailsByIDModel.data
                                          ?.customerName ??
                                      "Not Available"),
                              _buildDetailRow(
                                  "contact",
                                  state.getServiceDetailsByIDModel.data
                                          ?.customerContact ??
                                      "Not Available"),
                              _buildDetailRow(
                                  "Address",
                                  state.getServiceDetailsByIDModel.data
                                          ?.customerAddress ??
                                      "Not Available"),
                              const SizedBox(
                                height: 20,
                              ),
                              const Divider(thickness: 1.5),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: const Text(
                                  "Spare Parts Details",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Divider(thickness: 1.5),
                              for (int i = 0;
                                  i <
                                      (state.getServiceDetailsByIDModel.data
                                              ?.spareParts?.length ??
                                          0);
                                  i++)
                                _buildDetailRow(
                                    state.getServiceDetailsByIDModel.data
                                            ?.spareParts?[i].partId?.partName ??
                                        "Not Available",
                                    "₹${PriceFormatter.formatPrice(state.getServiceDetailsByIDModel.data?.spareParts?[i].partId?.price ?? 0)} "),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Divider(thickness: 1.5),
                              ),
                              _buildDetailRow("Total Spare Parts Price",
                                  "₹${PriceFormatter.formatPrice(state.getServiceDetailsByIDModel.data?.totalPartsCost ?? 0)} "),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Divider(thickness: 1.5),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Divider(thickness: 1.5),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: const Text(
                                  "Oil Details",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Divider(thickness: 1.5),
                              for (int i = 0;
                                  i <
                                      (state.getServiceDetailsByIDModel.data
                                              ?.oils?.length ??
                                          0);
                                  i++)
                                _buildDetailRow(
                                    state.getServiceDetailsByIDModel.data
                                            ?.oils?[i].oilId?.oilName ??
                                        "Not Available",
                                    "₹${PriceFormatter.formatPrice(state.getServiceDetailsByIDModel.data?.oils?[i].oilId?.price ?? 0)} "),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Divider(thickness: 1.5),
                              ),
                              _buildDetailRow("Total Oil Price",
                                  "₹${PriceFormatter.formatPrice(state.getServiceDetailsByIDModel.data?.oilsCost ?? 0)} "),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Divider(thickness: 1.5),
                              ),
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Divider(thickness: 1.5),
                              _buildDetailRow(
                                "Payment Method",
                                state.getServiceDetailsByIDModel.data
                                        ?.paymentMethod ??
                                    "Not Available",
                              ),
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Divider(thickness: 1.5),
                              _buildDetailRow("Service Charge",
                                  "₹${PriceFormatter.formatPrice(state.getServiceDetailsByIDModel.data?.serviceCost ?? 0)} "),
                              for (int i = 0;
                                  i <
                                      (state.getServiceDetailsByIDModel.data
                                              ?.spareParts?.length ??
                                          0);
                                  i++)
                                _buildDetailRow(
                                    state.getServiceDetailsByIDModel.data
                                            ?.spareParts?[i].partId?.partName ??
                                        "Not Available",
                                    "+ ₹${PriceFormatter.formatPrice(state.getServiceDetailsByIDModel.data?.spareParts?[i].partId?.price ?? 0)} "),
                              for (int i = 0;
                                  i <
                                      (state.getServiceDetailsByIDModel.data
                                              ?.oils?.length ??
                                          0);
                                  i++)
                                _buildDetailRow(
                                    state.getServiceDetailsByIDModel.data
                                            ?.oils?[i].oilId?.oilName ??
                                        "Not Available",
                                    "+ ₹${PriceFormatter.formatPrice(state.getServiceDetailsByIDModel.data?.oils?[i].oilId?.price ?? 0)} "),
                              const Divider(thickness: 1.5),
                              _buildDetailRow("Total Amount",
                                  "₹${PriceFormatter.formatPrice(state.getServiceDetailsByIDModel.data?.totalCost ?? 0)} "),
                              _buildPriceRowBold(
                                  "Paid Amount",
                                  "- ₹${PriceFormatter.formatPrice(state.getServiceDetailsByIDModel.data?.paidAmount ?? 0)} ",
                                  false),
                              const Divider(thickness: 1.5),
                              _buildPriceRowBold(
                                  "Due Amount",
                                  "₹${PriceFormatter.formatPrice(state.getServiceDetailsByIDModel.data?.dueAmount ?? 0)} ",
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
                }
                return const Center(child: CircularProgressIndicator());
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
