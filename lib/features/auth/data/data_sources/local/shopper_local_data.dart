import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../injection_container.dart' as di;
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/strings/constans.dart';
import '../../model/shopper_model.dart';

abstract class ShopperLocalData {
  Future<ShopperModel> getCachedProShopper();
  Future<Unit> cacheShoppers(ShopperModel shopperModel);
}

class ShopperLocalDataImpl implements ShopperLocalData {
  @override
  Future<Unit> cacheShoppers(ShopperModel shopperModel) {
    di.sl
        .get<SharedPreferences>()
        .setString(CACHED_PRO_Shopper, shopperModel.toJson());
    return Future.value(unit);
  }

  @override
  Future<ShopperModel> getCachedProShopper() {
    final jsonString =
        di.sl.get<SharedPreferences>().getString(CACHED_PRO_Shopper);
    if (jsonString != null) {
      ShopperModel shopper = ShopperModel.fromJson(jsonString);
      return Future.value(shopper);
    } else {
      throw EmptyCacheException();
    }
  }
}
