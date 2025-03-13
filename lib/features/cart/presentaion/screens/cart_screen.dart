import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/utils/api_state.dart';
import 'package:ecommerce_app/core/utils/dialog_utils.dart';
import 'package:ecommerce_app/features/cart/domain/Cart.dart';
import 'package:ecommerce_app/features/cart/presentaion/screens/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/cart/presentaion/widgets/cart_item_widget.dart';
import 'package:ecommerce_app/features/cart/presentaion/widgets/total_price_and_checkout_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartCubit cubit = BlocProvider.of(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: getMediumStyle(fontSize: 20, color: ColorManager.textColor),
        ),
        centerTitle: true,
      ),
      body: buildScreenBody(),
    );
  }

  Widget buildScreenBody() {
    return BlocConsumer<CartCubit, ApiState>(
        listener: (context, state) {
          if (state.hasError) {
            hideLoading(context);
            showMessage(context, state.errorMessage, posButtonTitle: "OK");
          }
          if (state.isSuccess) {
            hideLoading(context);
          }
          if (state.isLoading) {
            showLoading(context);
          }
        },
        bloc: cubit,
        builder: (context, state) {
          if ((state.isSuccess || state.isLoading) &&
              cubit.latestCart != null) {
            Cart cart = cubit.latestCart!;

            return Padding(
              padding: EdgeInsets.all(AppPadding.p14),
              child: Column(
                children: [
                  Expanded(
                    // the list of cart items ===============
                    child: ListView.separated(
                      itemBuilder: (context, index) => CartItemWidget(
                        imagePath: cart.products[index].imageCover,
                        title: cart.products[index].title,
                        price: cart.products[index].price.toDouble(),
                        quantity: cart.products[index].totalItemsInCart ?? 0,
                        onDeleteTap: () {
                          cubit.removeProduct(cart.products[index].id);
                        },
                        onDecrementTap: (quantity) {
                          cubit.updateProductQuantity(
                              cart.products[index].id, quantity);
                        },
                        onIncrementTap: (quantity) {
                          cubit.updateProductQuantity(
                              cart.products[index].id, quantity);
                        },
                        size: -1,
                        color: Colors.black,
                        colorName: 'Black',
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: AppSize.s12.h),
                      itemCount: cart.products.length,
                    ),
                  ),
                  // the total price and checkout button========
                  TotalPriceAndCheckoutButton(
                    totalPrice: cart.totalCartPrice,
                    checkoutButtonOnTap: () {},
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            );
          } else {
            return Text(state.errorMessage);
          }
        });
  }
}
