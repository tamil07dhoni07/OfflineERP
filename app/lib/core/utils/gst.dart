/// Result of splitting a taxable value into GST heads for one tax regime.
class GstSplit {
  const GstSplit({required this.cgstPaise, required this.sgstPaise, required this.igstPaise});

  final int cgstPaise;
  final int sgstPaise;
  final int igstPaise;

  int get totalTaxPaise => cgstPaise + sgstPaise + igstPaise;
}

/// Splits GST per the configured regime — CGST+SGST when the place of
/// supply matches the company's state, IGST otherwise. Rates come from the
/// product/line, never hard-coded per country: this function only knows how
/// to divide a given rate, not what the rate should be.
GstSplit splitGst({required int taxableValuePaise, required double gstRatePercent, required bool interState}) {
  final totalTax = (taxableValuePaise * gstRatePercent / 100).round();
  if (interState) {
    return GstSplit(cgstPaise: 0, sgstPaise: 0, igstPaise: totalTax);
  }
  final half = (totalTax / 2).round();
  return GstSplit(cgstPaise: half, sgstPaise: totalTax - half, igstPaise: 0);
}
