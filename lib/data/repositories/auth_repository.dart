import 'package:project_neo/data/sources/remote/supabase_service.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseService _supabaseService;

  AuthRepository(this._supabaseService);

  Future<void> signInWithGoogle() async {
    await _supabaseService.signInWithGoogle();
  }

  User? getCurrentUser() {
    return _supabaseService.getCurrentUser();
  }

  Future<void> signOut() async {
    await _supabaseService.signOut();
  }
}
