import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myactivity_project/data/model/scan_sj_response.dart';
import 'package:myactivity_project/data/model/track_sj_response.dart';

import '../../data/model/scan_sj_body.dart';
import '../../data/model/surat_jalan_response.dart';
import '../../data/repository/surat_jalan_repository.dart';

part 'surat_jalan_state.dart';

class SuratJalanCubit extends Cubit<SuratJalanState> {
  SuratJalanCubit() : super(SuratJalanInitial());

  final SuratJalanRepositories repositories = SuratJalanRepositories();

  final _repo = SuratJalanRepositories();

  void getScanTracking(String token, String noSJ) async {
    emit(SuratJalanLoading());
    try {
      await repositories.getScanTracking(token, noSJ).then((value) {
        if (value!.isSuccess && value.dataResponse is SuratJalanResponse) {
          final res = value.dataResponse as SuratJalanResponse;
          emit(SuratJalanSuccess(res));
          debugPrint('Success' + res.toString());
        } else {
          emit(SuratJalanFailure(message: value.dataResponse!));
          debugPrint('Failed' + value.dataResponse);
        }
      });
    } catch (e) {
      emit(SuratJalanFailure(message: "Harap coba lagi..."));
    }
  }

  void postTrackingSJ(String token, TrackingSJBody body, int trackType) async {
    emit(ScanSJLoading());
    await repositories.postTracking(token, body, trackType).then((value) {
      if (value.isSuccess && value.dataResponse is ScanSJResponse) {
        final res = value.dataResponse as ScanSJResponse;
        emit(ScanSJSuccess(res));
        debugPrint('Success' + res.toString());
      } else {
        emit(ScanSJFailure(message: value.dataResponse!));
        debugPrint('Failed' + value.dataResponse);
      }
    });
  }

  void trackSJ(String token, String noSJ) async {
    emit(ScanSJLoading());
    await repositories.trackSJ(token, noSJ).then((value) {
      if (value.isSuccess && value.dataResponse is TrackingSJResponse) {
        final res = value.dataResponse as TrackingSJResponse;
        emit(TrackSJSuccess(res));
        debugPrint('Success' + res.toString());
      } else {
        emit(TrackSJFailure(message: value.dataResponse!));
        debugPrint('Failed track sj' + value.dataResponse);
      }
    });
  }
}
