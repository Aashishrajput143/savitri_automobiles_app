import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Salesman_cubit/sale_entry_listing/sales_entry_cubit.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';
import 'package:savitri_automobiles_admin/resources/formatter.dart';
import 'package:savitri_automobiles_admin/routes/routes.dart';

class SalesEntryListing extends StatelessWidget {
  const SalesEntryListing({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => SalesEntryCubit(), child: const SaleEntryListingPage());
  }
}

class SaleEntryListingPage extends StatelessWidget {
  const SaleEntryListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Sales Entries'),
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
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.search);
            },
            icon: const Icon(Icons.search),
            color: Colors.black,
          ),
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
      body: BlocBuilder<SalesEntryCubit, SalesEntryState>(
        builder: (context, state) {
          final cubit = context.read<SalesEntryCubit>();
          if (state is SalesEntryLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SalesEntryError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(fontSize: 16),
              ),
            );
          } else if (state is SalesEntryLoaded) {
            if (state.getSalesEntries?.data?.docs?.isEmpty ?? true) {
              return const Center(child: Text("Sales Entries Not Found..."));
            }
            return Container(
              color: Colors.white,
              child: ListView.builder(
                itemCount: state.getSalesEntries?.data?.docs?.length,
                itemBuilder: (context, index) {
                  final entries = state.getSalesEntries?.data?.docs?[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.salespreview,
                        arguments: entries?.sId ?? "",
                      );
                    },
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
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Tractor Details",
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  cubit.getdate(entries?.createdAt ?? "", true),
                                  style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 64, 64, 64)),
                                ),
                              ],
                            ),
                          ),
                          const Divider(thickness: 1.5),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  AppImages.swaraj735FE,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const SizedBox(
                                      width: 70,
                                      height: 70,
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
                              const SizedBox(width: 10),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Text(
                                          entries?.tractor?.modelName ?? "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Text(
                                            "Price: ",
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            "₹${PriceFormatter.formatPrice(entries?.totalAmount ?? 0)} ",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Text(
                                            "RegistrationType: ",
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            entries?.registration
                                                    ?.registrationType ??
                                                "",
                                            style: const TextStyle(
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Icon(
                                  Icons.arrow_forward,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Divider(thickness: 1.5),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Customer Details",
                              style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(thickness: 1.5),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ListTile(
                              subtitle: Text(
                                  "Customer Name: ${entries?.customerName ?? "Not Available"}\nContact Number: ${entries?.customerContact ?? "Not Available"}\nAddress: ${entries?.customerAddress ?? "Not Available"}"),
                              isThreeLine: true,
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
