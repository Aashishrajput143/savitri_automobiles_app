import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/collection_cubit/collection_home_cubit/collection_home_cubit.dart';
import 'package:savitri_automobiles_admin/modules/cubit/collection_cubit/collection_home_cubit/collection_home_state.dart';
import 'package:savitri_automobiles_admin/resources/formatter.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';
import 'package:savitri_automobiles_admin/routes/routes.dart';

class CollectionHomeScreen extends StatelessWidget {
  const CollectionHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CollectionHomeCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("Collection Data"),
          centerTitle: false,
          automaticallyImplyLeading: false,
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
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: PopupMenuButton<String>(
                color: Colors.white,
                offset: const Offset(0, 50),
                menuPadding: const EdgeInsets.symmetric(vertical: 3),
                onSelected: (value) {
                  if (value == 'logout') {
                    // Handle logout logic here
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("Logout"),
                        content: const Text("Are you sure you want to logout?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Perform logout action
                              Navigator.pushReplacementNamed(
                                  context, Routes.login);
                            },
                            child: const Text("Logout"),
                          ),
                        ],
                      ),
                    );
                  }
                },
                icon: CircleAvatar(
                  backgroundImage: AssetImage(AppImages.profile),
                  radius: 15,
                ),
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.black),
                        SizedBox(width: 8),
                        Text("Logout"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: BlocConsumer<CollectionHomeCubit, CollectionHomeStates>(
            listener: (context, state) {
          if (state is CollectionHomeLogout) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Sucessfully Logout")),
            );
            Navigator.pushReplacementNamed(context, Routes.login);
          }
        }, builder: (context, state) {
          final cubit = context.read<CollectionHomeCubit>();

          DateTime? lastBackPressTime;
          if (state is CollectionHomeLoading) {
            return WillPopScope(
              onWillPop: () async {
                final now = DateTime.now();
                if (lastBackPressTime == null ||
                    now.difference(lastBackPressTime!) >
                        const Duration(seconds: 2)) {
                  lastBackPressTime = now;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Press back again to exit"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  return false; // Prevent exit
                }
                return true; // Exit the app
              },
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is CollectionHomeError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(fontSize: 16),
              ),
            );
          }
          return WillPopScope(
            onWillPop: () async {
              final now = DateTime.now();
              if (lastBackPressTime == null ||
                  now.difference(lastBackPressTime!) >
                      const Duration(seconds: 2)) {
                lastBackPressTime = now;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Press back again to exit"),
                    duration: Duration(seconds: 1),
                  ),
                );
                return false; // Prevent exit
              }
              return true; // Exit the app
            },
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 170,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.3)),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                                    child: Text(
                                      "${state.salescount?.data?.isNotEmpty ?? false ? (state.salescount?.data?[0].count) : 0}",
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
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.3)),
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
                                            Colors.red.withOpacity(0.2),
                                        child: const Icon(
                                            Icons.pending_outlined,
                                            color: Colors.red,
                                            size: 16),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                                    child: Text(
                                      "${state.salescount?.data?.isNotEmpty ?? false ? (state.salescount?.data?[1].count) : 0}",
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
                      ],
                    ),
                    // Add Sales Entry Button
                    //
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Recent Due Entries",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.collectionSeeAll);
                          },
                          child: const Text("See all"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          (state.getSalesEntries?.data?.docs?.length ?? 0) > 5
                              ? 5
                              : state.getSalesEntries?.data?.docs?.length ?? 0,
                      itemBuilder: (context, index) {
                        final entries =
                            state.getSalesEntries?.data?.docs?[index];
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
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
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 95,
                                                child: Text(
                                                  overflow: TextOverflow.clip,
                                                  entries?.customerName ??
                                                      "Not Available",
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
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
                                      padding: const EdgeInsets.only(right: 10),
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
                                                  fontWeight: FontWeight.bold,
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
                                                  arguments: entries?.sId ?? "",
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
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
