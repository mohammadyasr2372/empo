import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/strings/constans.dart';
import '../../../../../injection_container.dart';
import '../../model/user_model.dart';

abstract class UserLocalData {
  Future<UserModel> getCachedProUser();
  Future<Unit> cacheUsers(UserModel userModel);
}

class UserLocalDataImpl implements UserLocalData {
  @override
  Future<Unit> cacheUsers(UserModel userModel) {
    sl
        .get<SharedPreferences>()
        .setString(CACHED_PRO_USER, userModel.toJson());
    return Future.value(unit);
  }

  @override
  Future<UserModel> getCachedProUser() {
    final jsonString =
        sl.get<SharedPreferences>().getString(CACHED_PRO_USER);
    if (jsonString != null) {
      UserModel user = UserModel.fromJson(jsonString);
      return Future.value(user);
    } else {
      throw EmptyCacheException();
    }
  }
}
