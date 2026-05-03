import 'package:supabase_flutter/supabase_flutter.dart';

class Databasedata {
  final supabase = Supabase.instance.client;
  late final userId = supabase.auth.currentUser!.id;
  Future<List<Map<String, dynamic>>> getCategory() {
    final cat = supabase.from('category').select();
    return cat;
  }

  Future<Map<String, dynamic>> getProfile() {
    final profile = supabase.from('profiles').select().eq('id', userId).single();
    return profile;
  }
}
