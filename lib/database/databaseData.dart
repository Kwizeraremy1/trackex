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
        .eq('way',way)
        .order('created_at', ascending: false);
    return transactions;
  }
}
