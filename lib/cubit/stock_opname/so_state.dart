part of 'so_cubit.dart';

abstract class  StockOpnameState extends Equatable {
  const  StockOpnameState();

  @override
  List<Object?> get props => [];
  List<Object?> get propsCustomer => [];
}

class  StockOpnameInitial extends  StockOpnameState {}

class  StockOpnameSuccess extends  StockOpnameState {
  final  StockOpnameResponse response;

  const  StockOpnameSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class  StockOpnameLoading extends  StockOpnameState {}

class  StockOpnameFailure extends  StockOpnameState {
  final String message;

  const  StockOpnameFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class  StockOpnameSubmitLoading extends  StockOpnameState {}

class  StockOpnameSubmitSuccess extends  StockOpnameState {
  final  StockOpnameSubmitResponse response;

  const  StockOpnameSubmitSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class  StockOpnameSubmitFailure extends  StockOpnameState {
  final String message;

  const  StockOpnameSubmitFailure({required this.message});

  @override
  List<Object?> get props => [message];
}