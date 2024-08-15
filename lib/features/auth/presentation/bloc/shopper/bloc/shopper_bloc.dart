// ignore_for_file: depend_on_referenced_packages, type_literal_in_constant_pattern

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:party/features/auth/data/model/get_Pro_shopper.dart';

import '../../../../../../injection_container.dart';
import '../../../../data/data_sources/remote/shopper_api_service.dart';
part 'shopper_event.dart';
part 'shopper_state.dart';

class ShopperBloc extends Bloc<GetShopperEvent, GetShopperState> {
  ShopperBloc() : super(GetShopperInitial()) {
    on<GetShopperEvent>((event, emit) async {
      if (event is GetProShopperEvent) {
        emit(LoadingGetShopperState());

        GetProShopperModel proShopperModel =
            await sl<ShopperApiService>().getProShopper();
        print('bloc');
        emit(LoadedProGetShopperState(getProShopperModel: proShopperModel));
      } else if (event is RefreshProShopperEvent) {
        emit(LoadingGetShopperState());
        GetProShopperModel proShopperModel =
            await sl<ShopperApiService>().getProShopper();
        emit(LoadedProGetShopperState(getProShopperModel: proShopperModel));
      }
    });
  }
}
