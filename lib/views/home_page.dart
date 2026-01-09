import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/sorting_viewmodel.dart';
import 'widgets/visualizer_area.dart';
import 'widgets/control_panel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sorting Visualizer"),
        centerTitle: true,
        elevation: 100,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          Consumer<SortingViewModel>(
            builder: (context, vm, child) {
              return Container(
                padding: const EdgeInsets.all(16),
                color: Colors.blueGrey.shade50,
                width: double.infinity,
                child: Text(
                  vm.statusMessage,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),

          const Expanded(child: VisualizerArea()),

          const ControlPanel(),
        ],
      ),
    );
  }
}
