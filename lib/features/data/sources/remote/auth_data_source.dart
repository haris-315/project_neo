import 'package:project_neo/core/custom_exceptions/server_exception.dart';
import 'package:project_neo/features/data/models/chat_session.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthDataSource {
  final SupabaseClient _client;

  AuthDataSource({required SupabaseClient client}) : _client = client;

  Future<String> signUp(String email, String password, String name) async {
    print(email + password + name);
    final response = await _client.auth.signUp(
      password: password,
      email: email,
      data: {"name": name},
    );
    if (response.user == null) {
      throw ServerException(exception: "User Is Null");
    }
    return response.user!.id;
  }

  User? getCurrentUser() {
    return _client.auth.currentUser;
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<List<ChatSession>> getUserSessions(userId) {
    throw UnimplementedError();
  }
}
