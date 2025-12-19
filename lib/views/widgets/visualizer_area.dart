import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/sorting_viewmodel.dart';

class VisualizerArea extends StatelessWidget {
  const VisualizerArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      alignment: Alignment.center,
      child: Consumer<SortingViewModel>(
        builder: (context, vm, child) {
          if (vm.numbers.isEmpty) {
            return const Text("Press Reset to generate numbers");
          }

          return Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: List.generate(vm.numbers.length, (index) {
              final number = vm.numbers[index];
              final isActive = vm.activeIndices.contains(index);
              final isSorted = vm.isSorted;

              Color color = Colors.grey.shade300;
              Color textColor = Colors.black87;

              if (isSorted) {
                color = Colors.green.shade300;
                textColor = Colors.white;
              } else if (isActive) {
                color = Colors.orange.shade300;
                textColor = Colors.white;
              }

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8), // Rounded box
                  border: Border.all(color: Colors.black12),
                  boxShadow: [
                    BoxShadow(

                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  number.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: textColor,
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
