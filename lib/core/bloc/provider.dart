import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satu_desa/features/aspiration/cubit/aspiration_cubit.dart';
import 'package:satu_desa/features/bayar_sampah/cubit/sampah_cubit.dart';
import 'package:satu_desa/features/dana_desa/cubit/dana_desa_cubit.dart';
import 'package:satu_desa/features/join_desa/cubit/join_desa_cubit.dart';
import 'package:satu_desa/features/kabar_desa/cubit/kabar_desa_cubit.dart';
import 'package:satu_desa/features/login/cubit/login_cubit.dart';
import 'package:satu_desa/features/register/cubit/register_cubit.dart';

class Provider {
  static providers() {
    return [
      BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
      BlocProvider<RegisterCubit>(create: (context) => RegisterCubit()),
      BlocProvider<SampahCubit>(create: (context) => SampahCubit()),
      BlocProvider<DanaDesaCubit>(create: (context) => DanaDesaCubit()),
      BlocProvider<AspirationCubit>(create: (context) => AspirationCubit()),
      BlocProvider<JoinDesaCubit>(create: (context) => JoinDesaCubit()),
      BlocProvider<KabarDesaCubit>(create: (context) => KabarDesaCubit()),
    ];
  }
}
