import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/executive_cubit/collection_executive/collection_executive_details_cubit.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/executive_cubit/collection_executive/collection_executive_details_state.dart';
import 'package:savitri_automobiles_admin/resources/formatter.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';
import 'package:savitri_automobiles_admin/routes/routes.dart';

class CollectionExecutiveDetailsScreen extends StatelessWidget {
  const CollectionExecutiveDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CollectionExecutiveDetailsCubit(),
      child: const CollectionExecutiveDetailsPageView(),
    );
  }
}

class CollectionExecutiveDetailsPageView extends StatelessWidget {
  const CollectionExecutiveDetailsPageView({super.key});

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
      body: BlocBuilder<CollectionExecutiveDetailsCubit,
          CollectionExecutiveDetailsState>(
        builder: (context, state) {
          final cubit = context.read<CollectionExecutiveDetailsCubit>();
          if (state is CollectionExecutiveDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CollectionExecutiveDetailsError) {
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
                                  child: const Icon(Icons.paid_outlined,
                                      color: Colors.green, size: 16),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "Paid Entries",
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
                                "${state.getpendingpaidcount?.data?.isNotEmpty ?? false ? (state.getpendingpaidcount?.data?[0].count) : 0}",
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
                                  backgroundColor: Colors.red.withOpacity(0.2),
                                  child: const Icon(Icons.pending_outlined,
                                      color: Colors.red, size: 16),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "Due Entries",
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
                                "${state.getpendingpaidcount?.data?.isNotEmpty ?? false ? (state.getpendingpaidcount?.data?[1].count) : 0}",
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
                        _buildDetailRow("Email", "collectionexe@yopmail.com"),
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
                      "Pending Sales Entries",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  state.getSalesentries?.data?.docs?.isNotEmpty ?? false
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              state.getSalesentries?.data?.docs?.length ?? 0,
                          itemBuilder: (context, index) {
                            final entries =
                                state.getSalesentries?.data?.docs?[index];
                            return Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2),
                              child: InkWell(
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
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.2)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 3,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
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
                                                  style:
                                                      TextStyle(fontSize: 11),
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
                                                "Paid: ₹${PriceFormatter.formatPrice(entries?.paidAmount ?? 0)}",
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                "Due: ₹${PriceFormatter.formatPrice(entries?.dueAmount ?? 0)}",
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    overflow: TextOverflow.clip,
                                                    "Customer : ",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 95,
                                                    child: Text(
                                                      overflow:
                                                          TextOverflow.clip,
                                                      entries?.customerName ??
                                                          "Not Available",
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 3),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, right: 10),
                                                child: Text(
                                                  cubit.getdate(
                                                      entries?.createdAt ?? "",
                                                      true),
                                                  style: const TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 138, 137, 137)),
                                                ),
                                              ),
                                              Center(
                                                heightFactor: 1.5,
                                                child: TextButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                      context,
                                                      Routes.salespreview,
                                                      arguments:
                                                          entries?.sId ?? "",
                                                    );
                                                  },
                                                  child: const Text(
                                                    "View",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
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
