import 'dart:async';
import 'sorting_algorithm.dart';

class QuickSort implements SortingAlgorithm {
  @override
  String get name => 'Quick Sort';

  @override
  Stream<SortingState> sort(List<int> initialArray) async* {
    List<int> array = List.from(initialArray);
    yield* _partitionAndSort(array, 0, array.length - 1);
    yield SortingState(List.from(array), [], StepType.sorted, message: "Sorted!");
  }

   Stream<SortingState> _partitionAndSort(List<int> array, int low, int high) async* {
      if (low < high) {
          int pivotIndex = -1;
          
          // PARTITION LOGIC INLINED TO YIELD STATES
          int pivot = array[high];
          int i = (low - 1);
          
          for (int j = low; j < high; j++) {
              yield SortingState(List.from(array), [j, high], StepType.compare);
              await Future.delayed(Duration(milliseconds: 1));
              
              if (array[j] < pivot) {
                  i++;
                  int temp = array[i];
                  array[i] = array[j];
                  array[j] = temp;
                  yield SortingState(List.from(array), [i, j], StepType.swap);
              }
          }
           int temp = array[i + 1];
           array[i + 1] = array[high];
           array[high] = temp;
           yield SortingState(List.from(array), [i + 1, high], StepType.swap);
           
           pivotIndex = i + 1;
           
           // RECURSIVE CALLS
           yield* _partitionAndSort(array, low, pivotIndex - 1);
           yield* _partitionAndSort(array, pivotIndex + 1, high);
      }
  }
}
