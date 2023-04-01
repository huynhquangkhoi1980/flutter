// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mevn_app/app/features/main/view/main.dart';
import 'package:mevn_app/app/utils/route/app_route.dart';
// import 'package:mevn_app/l10n/l10n.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      localizationsDelegates: const [
        // AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      // supportedLocales: AppLocalizations.supportedLocales,
      onGenerateRoute: AppRoute.generateRoute,
      home: const MainScreen(),
    );
  }
}
