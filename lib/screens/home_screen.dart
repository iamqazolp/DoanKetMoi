import 'package:flutter/material.dart';
import 'dart:math';
import '../models/sort_model.dart';
import '../logic/sorting_logic.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> _numbers = [];
  Stream<SortStep>? _currentStream;
  final int _sampleSize = 20;
  final Duration _speed = Duration(milliseconds: 50);

  @override
  void initState() {
    super.initState();
    _resetArray();
  }

  void _resetArray() {
    setState(() {
      _numbers = List.generate(
        _sampleSize,
        (index) => Random().nextInt(300) + 10,
      );
      _currentStream = null; // Clear any running sort
    });
  }

  void _startSorting() {
    setState(() {
      // Start the stream
      _currentStream = SortingLogic.bubbleSort(_numbers, _speed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sorting Visualizer")),
      body: Column(
        children: [
          // Visualizer Area
          Expanded(
            child: Center(
              child: StreamBuilder<SortStep>(
                stream: _currentStream,
                builder: (context, snapshot) {
                  List<int> displayList = _numbers;
                  int? idxA;
                  int? idxB;
                  SortState state = SortState.idle;

                  // If the stream has data, use it. Otherwise use the initial list.
                  if (snapshot.hasData) {
                    displayList = snapshot.data!.currentList;
                    idxA = snapshot.data!.indexA;
                    idxB = snapshot.data!.indexB;
                    state = snapshot.data!.state;
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: displayList.asMap().entries.map((entry) {
                      int index = entry.key;
                      int value = entry.value;
                      return _buildBar(value, index, idxA, idxB, state);
                    }).toList(),
                  );
                },
              ),
            ),
          ),
          // Controls Area
          Container(
            height: 80,
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: _resetArray, child: Text("Shuffle")),
                ElevatedButton(onPressed: _startSorting, child: Text("Sort")),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to color the bars
  Widget _buildBar(int value, int index, int? a, int? b, SortState state) {
    Color color = Colors.blueAccent;

    if (state == SortState.sorted) {
      color = Colors.green;
    } else if (index == a || index == b) {
      color = state == SortState.swapping ? Colors.red : Colors.orange;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      width: 10,
      height: value.toDouble(),
      color: color,
    );
  }
}
