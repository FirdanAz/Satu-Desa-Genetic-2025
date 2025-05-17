import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:satu_desa/core/utils/local_data/local_data_persistance.dart';
import 'package:satu_desa/features/splash/services/api_service.dart';

part 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(SplashScreenState.initial());

  Future<void> init() async {
    // Local Data Persistance
    await LocalDataPersistance.init();
    if (kDebugMode) print("Local Data Persistance Success");

    try {
      // Check Token
      bool isValid = await _checkToken();
      if (kDebugMode) print("Check Token Success");

      if (isValid) {
        emit(SplashScreenState(status: SplashScreenStateStatus.loggedIn));
      } else {
        emit(SplashScreenState(status: SplashScreenStateStatus.loggedOut));
      }
    } catch (e) {
      if (kDebugMode) print(e);
      emit(SplashScreenState(
        status: SplashScreenStateStatus.failed,
      ));
    }
  }

  Future<bool> _checkToken() async {
    String? token = LocalDataPersistance().getBearerToken();
    if (token == null || token.isEmpty) return false;

    return await ApiService.tokenValidate(token);
  }
}
