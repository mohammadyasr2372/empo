import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/strings/constans.dart';
import '../../../../../injection_container.dart';
import '../../model/admin_model.dart';

abstract class AdminLocalData {
  Future<AdminModel> getCachedProAdmin();
  Future<Unit> cacheAdmins(AdminModel adminModel);
}

class AdminLocalDataImpl implements AdminLocalData {
  @override
  Future<Unit> cacheAdmins(AdminModel adminModel) {
    sl
        .get<SharedPreferences>()
        .setString(CACHED_PRO_Admin, adminModel.toJson());
    return Future.value(unit);
  }

  @override
  Future<AdminModel> getCachedProAdmin() {
    final jsonString =
        sl.get<SharedPreferences>().getString(CACHED_PRO_Admin);
    if (jsonString != null) {
      AdminModel admin = AdminModel.fromJson(jsonString);
      return Future.value(admin);
    } else {
      throw EmptyCacheException();
    }
  }
}
