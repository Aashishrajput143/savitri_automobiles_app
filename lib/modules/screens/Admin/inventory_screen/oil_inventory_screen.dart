import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/inventory_cubit/oil_inventory/oil_inventory_cubit.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/inventory_cubit/oil_inventory/oil_inventory_state.dart';
import 'package:savitri_automobiles_admin/resources/formatter.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';

class OilInventoryScreen extends StatelessWidget {
  const OilInventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OilInventoryCubit(),
      child: const OilInventoryPageView(),
    );
  }
}

class OilInventoryPageView extends StatelessWidget {
  const OilInventoryPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OilInventoryCubit, OilInventoryState>(
      builder: (context, state) {
        final cubit = context.read<OilInventoryCubit>();
        if (state is OilInventoryLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is OilInventoryError) {
          return const Center(
            child: Text(
              "Data Not Found...",
              style: TextStyle(fontSize: 16),
            ),
          );
        }
        return Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Oil Stock",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              state.getOilmodel?.data?.docs?.isNotEmpty ?? false
                  ? Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.getOilmodel?.data?.docs?.length,
                        itemBuilder: (context, index) {
                          final entries = state.getOilmodel?.data?.docs?[index];
                          return Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      AppImages.gtx,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const SizedBox(
                                          width: 80,
                                          height: 80,
                                          child: Center(
                                            child: Text(
                                              "No Image",
                                              style: TextStyle(fontSize: 11),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: Text(
                                            entries?.oilName ?? "Not Available",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "₹${PriceFormatter.formatPrice(entries?.price ?? 0)} ",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Text(
                                              "Stock Available : ",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "${entries?.quantity ?? 0}",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Center(
                                    heightFactor: 2,
                                    child: TextButton(
                                      onPressed: () {
                                        cubit.showUpdateDialog(context, index);
                                      },
                                      child: const Text(
                                        "Update",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(
                      heightFactor: 5,
                      child: Text("Stock Not Found..."),
                    ),
            ],
          ),
        );
      },
    );
  }
}
