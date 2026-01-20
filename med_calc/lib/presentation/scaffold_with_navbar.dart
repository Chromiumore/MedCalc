import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavbar extends StatelessWidget {
  const ScaffoldWithNavbar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Калькулятор'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Статистика/История')
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex
          );
        },
        ),
    );
  }
  
}