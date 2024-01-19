import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/data/models/category/category_model.dart';
import 'package:flutter_cart/data/models/product/product_model.dart';
import 'package:flutter_cart/logic/cubits/product_cubit/product_state.dart';

import '../../../data/repositories/product_repository.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState()) {
    _initialize();
  }

  final _productRepository = ProductRepository();

  Future<void> _initialize() async {
    emit(ProductLoadingState(state.products));
    try {
      List<ProductModel> products = await _productRepository.fetchAllProducts();
      emit(ProductLoadedState(products));
    } catch (ex) {
      emit(ProductErrorState(ex.toString(), state.products));
    }
  }
}
