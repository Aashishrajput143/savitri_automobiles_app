import 'package:flutter/material.dart';
import 'package:savitri_automobiles_admin/routes/routes.dart';

class CommonScreen extends StatelessWidget {
  final Widget appBarTitle;
  final List<Widget> appBarActions;
  final Widget body;
  final int currentIndex;
  final bool centertitle;
  final bool autoimplement;
  final int tabs;
  final int initialtab;
  final PreferredSizeWidget bottomtabs;

  const CommonScreen({
    super.key,
    required this.appBarTitle,
    required this.centertitle,
    required this.appBarActions,
    required this.body,
    required this.currentIndex,
    required this.autoimplement,
    required this.tabs,
    required this.initialtab,
    required this.bottomtabs,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: initialtab,
      length: tabs,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: appBarTitle,
          automaticallyImplyLeading: autoimplement,
          centerTitle: centertitle,
          actions: appBarActions,
          bottom: bottomtabs,
        ),
        body: body,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            if (index == 0) {
              Navigator.pushNamed(
                context,
                Routes.home,
              );
            } else if (index == 1) {
              Navigator.pushNamed(context, Routes.registration);
            } else if (index == 2) {
              Navigator.pushNamed(context, Routes.inventory);
            } else if (index == 3) {
              Navigator.pushNamed(context, Routes.executive);
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.agriculture),
              label: "Entries",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: "Inventory",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Executive",
            ),
          ],
        ),
      ),
    );
  }
}
