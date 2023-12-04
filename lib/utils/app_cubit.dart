import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myactivity_project/cubit/login/login_cubit.dart';
import 'package:myactivity_project/cubit/surat_jalan/surat_jalan_cubit.dart';

class AppCubit {
  Widget initCubit(Widget widget) {
    return MultiBlocProvider(providers: [
      BlocProvider<LoginCubit>(
        create: (BuildContext context) => LoginCubit(),
      ),
      BlocProvider<SuratJalanCubit>(
        create: (BuildContext context) => SuratJalanCubit(),
      ),
    ], child: widget);
  }
}
