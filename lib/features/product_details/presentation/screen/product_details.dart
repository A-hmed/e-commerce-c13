import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/utils/api_state.dart';
import 'package:ecommerce_app/core/utils/dialog_utils.dart';
import 'package:ecommerce_app/core/widget/custom_elevated_button.dart';
import 'package:ecommerce_app/core/widget/product_counter.dart';
import 'package:ecommerce_app/features/cart/presentaion/screens/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:ecommerce_app/features/product_details/presentation/widgets/product_color.dart';
import 'package:ecommerce_app/features/product_details/presentation/widgets/product_description.dart';
import 'package:ecommerce_app/features/product_details/presentation/widgets/product_item.dart';
import 'package:ecommerce_app/features/product_details/presentation/widgets/product_label.dart';
import 'package:ecommerce_app/features/product_details/presentation/widgets/product_rating.dart';
import 'package:ecommerce_app/features/product_details/presentation/widgets/product_size.dart';
import 'package:ecommerce_app/features/product_details/presentation/widgets/product_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetails extends StatefulWidget {
  final Product product;

  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ///Lazy initialization
  late CartCubit cubit = BlocProvider.of(context);
  late int x = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, ApiState>(
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
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Product Details',
            style: getMediumStyle(color: ColorManager.appBarTitleColor)
                .copyWith(fontSize: 20.sp),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: ImageIcon(
                  AssetImage(IconsAssets.icSearch),
                  color: ColorManager.primary,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: ColorManager.primary,
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 50.h),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProductSlider(
                      items: widget.product.images
                          .map((image) => ProductItem(
                                imageUrl: image,
                              ))
                          .toList(),
                      initialIndex: 0),
                  SizedBox(
                    height: 24.h,
                  ),
                  ProductLabel(
                      productName: widget.product.title,
                      productPrice: 'EGP ${widget.product.price}'),
                  SizedBox(
                    height: 16.h,
                  ),
                  ProductRating(
                      productBuyers: widget.product.sold.toString(),
                      productRating:
                          '${widget.product.ratingsAverage} (${widget.product.ratingsQuantity})'),
                  SizedBox(
                    height: 16.h,
                  ),
                  ProductDescription(
                      productDescription: widget.product.description),
                  ProductSize(
                    size: const [35, 38, 39, 40],
                    onSelected: () {},
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text('Color',
                      style:
                          getMediumStyle(color: ColorManager.appBarTitleColor)
                              .copyWith(fontSize: 18.sp)),
                  ProductColor(color: const [
                    Colors.red,
                    Colors.blueAccent,
                    Colors.green,
                    Colors.yellow,
                  ], onSelected: () {}),
                  SizedBox(
                    height: 48.h,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Total price',
                            style: getMediumStyle(
                                    color: ColorManager.primary.withOpacity(.6))
                                .copyWith(fontSize: 18.sp),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Text('EGP 3,500',
                              style: getMediumStyle(
                                      color: ColorManager.appBarTitleColor)
                                  .copyWith(fontSize: 18.sp))
                        ],
                      ),
                      SizedBox(
                        width: 33.w,
                      ),
                      buildCartOptions()
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }

  Widget buildCartOptions() {
    return BlocBuilder(
        bloc: cubit,
        builder: (context, state) {
          return Expanded(
            child: cubit.isInCart(widget.product.id)
                ? ProductCounter(
                    add: (quantity) {
                      cubit.updateProductQuantity(widget.product.id, quantity);
                    },
                    remove: (quantity) {
                      cubit.updateProductQuantity(widget.product.id, quantity);
                    },
                    productCounter:
                        cubit.getTotalItemsInCart(widget.product.id) ?? 0 //???
                    )
                : CustomElevatedButton(
                    label: 'Add to cart',
                    onTap: () {
                      cubit.addProduct(widget.product.id);
                    },
                    prefixIcon: Icon(
                      Icons.add_shopping_cart_outlined,
                      color: ColorManager.white,
                    ),
                  ),
          );
        });
  }
}
