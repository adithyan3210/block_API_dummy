import 'package:bloc/bloc.dart';
import 'package:blocproducts/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:blocproducts/model.dart';
part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetProductsList>((event, emit) async {
      try {
        emit(ProductsLoading());
        final mList = await _apiRepository.fetchCovidList();
        emit(ProductsLoaded(mList));
        if (mList.error != null) {
          emit(ProductsError(mList.error));
        }
      } on NetworkError {
        emit(const ProductsError(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
