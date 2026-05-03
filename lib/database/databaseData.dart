import 'package:supabase_flutter/supabase_flutter.dart';

class Databasedata {
  final supabase = Supabase.instance.client;
  Future<List<Map<String, dynamic>>> getCategory() {
    final cat = supabase.from('category').select();
    return cat;
  }
}
