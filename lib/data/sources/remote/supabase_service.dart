import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> signInWithGoogle() async {
    await _client.auth.signInWithOAuth(
      OAuthProvider.google,
    );
  }

  User? getCurrentUser() {
    return _client.auth.currentUser;
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}
