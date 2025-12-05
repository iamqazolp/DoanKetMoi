enum SortState { idle, comparing, swapping, sorted }

class SortStep {
  final List<int> currentList;
  final int? indexA; // Active index 1 (for highlighting)
  final int? indexB; // Active index 2 (for highlighting)
  final SortState state;

  SortStep(this.currentList, this.indexA, this.indexB, this.state);
}
