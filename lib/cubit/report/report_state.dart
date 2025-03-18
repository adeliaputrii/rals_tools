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

class ReportPaginationSuccess extends ReportState {
  final ReportListPaginationResponse response;

  const ReportPaginationSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class ReportSearchSuccess extends ReportState {
  final ReportListPaginationResponse response;

  const ReportSearchSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class getStoreSuccess extends ReportState {
  final List<SalesDataStoreResponse> data;

  const getStoreSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class ReportSalesSuccess extends ReportState {
  final List<SalesData> response;

  const ReportSalesSuccess(this.response);
  @override
  List<Object?> get props => [response];
}


class ReportgetDynamicSuccess extends ReportState {
  final List<ReportData> response;
  const ReportgetDynamicSuccess(this.response);

  @override
  List<Object?> get props => [response];
}


class ReportgetDynamicHeaderSuccess extends ReportState {
  final List<ReportDynamic> response;
  const ReportgetDynamicHeaderSuccess(this.response);

  @override
  List<Object?> get props => [response];
}



class SearchReportSales extends ReportState {
  final String query;

  SearchReportSales(this.query);

  @override
  List<Object?> get props => [query];
}

class ReportInsertViewerSuccess extends ReportState {
  final ReportListPaginationResponse response;
  const ReportInsertViewerSuccess(this.response);

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
