import 'package:ecommerce_app/core/utils/api_state.dart';
import 'package:ecommerce_app/features/cart/domain/Cart.dart';
import 'package:ecommerce_app/features/cart/domain/repository/cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartCubit extends Cubit<ApiState> {
  Cart? latestCart;

  final CartRepository _cartRepository;

  CartCubit(this._cartRepository) : super(IdleApiState());

  bool isInCart(String productId) {
    if (latestCart == null) return false;
    try {
      latestCart!.products.lastWhere((product) => product.id == productId);
      return true;
    } catch (e) {
      return false;
    }
  }

  int? getTotalItemsInCart(String productId) {
    if (latestCart == null) return null;
    try {
      var product =
          latestCart!.products.lastWhere((product) => product.id == productId);
      return product.totalItemsInCart;
    } catch (e) {
      return null;
    }
  }

  Future<void> getCart() async {
    emit(LoadingApiState());
    var result = await _cartRepository.getCart();
    if (result.hasData) {
      latestCart = result.data;
      emit(SuccessApiState<void>(null));
    } else {
      emit(ErrorApiState(result.error));
    }
  }

  Future<void> removeProduct(String id) async {
    emit(LoadingApiState());
    var result = await _cartRepository.removeProductToCart(id);
    if (result.hasData) {
      latestCart = result.data;
      emit(SuccessApiState<void>(null));
    } else {
      emit(ErrorApiState(result.error));
    }
  }

  Future<void> addProduct(String id) async {
    emit(LoadingApiState());
    var result = await _cartRepository.addProductToCart(id);
    if (result.hasData) {
      latestCart = result.data;
      emit(SuccessApiState<void>(null));
    } else {
      emit(ErrorApiState(result.error));
    }
  }

  Future<void> updateProductQuantity(String id, int quantity) async {
    emit(LoadingApiState());
    var result = await _cartRepository.updateProductQuantity(id, quantity);
    if (result.hasData) {
      latestCart = result.data;
      emit(SuccessApiState<void>(null));
    } else {
      emit(ErrorApiState(result.error));
    }
  }
}
