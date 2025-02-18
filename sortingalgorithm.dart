import 'dart:math';

class AgriSorting {
  // Sort crop yields
  List<double> sortYields(List<double> yields) {
    if (yields.isEmpty) return [];

    List<double> sorted = List.from(yields);
    sorted.sort();
    return sorted;
  }

  // Sort produce by quality score
  List<ProduceBatch> sortByQuality(List<ProduceBatch> batches) {
    if (batches.isEmpty) return [];

    List<ProduceBatch> sorted = List.from(batches);
    sorted.sort((a, b) => b.qualityScore.compareTo(a.qualityScore));
    return sorted;
  }

  // Generate random test data
  List<ProduceBatch> generateTestData(int count) {
    final random = Random();
    List<ProduceBatch> batches = [];

    for (int i = 0; i < count; i++) {
      batches.add(ProduceBatch(
          id: "BATCH-${i + 1}",
          cropType: ["Corn", "Wheat", "Soybean", "Rice"][random.nextInt(4)],
          qualityScore: (random.nextDouble() * 100).roundToDouble(),
          yield: (random.nextDouble() * 1000).roundToDouble()));
    }

    return batches;
  }
}

class ProduceBatch {
  final String id;
  final String cropType;
  final double qualityScore;
  final double yield;

  ProduceBatch(
      {required this.id,
      required this.cropType,
      required this.qualityScore,
      required this.yield});

  @override
  String toString() {
    return 'Batch $id: $cropType (Quality: $qualityScore%, Yield: $yield kg)';
  }
}

void main() {
  final sorter = AgriSorting();

  // Generate test data
  final batches = sorter.generateTestData(5);

  print('Original Batches:');
  batches.forEach(print);

  print('\nSorted by Quality Score:');
  final sortedBatches = sorter.sortByQuality(batches);
  sortedBatches.forEach(print);

  // Test yield sorting
  List<double> yields = batches.map((b) => b.yield).toList();
  print('\nSorted Yields:');
  print(sorter.sortYields(yields));
}
