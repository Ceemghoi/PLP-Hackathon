class AgriCalculator {
  // Calculate required fertilizer amount (kg) based on area (hectares) and application rate (kg/ha)
  double calculateFertilizerAmount(double area, double applicationRate) {
    return area * applicationRate;
  }

  // Calculate expected yield based on historical yield and growth factor
  double calculateExpectedYield(double historicalYield, double growthFactor) {
    return historicalYield * growthFactor;
  }

  // Calculate water requirements (liters) based on crop type and area (square meters)
  double calculateWaterRequirement(String cropType, double area) {
    // Water requirements in liters per square meter per day
    Map<String, double> waterNeeds = {
      'corn': 5.0,
      'wheat': 4.0,
      'rice': 8.0,
      'soybean': 4.5,
    };

    return area * (waterNeeds[cropType.toLowerCase()] ?? 5.0);
  }

  // Calculate profit based on yield (kg), price per kg, and costs
  double calculateProfit(double yield, double pricePerKg, double costs) {
    return (yield * pricePerKg) - costs;
  }

  // Calculate pesticide dilution ratio
  double calculatePesticideDilution(
      double concentrateAmount, double waterAmount) {
    if (waterAmount == 0) {
      throw ArgumentError('Water amount cannot be zero');
    }
    return concentrateAmount / waterAmount;
  }
}

void main() {
  final calculator = AgriCalculator();

  // Test calculations
  print('Fertilizer needed for 10 hectares at 250 kg/ha: '
      '${calculator.calculateFertilizerAmount(10, 250)} kg');

  print('Expected yield from 5000kg historical yield with 1.2 growth factor: '
      '${calculator.calculateExpectedYield(5000, 1.2)} kg');

  print('Daily water requirement for 1000m² of corn: '
      '${calculator.calculateWaterRequirement("corn", 1000)} liters');

  print('Profit for 2000kg yield at \$2/kg with \$1000 costs: '
      '\$${calculator.calculateProfit(2000, 2, 1000)}');

  try {
    print('Pesticide dilution ratio (100ml:10L): '
        '${calculator.calculatePesticideDilution(100, 10000)}');
  } catch (e) {
    print('Error: $e');
  }
}
