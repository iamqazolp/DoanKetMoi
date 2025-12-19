import 'dart:async';
import 'sorting_algorithm.dart';

class BubbleSort implements SortingAlgorithm {
  @override
  String get name => 'Bubble Sort';

  @override
  Stream<SortingState> sort(List<int> initialArray) async* {
    List<int> array = List.from(initialArray);
    int n = array.length;
    
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            // Compare
            yield SortingState(List.from(array), [j, j + 1], StepType.compare);
            await Future.delayed(Duration(milliseconds: 1)); // micro-delay allows listeners to process

            if (array[j] > array[j + 1]) {
                // Swap
                int temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
                yield SortingState(List.from(array), [j, j + 1], StepType.swap);
            }
        }
    }
    yield SortingState(List.from(array), [], StepType.sorted, message: "Sorted!");
  }
}
