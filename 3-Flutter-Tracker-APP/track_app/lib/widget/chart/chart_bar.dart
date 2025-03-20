import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({super.key, required this.fill});

  final double fill;

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          child: FractionallySizedBox(
            heightFactor: fill,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color:
                        isDarkMode
                            ? Colors.black.withOpacity(0.4)
                            : Colors.grey.withOpacity(0.3),
                    offset: const Offset(0, 4),
                    blurRadius: 6,
                  ),
                ],
                gradient: LinearGradient(
                  colors: [
                    isDarkMode
                        ? Theme.of(
                          context,
                        ).colorScheme.secondary.withOpacity(0.9)
                        : Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.9),
                    isDarkMode
                        ? Theme.of(
                          context,
                        ).colorScheme.secondary.withOpacity(0.6)
                        : Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.6),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
