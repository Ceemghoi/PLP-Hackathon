//2.
import 'dart:math';

class SortingAlgorithms {
  // Quicksort implementation
  List<int> quickSort(List<int> list) {
    if (list.length <= 1) return list;

    final pivot = list[list.length ~/ 2];
    list.removeAt(list.length ~/ 2);

    final less = list.where((element) => element <= pivot).toList();
    final greater = list.where((element) => element > pivot).toList();

    return [...quickSort(less), pivot, ...quickSort(greater)];
  }

  // Bubble sort implementation
  List<int> bubbleSort(List<int> list) {
    List<int> result = List.from(list);
    int n = result.length;

    for (int i = 0; i < n - 1; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        if (result[j] > result[j + 1]) {
          // Swap elements
          int temp = result[j];
          result[j] = result[j + 1];
          result[j + 1] = temp;
        }
      }
    }

    return result;
  }

  // Performance comparison function
  void comparePerformance(int size) {
    // Generate random list
    final random = Random();
    final list = List.generate(size, (_) => random.nextInt(1000));
    final list2 = List.from(list); // Create a copy for second sort

    // Test Quicksort
    final quickStartTime = DateTime.now();
    final quickSorted = quickSort(List.from(list));
    final quickDuration = DateTime.now().difference(quickStartTime);

    // Test Bubble sort
    final bubbleStartTime = DateTime.now();
    final bubbleSorted = bubbleSort(List.from(list2));
    final bubbleDuration = DateTime.now().difference(bubbleStartTime);

    // Print results
    print('Performance comparison for $size elements:');
    print('Quicksort time: ${quickDuration.inMicroseconds} microseconds');
    print('Bubble sort time: ${bubbleDuration.inMicroseconds} microseconds');
    print(
        'Quicksort is ${bubbleDuration.inMicroseconds / quickDuration.inMicroseconds}x faster');

    // Verify both sorts produced the same result
    assert(quickSorted.toString() == bubbleSorted.toString(),
        'Sorting results do not match!');
  }
}

void main() {
  final sorter = SortingAlgorithms();

  // Example usage
  final testList = [64, 34, 25, 12, 22, 11, 90];
  print('Original list: $testList');
  print('Quicksorted: ${sorter.quickSort(List.from(testList))}');
  print('Bubble sorted: ${sorter.bubbleSort(List.from(testList))}');

  // Compare performance with different list sizes
  [100, 1000, 10000].forEach((size) {
    sorter.comparePerformance(size);
    print('---');
  });
}
