import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_erp/core/utils/gst.dart';

void main() {
  group('splitGst', () {
    test('intra-state splits evenly into CGST + SGST', () {
      final split = splitGst(taxableValuePaise: 24850000, gstRatePercent: 18, interState: false);
      expect(split.cgstPaise, 2236500);
      expect(split.sgstPaise, 2236500);
      expect(split.igstPaise, 0);
      expect(split.totalTaxPaise, 4473000);
    });

    test('inter-state charges the full rate as IGST only', () {
      final split = splitGst(taxableValuePaise: 61200000, gstRatePercent: 18, interState: true);
      expect(split.igstPaise, 11016000);
      expect(split.cgstPaise, 0);
      expect(split.sgstPaise, 0);
    });

    test('CGST + SGST always sum to the same total as IGST would, for the same inputs', () {
      const taxable = 8740000;
      const rate = 18.0;
      final intra = splitGst(taxableValuePaise: taxable, gstRatePercent: rate, interState: false);
      final inter = splitGst(taxableValuePaise: taxable, gstRatePercent: rate, interState: true);
      expect(intra.totalTaxPaise, inter.totalTaxPaise);
    });

    test('handles an odd-paise total without losing a paisa', () {
      final split = splitGst(taxableValuePaise: 101, gstRatePercent: 18, interState: false);
      expect(split.cgstPaise + split.sgstPaise, split.totalTaxPaise);
    });
  });
}
