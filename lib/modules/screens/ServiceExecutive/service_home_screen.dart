import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Serviceman_cubit/service_home_cubit/service_home_cubit.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Serviceman_cubit/service_home_cubit/service_home_states.dart';
import 'package:savitri_automobiles_admin/resources/formatter.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';
import '../../../routes/routes.dart';

class ServiceHomeScreen extends StatelessWidget {
  const ServiceHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServiceHomeCubit(),
      child: BlocConsumer<ServiceHomeCubit, ServiceHomeStates>(
        listener: (context, state) {
          if (state is ServiceHomeLogout) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Sucessfully Logout")),
            );
            Navigator.pushReplacementNamed(context, Routes.login);
          }
        },
        builder: (context, state) {
          final cubit = context.read<ServiceHomeCubit>();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text("Service Data"),
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
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Logout"),
                            content:
                                const Text("Are you sure you want to logout?"),
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
                                  cubit.logoutApi(context);
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
            body: BlocBuilder<ServiceHomeCubit, ServiceHomeStates>(
              builder: (context, state) {
                final cubit = context.read<ServiceHomeCubit>();
                DateTime? lastBackPressTime;
                if (state is ServiceHomeLoading) {
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
                if (state is ServiceHomeError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                } else if (state is ServiceHomeLoaded) {
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
                      height: MediaQuery.of(context).size.height,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Service Entries: ${state.getServiceEntries.data?.docs?.length}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, Routes.addServiceEntry);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: const Text(
                                  'Add Serivce Entry',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Recently Added Entries",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, Routes.serviceEntrylisiting);
                                  },
                                  child: const Text("See all"),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            state.getServiceEntries.data?.docs?.isNotEmpty ??
                                    false
                                ? ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: (state.getServiceEntries.data
                                                    ?.docs?.length ??
                                                0) >
                                            5
                                        ? 5
                                        : state.getServiceEntries.data?.docs
                                            ?.length,
                                    itemBuilder: (context, index) {
                                      final entries = state
                                          .getServiceEntries.data?.docs?[index];
                                      return Card(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 2),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              Routes.servicereview,
                                              arguments: entries?.sId ?? "",
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(0.2)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
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
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.asset(
                                                    AppImages.swaraj735XT,
                                                    width: 80,
                                                    height: 80,
                                                    fit: BoxFit.contain,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return const SizedBox(
                                                        width: 80,
                                                        height: 80,
                                                        child: Center(
                                                          child: Text(
                                                            "No Image",
                                                            style: TextStyle(
                                                                fontSize: 11),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                          child: Text(
                                                            entries?.tractor
                                                                    ?.modelName ??
                                                                "",
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Text(
                                                          "₹${PriceFormatter.formatPrice(entries?.totalCost ?? 0)} ",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              "Owner : ",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 95,
                                                              child: Text(
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                entries?.customerName ??
                                                                    "",
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 3),
                                                        Text(
                                                          cubit.getdate(
                                                              entries?.createdAt ??
                                                                  "",
                                                              true),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          138,
                                                                          137,
                                                                          137)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Center(
                                                    heightFactor: 2,
                                                    child: TextButton(
                                                      onPressed: () {
                                                        Navigator.pushNamed(
                                                            context,
                                                            Routes
                                                                .tractordetails);
                                                      },
                                                      child: const Icon(Icons
                                                          .arrow_forward_ios),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : const Center(
                                    heightFactor: 10,
                                    child: Text("No Entries Found..."),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
