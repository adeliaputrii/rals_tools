import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:myactivity_project/data/model/lspb_form_body.dart';
import 'package:myactivity_project/data/model/lspb_form_response.dart';
import 'package:myactivity_project/data/model/lspb_type_doc_response.dart';
import 'package:myactivity_project/data/model/lspb_view_response.dart';
import 'package:myactivity_project/data/repository/lspb_repository.dart';

part 'lspb_state.dart';

class LspbCubit extends Cubit<LspbState> {
  LspbCubit() : super(LspbInitial());
  final LspbRepositories repositories = LspbRepositories();
  final _repo = LspbRepositories();

 void postFormLspb(String token, LspbFormBody body) async {
    emit(LspbLoading());
    try {
      await repositories.postFormLspb(token, body).then((value) {
        if (value!.isSuccess && value.dataResponse is LspbFormResponse) {
          final res = value.dataResponse as LspbFormResponse;
          emit(LspbSuccess(res));
          debugPrint('Success' + res.toString());
        } else {
          emit(LspbFailure(message: value.dataResponse!));
          debugPrint('Failed' + value.dataResponse);
        }
      });
    } catch (e) {
      emit(LspbFailure(message: "Harap coba lagi..."));
    }
  } 

  void getTypeDoc(String token, String scan_dokumen, String user) async {
    emit(LspbLoading());
    try {
      await repositories.getTypeDoc(token, scan_dokumen, user).then((value) {
        if (value!.isSuccess && value.dataResponse is LspbTypeDocResponse) {
          final res = value.dataResponse as LspbTypeDocResponse;
          emit(LspbGetTypeSuccess(res));
          debugPrint('Success' + res.toString());
        } else {
          emit(LspbFailure(message: value.dataResponse!));
          debugPrint('Failed' + value.dataResponse);
        }
      });
    } catch (e) {
      emit(LspbFailure(message: "Harap coba lagi..."));
    }
  } 

  void getViewResquest(String token, String scan_dokumen, String user, String store) async {
    emit(LspbLoading());
    try {
      await repositories.getViewResquest(token, scan_dokumen, user, store).then((value) {
        if (value!.isSuccess && value.dataResponse is LspbViewRequestResponse) {
          final res = value.dataResponse as LspbViewRequestResponse;
          emit(LspbViewSuccess(res));
          debugPrint('Success' + res.toString());
        } else {
          emit(LspbFailure(message: value.dataResponse!));
          debugPrint('Failed' + value.dataResponse);
        }
      });
    } catch (e) {
      emit(LspbFailure(message: "Harap coba lagi..."));
    }
  } 
}
