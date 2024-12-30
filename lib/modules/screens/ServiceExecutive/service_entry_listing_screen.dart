import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Serviceman_cubit/service_entry_listing/service_entry_cubit.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Serviceman_cubit/service_entry_listing/service_entry_state.dart';
import 'package:savitri_automobiles_admin/resources/formatter.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';
import 'package:savitri_automobiles_admin/routes/routes.dart';

class ServiceEntryListing extends StatelessWidget {
  const ServiceEntryListing({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ServiceEntryCubit(),
        child: const SaleEntryListingPage());
  }
}

class SaleEntryListingPage extends StatelessWidget {
  const SaleEntryListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Entries'),
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
      body: BlocProvider(
        create: (_) => ServiceEntryCubit(),
        child: BlocBuilder<ServiceEntryCubit, ServiceEntryState>(
          builder: (context, state) {
            final cubit = context.read<ServiceEntryCubit>();
            if (state is ServiceEntryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ServiceEntryLoaded) {
              if (state.getServiceEntries.data?.docs?.isEmpty ?? true) {
                return const Center(child: Text("No Service available."));
              }
              return Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: state.getServiceEntries.data?.docs?.length,
                  itemBuilder: (context, index) {
                    final tractor = state.getServiceEntries.data?.docs?[index];
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.servicereview,
                          arguments: tractor?.sId ?? "",
                        );
                      },
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
                        margin: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Service Tractor Details",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    cubit.getdate(
                                        tractor?.createdAt ?? "", true),
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
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
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
                                            tractor?.tractor?.modelName ??
                                                "Not Available",
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
                                              "₹${PriceFormatter.formatPrice(tractor?.totalCost ?? 0)} ",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "Servicetype: ${tractor?.serviceType ?? "Not Available"}",
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        )
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
                                    "Customer Name: ${tractor?.customerName ?? "Not Available"}\nContact Number: ${tractor?.customerContact ?? "Not Available"}\nAddress: ${tractor?.customerAddress ?? "Not Available"}"),
                                isThreeLine: true,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.servicereview,
                                    arguments: tractor?.sId ?? "",
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is ServiceEntryError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
