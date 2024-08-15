import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:party/core/strings/constans.dart';
import 'package:party/features/auth/presentation/bloc/get_user/get_user_bloc.dart';
import 'package:party/features/auth/presentation/bloc/post_put_delet_user/post_put_delet_user_bloc.dart';
import 'package:party/features/auth/presentation/pages/login_screen.dart';
import 'package:party/features/auth/presentation/pages/sing_up_page.dart';
import 'package:party/features/features_vendor/presentation/pages/cande/post_cande/add_sweet_cande.dart';
import 'package:party/features/features_vendor/presentation/pages/restaurant/post_restaurant/add_food_rest.dart';
import 'package:party/features/features_vendor/presentation/pages/restaurant/post_restaurant/post_restaurant.dart';
import 'package:party/features/hotel/presentation/pages/hotel/post_hotel/add_room_hotel.dart';
import 'package:party/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/app_theme.dart';
import 'features/auth/presentation/bloc/post_put_delet_shopper/post_put_delet_shopper_bloc.dart';
import 'features/features_vendor/presentation/pages/cande/post_cande/post_cande.dart';
import 'features/features_vendor/presentation/pages/posts/posts_page.dart/pageposts.dart';
import 'features/features_vendor/presentation/pages/shopper/MainScreenShopper.dart';
import 'features/features_vendor/presentation/pages/wedding_hall/post_wedding_hall/Wedding_Hall_Post.dart';
import 'features/features_vendor/presentation/pages/wedding_hall/post_wedding_hall/post_image_hospit.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    print(sl.get<SharedPreferences>().getString(CACHED_TYPE_SHOPPER));
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<GetUserBloc>()),
          BlocProvider(create: (_) => di.sl<PostPutDeletUserBloc>()),
          BlocProvider(create: (_) => di.sl<PostPutDeletShopperBloc>()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            title: 'Posts App',
            home:
                //  di.sl.get<SharedPreferences>().getString(CACHED_Token) == null
                // Pageviewhotel()
                // PostRestaurant()
                // AddPostScreen()
                // WeddingHallPost()
                // AddRoomHotel()
                // LoginPage()
                MainScreen()
            // PostImageHospit()
            // AddInfoShopper(
            //   title: 'asc',
            // )
            // : PostHotel()
            ));
  }
}
