part of 'surat_jalan_cubit.dart';

abstract class SuratJalanState extends Equatable {
  const SuratJalanState();

  @override
  List<Object?> get props => [];
  List<Object?> get propsCustomer => [];
}

class SuratJalanInitial extends SuratJalanState {}

class SuratJalanSuccess extends SuratJalanState {
  final SuratJalanResponse response;

  const SuratJalanSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class SuratJalanLoading extends SuratJalanState {}

class SuratJalanFailure extends SuratJalanState {
  final String message;

  const SuratJalanFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
