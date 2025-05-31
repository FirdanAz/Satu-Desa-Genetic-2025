import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:satu_desa/core/utils/local_data/local_data_persistance.dart';
import 'package:satu_desa/features/login/models/login_model.dart';
import 'package:satu_desa/features/login/service/api_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial());

  Future<void> postLogin({required String email, required String password}) async {
    try {
      emit(LoginState(status: LoginStateStatus.loading));
      await Future.delayed(Duration(milliseconds: 2000));
      LoginModel loginModel = await ApiService.postLogin(email, password);

      final LocalDataPersistance localDataPersistance = LocalDataPersistance();
      //await localDataPersistance.setBearerToken(loginModel.data.token);
      await localDataPersistance.setUserId(loginModel.data.user.id.toString());
      await localDataPersistance.setUserName(loginModel.data.user.name);
      await localDataPersistance.setUserEmail(loginModel.data.user.email);
      await localDataPersistance.setUserRole(loginModel.data.role);
      // await localDataPersistance.setUserPhone(loginModel.uPhone);

      emit(LoginState(status: LoginStateStatus.success, loginModel: loginModel));
    } catch (e) {
      if (kDebugMode) print("Something Wrong!!!");
      if (kDebugMode) print(e.toString());

      print('object');

      emit(LoginState(
        status: LoginStateStatus.failed,
        errorMessage: "Login Gagal ! Periksa Kembali"
      ));
    }
  }

}
