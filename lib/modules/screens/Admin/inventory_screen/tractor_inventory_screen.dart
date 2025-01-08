import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/inventory_cubit/tractor_inventory/tractor_inventory_cubit.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/inventory_cubit/tractor_inventory/tractor_inventory_state.dart';
import 'package:savitri_automobiles_admin/resources/formatter.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';

class TractorInventoryScreen extends StatelessWidget {
  const TractorInventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TractorInventoryCubit(),
      child: const TractorInventoryPageView(),
    );
  }
}

class TractorInventoryPageView extends StatelessWidget {
  const TractorInventoryPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TractorInventoryCubit, TractorInventoryState>(
      builder: (context, state) {
        final cubit = context.read<TractorInventoryCubit>();
        if (state is TractorInventoryLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is TractorInventoryError) {
          return const Center(
            child: Text(
              "Stock Not Found...",
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
                "Tractor Stock",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              state.gettractormodel?.data?.docs?.isNotEmpty ?? false
                  ? Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.gettractormodel?.data?.docs?.length,
                        itemBuilder: (context, index) {
                          final entries =
                              state.gettractormodel?.data?.docs?[index];
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
                                      AppImages.swaraj735FE,
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
                                            entries?.modelName ??
                                                "Not Available",
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
