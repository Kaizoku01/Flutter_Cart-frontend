import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/data/models/product/product_model.dart';
import '../../../data/models/category/category_model.dart';
import '../../../data/repositories/product_repository.dart';
import 'category_product_state.dart';

class CategoryProductCubit extends Cubit<CategoryProductState> {
  final CategoryModel categoryModel;
  final _productRepository = ProductRepository();
  CategoryProductCubit(this.categoryModel) : super(CategoryProductInitialState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    emit(CategoryProductLoadingState(state.products));
    try {
      final products = await _productRepository.fetchProductsByCategory(categoryModel.sId!);
      emit(CategoryProductLoadedState(products));
    } catch (ex) {
      emit(CategoryProductErrorState(ex.toString(), state.products));
    }
  }
}
