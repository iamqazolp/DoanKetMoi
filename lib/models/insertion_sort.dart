import 'dart:async';
import 'sorting_algorithm.dart';

class InsertionSort implements SortingAlgorithm {
  @override
  String get name => 'Insertion Sort';

  @override
  Stream<SortingState> sort(List<int> initialArray) async* {
    List<int> array = List.from(initialArray);
    int n = array.length;

    for (int i = 1; i < n; i++) {
      int key = array[i];
      int j = i - 1;

      // Visualizing the key being selected
      yield SortingState(
        List.from(array),
        [i],
        StepType.compare,
        message: "Selected key: $key",
      );
      await Future.delayed(Duration(milliseconds: 1));

      while (j >= 0 && array[j] > key) {
        // Compare
        yield SortingState(List.from(array), [j, j + 1], StepType.compare);
        await Future.delayed(Duration(milliseconds: 1));

        array[j + 1] = array[j];
        j = j - 1;

        // Show shift
        yield SortingState(List.from(array), [j + 1], StepType.overwrite);
      }
      array[j + 1] = key;
      // Show placement
      yield SortingState(
        List.from(array),
        [j + 1],
        StepType.overwrite,
        message: "Placed $key",
      );
    }
    yield SortingState(
      List.from(array),
      [],
      StepType.sorted,
      message: "Sorted!",
    );
  }
}
