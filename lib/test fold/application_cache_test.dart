import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_in_flutter/caches/cache_for_application.dart';

void main() {
  late ApplicationCache applicationCache;

  setUp(() {
    applicationCache = MemoryCacheImpl(); // Ensure this class is correctly imported
  });

  test('should save data in memory', () {
    final data = {'object': 'value'}; // Renamed from `dynamic` to `data`

    applicationCache.putValue('key', data);

    expect(applicationCache.getValue('key'), equals(data));
  });
}
