import 'dart:async';
import 'sorting_algorithm.dart';

class SelectionSort implements SortingAlgorithm {
  @override
  String get name => 'Selection Sort';

  @override
  Stream<SortingState> sort(List<int> initialArray) async* {
    List<int> array = List.from(initialArray);
    int n = array.length;

    for (int i = 0; i < n - 1; i++) {
        int minIdx = i;
        for (int j = i + 1; j < n; j++) {
            // Compare
            yield SortingState(List.from(array), [j, minIdx], StepType.compare);
            await Future.delayed(Duration(milliseconds: 1)); 
            
            if (array[j] < array[minIdx]) {
                minIdx = j;
            }
        }
        
        if (minIdx != i) {
            // Swap
            int temp = array[minIdx];
            array[minIdx] = array[i];
            array[i] = temp;
            yield SortingState(List.from(array), [i, minIdx], StepType.swap);
        }
    }
    yield SortingState(List.from(array), [], StepType.sorted, message: "Sorted!");
  }
}
