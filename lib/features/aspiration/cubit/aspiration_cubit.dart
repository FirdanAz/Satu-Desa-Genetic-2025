import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:satu_desa/core/utils/local_data/local_data_persistance.dart';
import 'package:satu_desa/features/aspiration/models/aspirasi_model.dart';
import 'package:satu_desa/features/aspiration/services/api_service.dart';

part 'aspiration_state.dart';

class AspirationCubit extends Cubit<AspirationState> {
  AspirationCubit() : super(AspirationState.initial());

  List<AspirasiModel> aspirasiModels = [];

  Future<void> getAspirasi() async {
    emit(AspirationState(status: AspirationStatus.loading));
    try {
      String? bearerToken = LocalDataPersistance().getBearerToken();

      aspirasiModels = await ApiService.getAspirasi(bearerToken!);
      print(aspirasiModels.length);

      emit(AspirationState(
          status: AspirationStatus.success, aspirasiModels: aspirasiModels));
    } catch (e) {
      if (kDebugMode) print(e);
      emit(AspirationState(
          status: AspirationStatus.failed, errorMessage: e.toString()));
    }
  }

  void filterItems(String query) {
    final filtered = aspirasiModels
        .where((item) =>
            item.user.id.toString().toLowerCase().contains(query.toLowerCase()))
        .toList();

    emit(AspirationState(
        aspirasiModels: aspirasiModels,
        aspirasiModelFilterMes: filtered,
        status: AspirationStatus.success));
  }

  Future<void> postAspirasi({
    required String judul,
    required String deskripsi,
    required String lokasi,
    required bool anonim,
    List<File>? images,
  }) async {
    emit(state.copyWith(status: AspirationStatus.loading));

    try {
      final bearerToken = LocalDataPersistance().getBearerToken();
      if (bearerToken == null) throw Exception("Token tidak ditemukan");
      print("Jumlah Gambar: ${images?.length}");
      for (var image in images ?? []) {
        print("Path Gambar: ${image.path}");
      }

      final success = await ApiService.postAspirasi(
        bearerToken: bearerToken,
        judul: judul,
        deskripsi: deskripsi,
        lokasi: lokasi,
        anonim: anonim,
        images: images,
      );

      if (success == true) {
        emit(state.copyWith(status: AspirationStatus.success));
      } else {
        emit(state.copyWith(
          status: AspirationStatus.failed,
          errorMessage: "Gagal mengirim aspirasi.",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AspirationStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> updateAspirasi({
    required int aspirasiId,
    required String judul,
    required String deskripsi,
    required String lokasi,
    required bool anonim,
    List<File>? newImages,
    List<int>? retainedImageIds, // ID gambar lama yang tetap dipertahankan
  }) async {
    emit(state.copyWith(status: AspirationStatus.loading));

    try {
      final bearerToken = LocalDataPersistance().getBearerToken();
      if (bearerToken == null) throw Exception("Token tidak ditemukan");

      final success = await ApiService.updateAspirasi(
        bearerToken: bearerToken,
        aspirasiId: aspirasiId,
        judul: judul,
        deskripsi: deskripsi,
        lokasi: lokasi,
        anonim: anonim,
        newImages: newImages,
        retainedImageIds: retainedImageIds,
      );

      if (success == true) {
        emit(state.copyWith(status: AspirationStatus.success));
      } else {
        emit(state.copyWith(
          status: AspirationStatus.failed,
          errorMessage: "Gagal memperbarui aspirasi.",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AspirationStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> deleteAspirasi({
    required int aspirasiId, // ID gambar lama yang tetap dipertahankan
  }) async {
    emit(state.copyWith(status: AspirationStatus.loading));

    try {
      final bearerToken = LocalDataPersistance().getBearerToken();
      if (bearerToken == null) throw Exception("Token tidak ditemukan");

      final success = await ApiService.deleteAspirasi(
        bearerToken: bearerToken,
        aspirasiId: aspirasiId,
      );

      if (success == true) {
        emit(state.copyWith(status: AspirationStatus.success));
        getAspirasi();
      } else {
        emit(state.copyWith(
          status: AspirationStatus.failed,
          errorMessage: "Gagal menghapus aspirasi.",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AspirationStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

   Future<void> deleteImageAspirasi({
    required int imageId, // ID gambar lama yang tetap dipertahankan
  }) async {

    try {
      final bearerToken = LocalDataPersistance().getBearerToken();
      if (bearerToken == null) throw Exception("Token tidak ditemukan");

      final success = await ApiService.deleteImageAspirasi(
        bearerToken: bearerToken,
        imageId: imageId,
      );

      if (success == true) {
      } else {
        emit(state.copyWith(
          status: AspirationStatus.failed,
          errorMessage: "Gagal menghapus aspirasi.",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AspirationStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }
}
