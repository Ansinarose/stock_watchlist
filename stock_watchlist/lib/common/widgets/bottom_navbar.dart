import 'package:flutter/material.dart';
import 'package:stock_watchlist/common/constants/colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          _buildNavItem(context, 0, Icons.home, 'Home'),
          _buildNavItem(context, 1, Icons.list, 'Watchlist'),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, String label) {
    final isSelected = currentIndex == index;
    final itemColor = isSelected ? AppConstants.scaffoldBackgroundColor : AppConstants.primaryColor;
    
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Container(
          color: isSelected ? AppConstants.primaryColor : AppConstants.scaffoldBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: itemColor),
              SizedBox(height: 4),
              Text(label, style: TextStyle(color: itemColor, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}