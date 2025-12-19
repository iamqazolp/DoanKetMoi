
abstract class SortingAlgorithm {
  String get name;
  Stream<SortingState> sort(List<int> initialArray);
}

enum StepType {
  compare,
  swap,
  overwrite, // For merge sort
  sorted
}

class SortingState {
  final List<int> array;
  final List<int> activeIndices; // Indices being compared/swapped
  final StepType type;
  final String? message;

  SortingState(this.array, this.activeIndices, this.type, {this.message});
}
