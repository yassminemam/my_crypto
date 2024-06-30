import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_crypto/layers/presentation/pages/add_holding/view/add_holding_page.dart';

import 'layers/presentation/pages/home/view/home_page.dart';

const String addHolding = 'addHolding';
const String homeRoute = "home";
List<RouteBase> allRouts = <RouteBase>[
  GoRoute(
    path: "/",
    builder: (c, s) => const HomePage(),
    routes: <RouteBase>[
      GoRoute(
        path: addHolding,
        builder: (BuildContext context, GoRouterState state) {
          return const AddHoldingPage();
        },
      ),
      GoRoute(
        path: homeRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
    ],
  ),
];
