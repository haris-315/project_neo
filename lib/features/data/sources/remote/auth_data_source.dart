import 'package:project_neo/core/custom_exceptions/server_exception.dart';
import 'package:project_neo/features/data/models/chat_session.dart';
import 'package:project_neo/features/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthDataSource {
  final SupabaseClient _client;

  AuthDataSource({required SupabaseClient client}) : _client = client;

  Future<UserModel> signUp(String email, String password, String name) async {
    try {
      final response = await _client.auth.signUp(
        password: password,
        email: email,
        data: {"name": name},
      );
      if (response.user == null) {
        throw ServerException(exception: "User Is Null");
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(exception: e.toString());
    }
  }

  Future<UserModel> signIn(String email, String password) async {
    try {
      final response = await _client.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw ServerException(exception: "User Is Null");
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(exception: e.toString());
    }
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<List<ChatSession>> getUserSessions(userId) {
    throw UnimplementedError();
  }
}
