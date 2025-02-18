class AgriProductValidator {
  bool isValidProductID(dynamic input) {
    if (input == null) return false;
    String str = input.toString();

    String cleanStr = str
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .replaceAll(RegExp(r'\s'), '');

    if (cleanStr.isEmpty) return false;

    return cleanStr == cleanStr.split('').reversed.join('');
  }
}

void main() {
  final validator = AgriProductValidator();

  // Test cases for agricultural product IDs
  print('Testing Product IDs:');
  print(validator.isValidProductID("CORN121NROC")); // true - Corn product
  print(validator.isValidProductID("SOY-12321-YOS")); // true - Soybean product
  print(validator.isValidProductID("WHT-454-THW")); // true - Wheat product
  print(validator.isValidProductID("FERT-123")); // false - Fertilizer product

  // Test with batch numbers
  print('\nTesting Batch Numbers:');
  print(validator.isValidProductID("B12321B")); // true
  print(validator.isValidProductID("L12345")); // false
}
