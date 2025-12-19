import 'dart:async';
import 'sorting_algorithm.dart';

class MergeSort implements SortingAlgorithm {
  @override
  String get name => 'Merge Sort';

  @override
  Stream<SortingState> sort(List<int> initialArray) async* {
    List<int> array = List.from(initialArray);
    yield* _mergeSort(array, 0, array.length - 1);
    yield SortingState(List.from(array), [], StepType.sorted, message: "Sorted!");
  }

  Stream<SortingState> _mergeSort(List<int> array, int left, int right) async* {
    if (left < right) {
      int mid = (left + right) ~/ 2;

      yield* _mergeSort(array, left, mid);
      yield* _mergeSort(array, mid + 1, right);

      yield* _merge(array, left, mid, right);
    }
  }

  Stream<SortingState> _merge(List<int> array, int left, int mid, int right) async* {
    int n1 = mid - left + 1;
    int n2 = right - mid;

    List<int> L = List.filled(n1, 0);
    List<int> R = List.filled(n2, 0);

    for (int i = 0; i < n1; i++) {
        L[i] = array[left + i];
    }
    for (int j = 0; j < n2; j++) {
        R[j] = array[mid + 1 + j];
    }

    int i = 0, j = 0;
    int k = left;

    while (i < n1 && j < n2) {
      yield SortingState(List.from(array), [left + i, mid + 1 + j], StepType.compare); // Visualizing comparison based on original indices approx
      await Future.delayed(Duration(milliseconds: 1));

      if (L[i] <= R[j]) {
        array[k] = L[i];
        yield SortingState(List.from(array), [k], StepType.overwrite);
        i++;
      } else {
        array[k] = R[j];
        yield SortingState(List.from(array), [k], StepType.overwrite);
        j++;
      }
      k++;
    }

    while (i < n1) {
      array[k] = L[i];
      yield SortingState(List.from(array), [k], StepType.overwrite);
      i++;
      k++;
    }

    while (j < n2) {
      array[k] = R[j];
      yield SortingState(List.from(array), [k], StepType.overwrite);
      j++;
      k++;
    }
  }
}
