import 'package:flutter/material.dart';

class CategoryColors {
  static const Map<String, Color> colors = {
    'income': Colors.green,
    'Food & Dining': Colors.orangeAccent,
    'Transportation': Colors.blueAccent,
    'Housing & Rent': Colors.brown,
    'Utilities': Colors.amber,
    'Healthcare': Colors.redAccent,
    'Education': Colors.indigo,
    'Entertainment': Colors.purpleAccent,
    'Shopping': Colors.pinkAccent,
    'Travel': Colors.teal,
    'Personal Care': Colors.cyan,
    'Savings & Investments': Colors.lightGreen,
    'Insurance': Colors.blueGrey,
    'Debt Payments': Colors.deepOrange,
    'Gifts & Donations': Colors.deepPurpleAccent,
    'Business Expenses': Colors.indigoAccent,
    'Clothing & Apparel': Colors.pink,
    'Electronics & Technology': Colors.lightBlue,
    'Home Maintenance': Colors.brown,
    'Fitness & Sports': Colors.lime,
    'Subscriptions': Colors.deepPurple,
    'Children & Family': Colors.yellow,
    'Pets': Colors.orange,
    'Taxes': Colors.grey,
    'Miscellaneous': Colors.tealAccent,
  };

  static Color get(String category) =>
      colors[category] ?? Colors.grey;
}

class CategoryIcons {
  static const Map<String, IconData> icons = {
    'income': Icons.attach_money,
    'Food & Dining': Icons.restaurant,
    'Transportation': Icons.directions_car,
    'Housing & Rent': Icons.home,
    'Utilities': Icons.bolt,
    'Healthcare': Icons.local_hospital,
    'Education': Icons.school,
    'Entertainment': Icons.movie,
    'Shopping': Icons.shopping_bag,
    'Travel': Icons.flight,
    'Personal Care': Icons.spa,
    'Savings & Investments': Icons.savings,
    'Insurance': Icons.shield,
    'Debt Payments': Icons.credit_card,
    'Gifts & Donations': Icons.card_giftcard,
    'Business Expenses': Icons.business_center,
    'Clothing & Apparel': Icons.checkroom,
    'Electronics & Technology': Icons.devices,
    'Home Maintenance': Icons.build,
    'Fitness & Sports': Icons.fitness_center,
    'Subscriptions': Icons.subscriptions,
    'Children & Family': Icons.family_restroom,
    'Pets': Icons.pets,
    'Taxes': Icons.receipt_long,
    'Miscellaneous': Icons.category,
  };

  static IconData get(String category) =>
      icons[category] ?? Icons.category;
}