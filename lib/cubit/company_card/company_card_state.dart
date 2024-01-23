part of 'company_card_cubit.dart';

abstract class CompanyCardState extends Equatable {
  const CompanyCardState();

  @override
  List<Object?> get props => [];
  List<Object?> get propsCustomer => [];
}

class CompanyCardInitial extends CompanyCardState {}

class CompanyCardSuccess extends CompanyCardState {
  final CompanyCardResponse response;

  const CompanyCardSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class CompanyCardLoading extends CompanyCardState {}

class CompanyCardFailure extends CompanyCardState {
  final String message;

  const CompanyCardFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
