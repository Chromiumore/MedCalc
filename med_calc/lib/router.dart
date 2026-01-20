import 'package:go_router/go_router.dart';
import 'package:med_calc/calculator_screen.dart';
import 'package:med_calc/scaffold_with_navbar.dart';
import 'package:med_calc/staticstics_screen.dart';

final router = GoRouter(
  initialLocation: '/calculator',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavbar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/calculator',
              builder: (context, state) => const CalculatorScreen(),
            ),
          ]
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/statistics',
              builder:(context, state) => const StaticsticsScreen(),
            ),
          ]
        )
      ]
      )
  ]
);