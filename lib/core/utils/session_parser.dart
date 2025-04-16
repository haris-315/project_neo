import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

final class SessionParser {
  static Session? sFromString(String str) {
    return Session.fromJson(jsonDecode(str));
  }

  static String sToString(Session session) {
    return session.toJson().toString();
  }
}
