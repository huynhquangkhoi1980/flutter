// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:mevn_app/app/app.dart';
import 'package:mevn_app/bootstrap.dart';

import 'app/utils/flavor/flavor.dart';
import 'my_global.dart';

void main() {
  bootstrap(
    () => MyGlobal(
      flavorConfig: FlavorConfig(
        flavor: Flavor.dev,
        values: FlavorValues(
          mainUrl: 'http://dev.com',
          blogUrl: 'https://www.marketenterprise.vn/blog',
        ),
      ),
      child: const App(),
    ),
  );
}
