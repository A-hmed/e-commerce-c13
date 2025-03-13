import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/utils/api_state.dart';
import 'package:ecommerce_app/features/cart/presentaion/screens/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:ecommerce_app/features/product_details/presentation/screen/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late CartCubit cartCubit = BlocProvider.of(context);

  String truncateTitle(String title) {
    List<String> words = title.split(' ');
    if (words.length <= 4) {
      return title;
    } else {
      return "${words.sublist(0, 4).join(' ')}..";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ProductDetails(product: widget.product)));
      },
      child: SizedBox(
        width: 200.w,
        height: 280.h,
        child: Container(
          width: 280,
          margin: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: ColorManager.primary.withOpacity(0.8),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: CachedNetworkImage(
                      imageUrl: widget.product.imageCover ?? "",
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        truncateTitle(widget.product.title),
                        style: getMediumStyle(
                          color: ColorManager.primary,
                          fontSize: 16.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        truncateTitle(widget.product.description),
                        style: getRegularStyle(
                          color: ColorManager.primary,
                          fontSize: 14.sp,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "EGP ${widget.product.price}",
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: getRegularStyle(
                              color: ColorManager.primary,
                              fontSize: 14.sp,
                            ),
                          ),
                          // Text(
                          //   "${product.} EGP ",
                          //   style: getTextWithLine(),
                          // ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Reviews",
                                style: getRegularStyle(
                                  color: ColorManager.primary,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                "${widget.product.ratingsAverage}",
                                style: getRegularStyle(
                                  color: ColorManager.primary,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          buildCartButton(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell buildCartButton() {
    return InkWell(
      onTap: () {
        cartCubit.isInCart(widget.product.id)
            ? cartCubit.removeProduct(widget.product.id)
            : cartCubit.addProduct(widget.product.id);
      },
      child: BlocBuilder<CartCubit, ApiState>(builder: (context, state) {
        //todo: Fix me infinite rebuilding
        return cartCubit.isInCart(widget.product.id)
            ? buildRemoveIcon()
            : buildAddIcon();
      }),
    );
  }

  Icon buildAddIcon() {
    return Icon(
      Icons.add_circle_rounded,
      color: ColorManager.primary,
      size: 36,
    );
  }

  Icon buildRemoveIcon() {
    return Icon(
      Icons.remove_circle,
      color: ColorManager.primary,
      size: 36,
    );
  }
}
