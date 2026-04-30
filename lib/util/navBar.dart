import 'package:flutter/material.dart';
class FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const FloatingNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _NavButton(icon: Icons.home_rounded,   index: 0, currentIndex: currentIndex, onTap: onTap),
          _NavButton(icon: Icons.add_rounded, index: 1, currentIndex: currentIndex, onTap: onTap),
          _NavButton(icon: Icons.bar_chart_rounded, index: 2, currentIndex: currentIndex, onTap: onTap),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final int index, currentIndex;
  final Function(int) onTap;

  const _NavButton({
    required this.icon,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == currentIndex;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Padding(
        padding: const EdgeInsets.only(right:10, left: 10),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : const Color.fromARGB(52, 255, 255, 255),
            borderRadius: BorderRadius.circular(10), // rounded square
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 30,
            color: isSelected ? Colors.black : Colors.white54,
          ),
        ),
      ),
    );
  }
}