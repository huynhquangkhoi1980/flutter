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
          mainUrl: 'http://localhost:8000',
          blogUrl: 'https://www.marketenterprise.vn/blog',
          apiUrl: 'https://www.marketenterprise.vn/api',
        ),
      ),
      child: const App(),
    ),
  );
}
