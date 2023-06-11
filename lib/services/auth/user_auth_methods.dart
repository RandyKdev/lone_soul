import 'package:lone_soul/global_user.dart';
import 'package:lone_soul/models/user.dart';
import 'package:lone_soul/services/db/user_db_methods.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserAuthentication {
  final userDB = UserDBMethods();
  final supabaseInstance = Supabase.instance;

  Future<AppUser?> signInWithEmailAndPassword(
      String email, String password) async {
    final response = await supabaseInstance.client.auth
        .signInWithPassword(email: email, password: password);

    final userId = response.user?.id;
    if (userId == null) {
      return null;
    }

    //use "userId" to query db and get user then return this user
    final appUser = await userDB.getUser(userId);
    globalUser = appUser;
    return appUser;
  }

  Future<String?> signUpEmailAndPassword(AppUser appuser) async {
    final response = await supabaseInstance.client.auth.signUp(
      email: appuser.email,
      password: appuser.password!,
    );

    final userId = response.user?.id;
    
    if (userId == null) {
      return null;
    }
    return userId;
  }

  Future<void> signOut() async {
    await supabaseInstance.client.auth.signOut();
    return;
  }
}
