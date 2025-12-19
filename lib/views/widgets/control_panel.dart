import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/sorting_viewmodel.dart';


class ControlPanel extends StatelessWidget {
  const ControlPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<SortingViewModel>(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Algorithm Selection
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: vm.algorithms.map((algo) {
                 final isSelected = vm.currentAlgorithm.name == algo.name;
                 return Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 4.0),
                   child: ChoiceChip(
                     label: Text(algo.name),
                     selected: isSelected,
                     onSelected: vm.isSorting ? null : (bool selected) {
                       if (selected) {
                         vm.setAlgorithm(algo);
                       }
                     },
                   ),
                 );
              }).toList(),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: vm.isSorting ? null : vm.startSorting,
                icon: const Icon(Icons.play_arrow),
                label: const Text("Sort"),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              const SizedBox(width: 16),
              OutlinedButton.icon(
                onPressed: vm.isSorting ? vm.stopSorting : vm.reset,
                icon: Icon(vm.isSorting ? Icons.stop : Icons.refresh),
                label: Text(vm.isSorting ? "Stop" : "Reset"),
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          
          // Speed Slider
          Row(
            children: [
              const Text("Fast"),
              Expanded(
                child: Slider(
                  value: vm.delayMs.toDouble(),
                  min: 5,
                  max: 500,
                  divisions: 20,
                  label: "${vm.delayMs} ms",
                  onChanged: (val) {
                    vm.setSpeed(val.toInt());
                  },
                ),
              ),
              const Text("Slow"),
            ],
          )
        ],
      ),
    );
  }
}
