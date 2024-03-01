part of 'report_cubit.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object?> get props => [];
  List<Object?> get propsCustomer => [];
}

class ReportInitial extends ReportState {}

class ReportSuccess extends ReportState {
  final List<ReportListResponse> response;

  const ReportSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class ReportLoading extends ReportState {}

class ReportFailure extends ReportState {
  final String message;

  const ReportFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class GetCustomerInitial extends ReportState {}

class GetCustomerSuccess extends ReportState {
  final DataCustomerResponse response;

  const GetCustomerSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class GetCustomerLoading extends ReportState {}

class GetCustomerFailure extends ReportState {
  final String message;

  const GetCustomerFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class CreateLog extends ReportState {}

class CreateLogSuccess extends ReportState {}

class CreateLogLoading extends ReportState {}

class CreateLogFailure extends ReportState {
  final String message;
  const CreateLogFailure({required this.message});
  @override
  List<Object?> get props => [message];
}
