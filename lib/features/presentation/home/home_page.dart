import 'package:flutter/material.dart';
import 'package:gra_app/features/presentation/dashboard/dashboard_page.dart';
import 'package:gra_app/features/presentation/film_list/list_page.dart';

class HomePage extends StatelessWidget {
  late final PageController pageController;
  HomePage({super.key}) {
    pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raspberry Awards'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Dashboard Menu'),
            ),
            ListTile(
              title: const Text('Dashboard'),
              onTap: () {
                pageController.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('List'),
              onTap: () {
                pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          pageSnapping: false,
          children: const [
            DashboardPage(),
            ListPage(),
          ]),
    );
  }
}
