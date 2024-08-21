part of 'id_cash_cubit.dart';

abstract class IDCashState extends Equatable {
  const IDCashState();

  @override
  List<Object?> get props => [];
  List<Object?> get propsCustomer => [];
}

class IDCashInitial extends IDCashState {}

class IDCashSuccess extends IDCashState {
  final DataMemberCardResponse response;

  const IDCashSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class IDCashLoading extends IDCashState {}

class IDCashFailure extends IDCashState {
  final String message;

  const IDCashFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
