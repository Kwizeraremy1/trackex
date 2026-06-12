import 'package:supabase_flutter/supabase_flutter.dart';

class Databasedata {
  final supabase = Supabase.instance.client;
  late final userId = supabase.auth.currentUser!.id;
  Future<List<Map<String, dynamic>>> getCategory() {
    final cat = supabase.from('category').select();
    return cat;
  }

  Future<Map<String, dynamic>> getProfile() async {
    final profile = await supabase
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();
    return profile;
  }

  Future<List<Map<String, dynamic>>> getTransactions() async {
    final transactions = await supabase
        .from('transactions')
        .select('*, category(*)')
        .eq('profileId', userId)
        .order('created_at', ascending: false);
    return transactions;
  }

  Future<Map<String, dynamic>> getDashPane() async {
    final income = await supabase
        .from('income')
        .select('amount')
        .eq('profileId', userId)
        .single();
    final incomeValue = income['amount'];
    final expense = await supabase
        .from('expense')
        .select('amount')
        .eq('profileId', userId)
        .single();
    final expenseValue = expense['amount'];
    final totalBalance = incomeValue - expenseValue;
    return {
      'incomeValue': incomeValue ?? 0,
      'expenseValue': expenseValue ?? 0,
      'totalBalance': totalBalance ?? 0,
    };
  }

  Future<List<Map<String, dynamic>>> getHistory(way) async {
    final transactions = await supabase
        .from('transactions')
        .select('*, category(*)')
        .eq('profileId', userId)
        .eq('way', way)
        .order('created_at', ascending: false);
    return transactions;
  }

  Future<List<Map<String, dynamic>>> getCategoryPercentage() async {
    final response = await supabase
        .from('transactions')
        .select('*, category(name)')
        .eq('way', 'expense')
        .eq("profileId", userId);

    Map<String, double> total = {};
    Map<String, int> counts = {};

    double grandTotal = 0;

    for (var tx in response) {
      final category = tx['category']['name'];
      final amount = (tx['amount'] as num).toDouble();

      total[category] = (total[category] ?? 0) + amount;
      counts[category] = (counts[category] ?? 0) + 1;
    }

    grandTotal = total.values.fold(0, (sum, item) => sum + item);

    return total.entries.map((entry) {
      final percentage = grandTotal == 0 ? 0 : (entry.value / grandTotal) * 100;

      return {
        'category': entry.key,
        'amount': entry.value,
        'count': counts[entry.key] ?? 0,
        'percentage': double.parse(percentage.toStringAsFixed(1)),
        'total': grandTotal,
      };
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getMonthlyExpenses() async {
    final response = await supabase
        .from('transactions')
        .select('amount, created_at')
        .eq('way', 'expense')
        .eq("profileId", userId);

    Map<String, double> monthlyTotals = {};

    for (var tx in response) {
      final amount = (tx['amount'] as num).toDouble();
      final date = DateTime.parse(tx['created_at']);

      final monthKey = "${date.year}-${date.month.toString().padLeft(2, '0')}";

      monthlyTotals[monthKey] = (monthlyTotals[monthKey] ?? 0) + amount;
    }

    final result = monthlyTotals.entries.map((e) {
      final parts = e.key.split('-');
      final month = int.parse(parts[1]);

      return {
  'month': int.parse(month.toString().padLeft(2, '0')),
  "amount": e.value,
};
    }).toList();

    return result;
  }
  
}
