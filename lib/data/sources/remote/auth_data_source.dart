// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:project_neo/core/utils/app_constants.dart';
import 'package:project_neo/core/utils/session_parser.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:project_neo/core/custom_exceptions/server_exception.dart';
import 'package:project_neo/core/services/session_manager.dart';
import 'package:project_neo/data/models/user_model.dart';

class AuthDataSource {
  final SupabaseClient _client;
  final SessionManager sessionManager;

  AuthDataSource({required SupabaseClient client, required this.sessionManager})
    : _client = client;
  Session? get currentSession => _client.auth.currentSession;
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
      return UserModel.fromJson(response.user!.toJson()["user_metadata"]);
    } catch (e) {
      throw ServerException(exception: e.toString());
    }
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<UserModel?> getUserInfo() async {
    try {
      final response = await sessionManager.retrieveSession(
        AppConstants.sessionKey,
      );
      response.fold(
        (fail) {
          return null;
        },
        (pass) async {
          if (pass == null) {
            return null;
          } else {            try {
              final res = await _client.auth.setSession(
                SessionParser.sFromString(pass)!.refreshToken!,
                
              );

              return res.session != null ? null : res.session!.user;
            } catch (e) {
              print(e);
              return null;
            }
          }
        },
      );
    } catch (e) {
      throw ServerException(exception: e.toString());
    }
    return null;
  }
}
