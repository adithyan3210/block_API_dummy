part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final UserModel userModel;
  const ProductsLoaded(this.userModel);
}

class ProductsError extends ProductsState {
  final String? message;
  const ProductsError(this.message);
}
