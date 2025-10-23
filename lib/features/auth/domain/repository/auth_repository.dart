import 'package:blog_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/common/entities/user.dart';

abstract interface class AuthRepository {
  
  Future<Either<Failure, User>> signUpWithEmailandPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> loginWithEmailandPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> currentUser();

}
