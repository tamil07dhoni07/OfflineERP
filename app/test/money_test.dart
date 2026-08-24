import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_erp/core/utils/money.dart';

void main() {
  group('toIndianRupees', () {
    test('groups in the Indian numbering style', () {
      expect(24850000.toIndianRupees(), '2,48,500');
      expect(100.toIndianRupees(), '1');
      expect(0.toIndianRupees(), '0');
      expect(15000000.toIndianRupees(), '1,50,000');
      expect(304083200.toIndianRupees(), '30,40,832');
    });

    test('keeps small values ungrouped', () {
      expect(50000.toIndianRupees(), '500');
      expect(99900.toIndianRupees(), '999');
    });

    test('handles negative values', () {
      expect((-24850000).toIndianRupees(), '-2,48,500');
    });

    test('prefixes the rupee symbol when asked', () {
      expect(100000.toIndianRupees(withSymbol: true), '₹1,000');
    });
  });

  group('rupeesToPaise', () {
    test('round-trips with toRupees', () {
      expect(rupeesToPaise(1050), 105000);
      expect(rupeesToPaise(10.5), 1050);
      expect(105000.toRupees, 1050);
    });
  });
}
