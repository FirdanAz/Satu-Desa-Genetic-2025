import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:satu_desa/features/register/services/api_service.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState.initial());

  Future<void> postRegister(
      {required String userName,
      required String email,
      required String password}) async {
    try {
      emit(RegisterState(status: RegisterStateStatus.loading));
      await Future.delayed(Duration(milliseconds: 2000));
      bool isRegistered =
          await ApiService.postRegister(userName, email, password);

      if (isRegistered) {
        emit(RegisterState(status: RegisterStateStatus.success));
      }
    } catch (e) {
      if (kDebugMode) print("Something Wrong!!!");
      if (kDebugMode) print(e.toString());

      print('object');

      emit(RegisterState(
          status: RegisterStateStatus.failed,
          errorMessage: "Register Gagal ! Periksa Kembali"));
    }
  }
}
