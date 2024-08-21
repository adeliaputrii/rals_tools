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

class ScanSjInitial extends SuratJalanState {}

class ScanSJSuccess extends SuratJalanState {
  final ScanSJResponse response;

  const ScanSJSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class ScanSJLoading extends SuratJalanState {}

class ScanSJFailure extends SuratJalanState {
  final String message;

  const ScanSJFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class TrackSJSuccess extends SuratJalanState {
  final TrackingSJResponse response;

  const TrackSJSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class TrackSJFailure extends SuratJalanState {
  final String message;

  const TrackSJFailure({required this.message});

  @override
  List<Object?> get props => [message];
}