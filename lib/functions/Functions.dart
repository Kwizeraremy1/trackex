import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Functions {
  final supabase = Supabase.instance.client;
  late final userId = supabase.auth.currentUser!.id;

  Future<void> AddIncome(BuildContext context, amount0, via, from, note) async {
    int? amount = int.tryParse(amount0);
    if (amount == 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Amount must be greater than 0")));
      return;
    } else if (via == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select where the money is kept"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else if (from == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Enter where it is from"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Center(child: CircularProgressIndicator()),
          );
        },
      );
      try {
        final savings = await supabase
            .from('income')
            .select()
            .eq('profileId', userId)
            .maybeSingle();
        int? total = savings?['amount'] as int?;
        if (total == null) {
          await supabase.from('income').insert({
            'profileId': userId,
            'amount': amount,
          });
        } else {
          total = (total) + (amount ?? 0);
          await supabase
              .from('income')
              .update({'amount': total})
              .eq('profileId', userId);
        }
        await supabase.from('transactions').insert({
            'profileId': userId,
            'amount': amount,
            'CategoryId': 0,
            'type': via,
            'from': from,
            'note': note,
            'way': "income",
          });
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$e')));
        Navigator.pop(context);
      }
    }
  }
}
