import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/sorting_algorithm.dart';
import '../models/bubble_sort.dart';
import '../models/selection_sort.dart';
import '../models/insertion_sort.dart';
import '../models/quick_sort.dart';
import '../models/merge_sort.dart';
import '../models/radix_sort.dart';

enum DisplayMode { box, bar }

class SortingViewModel extends ChangeNotifier {
  List<int> _numbers = [];
  List<int> _activeIndices = [];
  SortingAlgorithm _currentAlgorithm;
  bool _isSorting = false;
  bool _isSorted = false;
  int _delayMs = 50;
  String _statusMessage = "Ready";

  DisplayMode _displayMode = DisplayMode.box;
  bool _isDarkMode = false;

  // Getters
  List<int> get numbers => _numbers;
  List<int> get activeIndices => _activeIndices;
  bool get isSorting => _isSorting;
  bool get isSorted => _isSorted;
  String get statusMessage => _statusMessage;
  SortingAlgorithm get currentAlgorithm => _currentAlgorithm;
  int get delayMs => _delayMs;
  DisplayMode get displayMode => _displayMode;
  bool get isDarkMode => _isDarkMode;

  // Available algorithms
  final List<SortingAlgorithm> algorithms = [
    BubbleSort(),
    SelectionSort(),
    InsertionSort(),
    QuickSort(),
    MergeSort(),
    RadixSort(),
  ];

  SortingViewModel() : _currentAlgorithm = BubbleSort() {
    reset();
  }

  void reset() {
    _generateRandomNumbers();
    _isSorted = false;
    _statusMessage = "Ready";
    _activeIndices = [];
    notifyListeners();
  }

  void _generateRandomNumbers() {
    final rng = Random();
    _numbers = List.generate(30, (_) => rng.nextInt(99) + 1);
  }

  void setAlgorithm(SortingAlgorithm algorithm) {
    if (_isSorting) return;
    _currentAlgorithm = algorithm;
    notifyListeners();
  }

  void setSpeed(int delay) {
    _delayMs = delay;
    notifyListeners();
  }

  void setDisplayMode(DisplayMode mode) {
    _displayMode = mode;
    notifyListeners();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  Future<void> startSorting() async {
    if (_isSorting || _isSorted) return;

    _isSorting = true;
    _isSorted = false;
    _statusMessage = "Sorting with ${_currentAlgorithm.name}...";
    notifyListeners();

    final stream = _currentAlgorithm.sort(_numbers);

    await for (final state in stream) {
      if (!_isSorting) break;

      _numbers = state.array;
      _activeIndices = state.activeIndices;

      if (state.message != null) {
        _statusMessage = state.message!;
      }

      if (state.type == StepType.sorted) {
        _isSorted = true;
        _statusMessage = "Sorted!";
        _activeIndices = [];
      }

      notifyListeners();
      await Future.delayed(Duration(milliseconds: _delayMs));
    }

    _isSorting = false;
    notifyListeners();
  }

  void stopSorting() {
    _isSorting = false;
    notifyListeners();
  }
}
