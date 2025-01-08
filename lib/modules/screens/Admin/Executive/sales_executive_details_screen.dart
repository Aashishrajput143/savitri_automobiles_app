import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/executive_cubit/sales_executive/sales_executive_details_cubit.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/executive_cubit/sales_executive/sales_executive_details_state.dart';
import 'package:savitri_automobiles_admin/resources/formatter.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';
import 'package:savitri_automobiles_admin/routes/routes.dart';

class SalesExecutiveDetailsScreen extends StatelessWidget {
  const SalesExecutiveDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? id = ModalRoute.of(context)?.settings.arguments as String?;
    return BlocProvider(
      create: (_) => SalesExecutiveDetailsCubit(id),
      child: const SalesExecutiveDetailsPageView(),
    );
  }
}

class SalesExecutiveDetailsPageView extends StatelessWidget {
  const SalesExecutiveDetailsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            "Rajendra Singh",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.search);
            },
            icon: const Icon(Icons.search),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.notification);
            },
            icon: const Icon(Icons.notifications_outlined),
            color: Colors.black,
          ),
        ],
      ),
      body: BlocBuilder<SalesExecutiveDetailsCubit, SalesExecutiveDetailsState>(
        builder: (context, state) {
          final cubit = context.read<SalesExecutiveDetailsCubit>();
          if (state is SalesExecutiveDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SalesExecutiveDetailsError) {
            return Center(
              child: Text(
                state.message ?? "",
                style: TextStyle(fontSize: 16),
              ),
            );
          }
          return Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      "Overview",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 170,
                        padding: const EdgeInsets.all(16),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor:
                                      Colors.green.withOpacity(0.2),
                                  child: const Icon(Icons.bar_chart,
                                      color: Colors.green, size: 16),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "Sold Tractors",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                              child: Text(
                                "${state.getSalescount?.data?.salesCount ?? 0}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 170,
                        padding: const EdgeInsets.all(16),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.blue.withOpacity(0.2),
                                  child: const Icon(Icons.person,
                                      color: Colors.blue, size: 16),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "Sold Implements",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                              child: Text(
                                "${state.getSalescount?.data?.equipmentCount ?? 0}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      "Personal Information",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow("Executive Name", "Rajendra Singh"),
                        _buildDetailRow("Email", "salesexecutive@gmail.com"),
                        _buildDetailRow("Phone Number", "9595784563"),
                        _buildDetailRow("Joined Date", "24 March 2024"),
                        _buildDetailRow("Address",
                            "Sector 63, Noida, Uttar pradesh, India 2489001"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      "Sold Tractors & Implements",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  state.getSalesentries?.data?.docs?.isNotEmpty ?? false
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              state.getSalesentries?.data?.docs?.length ?? 0,
                          itemBuilder: (context, index) {
                            final entries =
                                state.getSalesentries?.data?.docs?[index];
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
                                        AppImages.swaraj735XT,
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
                                              "Customer : ${entries?.customerName ?? "Not Available"}",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              cubit.getdate(
                                                  entries?.createdAt ?? "",
                                                  true),
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
                                              color: Color.fromARGB(
                                                  255, 119, 33, 135),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          heightFactor: 7,
                          child: Text("No Entries Found..."),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: 210,
            child: Text(
              overflow: TextOverflow.clip,
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
