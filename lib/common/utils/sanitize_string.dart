String sanitizeNPM(String? npm) {
  return npm!.replaceAll(RegExp(r'[^0-9]'), '');
}
