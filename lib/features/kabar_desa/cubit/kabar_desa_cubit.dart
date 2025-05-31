import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satu_desa/core/utils/local_data/local_data_persistance.dart';
import 'package:satu_desa/features/kabar_desa/models/kabar_desa_model.dart';
import 'package:satu_desa/features/kabar_desa/services/api_service.dart';

part 'kabar_desa_state.dart';

class KabarDesaCubit extends Cubit<KabarDesaState> {
  KabarDesaModel? _originalKabarDesa;

  KabarDesaCubit() : super(KabarDesaState.initial());

  Future<void> getKabarDesa() async {
    emit(KabarDesaState(status: KabarDesaStatus.loading));
    try {
      String? bearerToken = LocalDataPersistance().getBearerToken();

      final kabarDesa = await ApiService.getKabarDesa(bearerToken!);
      _originalKabarDesa = kabarDesa;

      emit(KabarDesaState(
        status: KabarDesaStatus.success,
        kabarDesaModel: kabarDesa,
      ));
    } catch (e) {
      emit(KabarDesaState(
        status: KabarDesaStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  void searchKabarDesa(String query) {
    if (_originalKabarDesa == null) return;

    if (query.isEmpty) {
      emit(KabarDesaState(
        status: KabarDesaStatus.success,
        kabarDesaModel: _originalKabarDesa!,
      ));
    } else {
      final filteredList = _originalKabarDesa!.kabarDesa!
          .where((e) => e.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();

      final filteredModel = KabarDesaModel(
        kabarDesa: filteredList,
      );

      print(filteredModel.kabarDesa!.length);

      emit(KabarDesaState(
        status: KabarDesaStatus.success,
        kabarDesaModel: filteredModel,
      ));
    }
  }
}
