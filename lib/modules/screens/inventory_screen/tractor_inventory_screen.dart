import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/inventory_cubit/stock_price_manage_cubit.dart';
import 'package:savitri_automobiles_admin/modules/cubit/inventory_cubit/tractor_inventory_cubit.dart';
import 'package:savitri_automobiles_admin/routes/routes.dart';

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
        return Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
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
              const SizedBox(height: 5),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.featuredProducts.length,
                  itemBuilder: (context, index) {
                    final entries = state.featuredProducts[index];
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
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.tractordetails);
                            },
                            child: Padding(
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
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.tractordetails);
                                },
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5, top: 5),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Icon(Icons.add, size: 22),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text('${entries['stock']}',
                                        style: const TextStyle(fontSize: 13)),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Icon(Icons.remove, size: 22),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          BlocProvider(
                            create: (_) => StockPriceFormCubit(),
                            child: BlocBuilder<StockPriceFormCubit,
                                Map<String, dynamic>>(
                              builder: (context, state) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Center(
                                    heightFactor: 2,
                                    child: TextButton(
                                      onPressed: () {
                                        showUpdateDialog(context);
                                      },
                                      child: const Text(
                                        "View",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
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
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void showUpdateDialog(BuildContext context) {
    final cubit = context.read<StockPriceFormCubit>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update Details"),
          content: Form(
            key: cubit.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: cubit.priceController,
                  decoration: InputDecoration(
                    labelText: "Price Update",
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    cubit.updatePrice(value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a price";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: cubit.stockController,
                  decoration: InputDecoration(
                    labelText: "Stock Update",
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    cubit.updateStock(value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter stock";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (cubit.formKey.currentState!.validate()) {
                  final price = cubit.priceController.text;
                  final stock = cubit.stockController.text;

                  print("Price: $price, Stock: $stock");

                  cubit.updatePrice(price);
                  cubit.updateStock(stock);

                  Navigator.pop(context);
                }
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
