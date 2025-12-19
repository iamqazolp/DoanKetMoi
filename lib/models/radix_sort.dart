import 'dart:async';
import 'dart:math';
import 'sorting_algorithm.dart';

class RadixSort implements SortingAlgorithm {
  @override
  String get name => 'Radix Sort';

  @override
  Stream<SortingState> sort(List<int> initialArray) async* {
    List<int> array = List.from(initialArray);
    if (array.isEmpty) return;
    
    int maxVal = array.reduce(max);
    
    for (int exp = 1; maxVal ~/ exp > 0; exp *= 10) {
        yield* _countSort(array, exp);
    }
    
    yield SortingState(List.from(array), [], StepType.sorted, message: "Sorted!");
  }

  Stream<SortingState> _countSort(List<int> array, int exp) async* {
      int n = array.length;
      List<int> output = List.filled(n, 0);
      List<int> count = List.filled(10, 0);

      // Store count of occurrences in count[]
      for (int i = 0; i < n; i++) {
          yield SortingState(List.from(array), [i], StepType.compare, message: "Counting digit at exp $exp");
          await Future.delayed(Duration(milliseconds: 1));
          count[(array[i] ~/ exp) % 10]++;
      }

      // Change count[i] so that count[i] now contains actual
      // position of this digit in output[]
      for (int i = 1; i < 10; i++) {
          count[i] += count[i - 1];
      }

      // Build the output array
      for (int i = n - 1; i >= 0; i--) {
          int digit = (array[i] ~/ exp) % 10;
          output[count[digit] - 1] = array[i];
          count[digit]--;
      }

      // Copy the output array to arr[], so that arr[] now
      // contains sorted numbers according to current digit
      for (int i = 0; i < n; i++) {
          array[i] = output[i];
          yield SortingState(List.from(array), [i], StepType.overwrite, message: "Rebuilding array for digit $exp");
          await Future.delayed(Duration(milliseconds: 1));
      }
  }
}
