part of 'check_price_cubit.dart';

abstract class CheckPriceState extends Equatable {
  const CheckPriceState();

  @override
  List<Object?> get props => [];
  List<Object?> get propsCustomer => [];
}

class CheckPriceInitial extends CheckPriceState {}

class CheckPriceSuccess extends CheckPriceState {
  final CheckPriceResponse response;

  const CheckPriceSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class CheckPriceNewsSuccess extends CheckPriceState {
  final CheckPriceResponse response;

  const CheckPriceNewsSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class CheckPriceLoading extends CheckPriceState {}

class CheckPriceFailure extends CheckPriceState {
  final String message;

  const CheckPriceFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
