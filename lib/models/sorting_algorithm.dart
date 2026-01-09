abstract class SortingAlgorithm {
  String get name;
  Stream<SortingState> sort(List<int> initialArray);
}

enum StepType { compare, swap, overwrite, sorted }

class SortingState {
  final List<int> array;
  final List<int> activeIndices;
  final StepType type;
  final String? message;

  SortingState(this.array, this.activeIndices, this.type, {this.message});
}
