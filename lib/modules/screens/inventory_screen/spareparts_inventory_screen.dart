import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/inventory_cubit/spareparts_inventory_cubit.dart';
import 'package:savitri_automobiles_admin/routes/routes.dart';

class SparePartsInventoryScreen extends StatelessWidget {
  const SparePartsInventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SparePartsInventoryCubit(),
      child: const SparePartsInventoryPageView(),
    );
  }
}

class SparePartsInventoryPageView extends StatelessWidget {
  const SparePartsInventoryPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SparePartsInventoryCubit, SparePartsInventoryState>(
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Spare Parts Stock",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.featuredProducts.length,
                  itemBuilder: (context, index) {
                    final entries = state.featuredProducts[index];
                    return InkWell(
                      onTap: () {},
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  entries["image"],
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
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
                            const SizedBox(width: 10),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Text(
                                        entries["name"],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "${entries['price']}",
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
                                          "${entries['stock']}",
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
                              padding: const EdgeInsets.only(right: 15),
                              child: Center(
                                heightFactor: 2,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, Routes.tractordetails);
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
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
