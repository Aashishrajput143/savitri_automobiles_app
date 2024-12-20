import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Serviceman_cubit/service_entry_listing/service_entry_cubit.dart';
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
        create: (_) => ServiceEntryCubit()..fetchServiceEntries(),
        child: BlocBuilder<ServiceEntryCubit, ServiceEntryState>(
          builder: (context, state) {
            if (state is ServiceEntryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ServiceEntrySuccess) {
              if (state.serviceEntryListing.isEmpty) {
                return const Center(child: Text("No Service available."));
              }
              return Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: state.serviceEntryListing.length,
                  itemBuilder: (context, index) {
                    final tractor = state.serviceEntryListing[index];
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.servicereview);
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
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Tractor Details",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "20 Oct 2024",
                                    style: TextStyle(
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
                                    tractor["image"],
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
                                            tractor["name"],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text("Model: ${tractor["model"]}"),
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
                                              "₹${tractor['price']}",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
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
                            ListTile(
                              title: Text("xyz"),
                              subtitle:
                                  Text("Number: 123455666\nAddress: Noida"),
                              isThreeLine: true,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is ServiceEntryFailure) {
              return Center(child: Text(state.errorMessage));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
