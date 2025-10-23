import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;

  Future<UserModel> signUpWithEmailandPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailandPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> loginWithEmailandPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );

      print('Supabase signUp response: \n');
      print('${response.user?.toJson()}, login user Data');
      if (response.user == null) {
        print('Error: No user returned. Response error: \n');
        print(response);
        throw ServerException('No User found!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      print('SignUp Exception: \n');
      print(e);
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailandPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'full_name': name},
      );
      print('Supabase signUp response: \n');
      print('${response.user?.toJson()}, signin user Data');
      if (response.user == null) {
        print('Error: No user returned. Response error: \n');
        print(response);
        throw ServerException('No User found!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      print('SignUp Exception: \n');
      print(e);
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentUserSession!.user.id);
        return UserModel.fromJson(userData.first);
      }

      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
