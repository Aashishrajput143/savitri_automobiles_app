import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/registration_cubit/sales_entries/registration_cubit.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/registration_cubit/sales_entries/registration_state.dart';
import 'package:savitri_automobiles_admin/resources/formatter.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';
import 'package:savitri_automobiles_admin/routes/routes.dart';

class TractorListingScreen extends StatelessWidget {
  const TractorListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegistrationCubit(),
      child: const TractorPageView(),
    );
  }
}

class TractorPageView extends StatelessWidget {
  const TractorPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        final cubit = context.read<RegistrationCubit>();
        if (state is RegistrationLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is RegistrationLoaded) {
          if (state.getSalesEntries?.data?.docs?.isEmpty ?? true) {
            return const Center(
              child: Text("No Entries Found..."),
            );
          }

          return Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Tractor Registrations",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
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
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2),
                        child: Row(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Text(
                                        entries?.tractor?.modelName ??
                                            "Not Available",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "₹${PriceFormatter.formatPrice(entries?.totalAmount ?? 0)} ",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Salesman : ${entries?.customerName ?? "Not Available"}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      cubit.getdate(
                                          entries?.createdAt ?? "", true),
                                      style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 138, 137, 137)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Center(
                                heightFactor: 5.5,
                                child: Text(
                                  "View Details",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 119, 33, 135),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
