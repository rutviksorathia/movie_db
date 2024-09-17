import 'package:flutter_test/flutter_test.dart';
import 'package:movie_db/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('MoviesViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
