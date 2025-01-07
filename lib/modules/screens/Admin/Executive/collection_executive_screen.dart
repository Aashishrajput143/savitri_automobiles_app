import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/executive_cubit/collection_executive/collection_executive_cubit.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/executive_cubit/collection_executive/collection_person_state.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';
import 'package:savitri_automobiles_admin/routes/routes.dart';

class CollectionExecutiveScreen extends StatelessWidget {
  const CollectionExecutiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CollectionPersonCubit(),
      child: const CollectionExecutivePageView(),
    );
  }
}

class CollectionExecutivePageView extends StatelessWidget {
  const CollectionExecutivePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionPersonCubit, CollectionPersonState>(
      builder: (context, state) {
        if (state is CollectionPersonLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CollectionPersonLoaded) {
          if (state.getusers?.data?.docs?.isEmpty ?? true) {
            return const Center(
              child: Text("No Users Found..."),
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
                  "Collection Executive Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.getusers?.data?.docs?.length,
                    itemBuilder: (context, index) {
                      final user = state.getusers?.data?.docs?[index];
                      return InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, Routes.collectionexecutivedetails),
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(AppImages.profile),
                              ),
                              title: Text(
                                user?.name ?? "Not Available",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Text(
                                "Executive-id ${user?.sId}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            ),
                            const Divider()
                          ],
                        ),
                      );
                    }),
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
