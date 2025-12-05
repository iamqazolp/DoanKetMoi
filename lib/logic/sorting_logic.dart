import 'dart:async';
import '../models/sort_model.dart';

class SortingLogic {
  // A generator function that streams updates
  static Stream<SortStep> bubbleSort(List<int> input, Duration speed) async* {
    var list = List<int>.from(
      input,
    ); // Copy to avoid modifying original immediately

    for (int i = 0; i < list.length; i++) {
      for (int j = 0; j < list.length - i - 1; j++) {
        // 1. Tell UI we are comparing j and j+1
        yield SortStep(list, j, j + 1, SortState.comparing);
        await Future.delayed(speed);

        if (list[j] > list[j + 1]) {
          int temp = list[j];
          list[j] = list[j + 1];
          list[j + 1] = temp;

          // 2. Tell UI we swapped them
          yield SortStep(list, j, j + 1, SortState.swapping);
          await Future.delayed(speed);
        }
      }
    }
    // 3. Sorting complete
    yield SortStep(list, null, null, SortState.sorted);
  }

  static Stream<SortStep> insertionSort(
    List<int> input,
    Duration speed,
  ) async* {
    var list = List<int>.from(
      input,
    ); // Copy to avoid modifying original immediately

    for (int i = 0; i < list.length; i++) {
      int j = i;
      while ((j != 0) && (list[j] < list[j - 1])) {
        // 1. Tell UI we are comparing j and j+1
        yield SortStep(list, j, j - 1, SortState.comparing);
        await Future.delayed(speed);

        int temp = list[j];
        list[j] = list[j - 1];
        list[j - 1] = temp;
        j--;
        // 2. Tell UI we swapped them
        yield SortStep(list, j, j - 1, SortState.swapping);
        await Future.delayed(speed);
      }
    }
    // 3. Sorting complete
    yield SortStep(list, null, null, SortState.sorted);
  }
}
