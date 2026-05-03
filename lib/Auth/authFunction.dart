import 'package:supabase_flutter/supabase_flutter.dart';

class Authfunction {
  final supabase = Supabase.instance.client;

  Future<AuthResponse> SignIn(String email, String password) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> SignUp(
    String email,
    String password,
  ) async {
    return await supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

  Future<void> SignOut() async {
    await supabase.auth.signOut();
  }
}
