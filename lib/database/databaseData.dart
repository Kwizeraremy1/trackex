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

  Future<Map<String, dynamic>> getMonthlyTransactions() async {
    final year = DateTime.now().year;

    final response = await supabase
        .from('transactions')
        .select('amount, created_at, way')
        .eq("profileId", userId)
        .gte('created_at', '$year-01-01')
        .lt('created_at', '${year + 1}-01-01');

    Map<int, double> monthlyExpenses = {for (int i = 1; i <= 12; i++) i: 0};

    Map<int, double> monthlyIncome = {for (int i = 1; i <= 12; i++) i: 0};

    for (var tx in response) {
      final amount = (tx['amount'] as num).toDouble();
      final date = DateTime.parse(tx['created_at']);

      final month = date.month;

      if (tx['way'] == 'expense') {
        monthlyExpenses[month] = (monthlyExpenses[month] ?? 0) + amount;
      } else if (tx['way'] == 'income') {
        monthlyIncome[month] = (monthlyIncome[month] ?? 0) + amount;
      }
    }

    final expenses = monthlyExpenses.entries.map((e) {
      return {"month": e.key, "amount": e.value};
    }).toList();

    final income = monthlyIncome.entries.map((e) {
      return {"month": e.key, "amount": e.value};
    }).toList();

    // Compare both income and expense values
    final allValues = [...monthlyExpenses.values, ...monthlyIncome.values];

    final highestValue = allValues.reduce((a, b) => a > b ? a : b);

    return {"expenses": expenses, "income": income, "highest": highestValue};
  }

  Future<List<Map<String, dynamic>>> getCategoryUsed() async {
    final response = await supabase
        .from('transactions')
        .select('id, category(name)')
        .neq('way', 'income')
        .eq("profileId", userId);
    final Map<String, int> categoriesHere = {};

    for (var id in response) {
      final category = id['category']['name'];
      final value = id['id'];
      categoriesHere[category] = value as int;
    }

    return categoriesHere.entries.map((e) {
      return {'cat': e.key, 'id': e.value};
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getCatTransaction(cat) async {
    final transactions = await supabase
        .from('transactions')
        .select('*, category(*)')
        .eq('profileId', userId)
        .eq('id', cat)
        .order('created_at', ascending: false);
    return transactions;
  }
}
