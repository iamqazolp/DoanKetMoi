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

          if (vm.displayMode == DisplayMode.box) {
            return _buildBoxView(vm, context);
          } else {
            return _buildBarView(vm, context);
          }
        },
      ),
    );
  }

  Widget _buildBoxView(SortingViewModel vm, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: List.generate(vm.numbers.length, (index) {
        final number = vm.numbers[index];
        final isActive = vm.activeIndices.contains(index);
        final isSorted = vm.isSorted;

        Color color = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
        Color textColor = isDark ? Colors.white : Colors.black87;

        if (isSorted) {
          color = Colors.green.shade400;
          textColor = Colors.white;
        } else if (isActive) {
          color = Colors.orange.shade400;
          textColor = Colors.white;
        }

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: isDark ? Colors.white24 : Colors.black12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(2, 2),
              ),
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
  }

  Widget _buildBarView(SortingViewModel vm, BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemCount = vm.numbers.length;
        if (itemCount == 0) return const SizedBox.shrink();

        final availableWidth = constraints.maxWidth;
        const marginPerItem = 2.0;

        final maxBarWidth = (availableWidth / itemCount) - marginPerItem;

        final barWidth = maxBarWidth.clamp(2.0, 40.0);

        return Container(
          height: 300,
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(itemCount, (index) {
              final number = vm.numbers[index];
              final isActive = vm.activeIndices.contains(index);
              final isSorted = vm.isSorted;

              Color color = Theme.of(context).brightness == Brightness.dark
                  ? Colors.blue.shade200
                  : Colors.blue.shade400;

              if (isSorted) {
                color = Colors.green.shade400;
              } else if (isActive) {
                color = Colors.orange.shade400;
              }

              final double height = (number / 100) * 280;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 1),
                width: barWidth,
                height: height,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
