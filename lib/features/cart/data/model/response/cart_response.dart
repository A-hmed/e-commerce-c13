import 'package:ecommerce_app/core/network/base_response.dart';

import 'cart_dm.dart';

class CartResponse extends BaseResponse {
  CartResponse({
    this.status,
    this.numOfCartItems,
    this.cartId,
    this.cartDM,
  });

  CartResponse.fromJson(dynamic json) : super.fromJson(json) {
    status = json['status'];
    numOfCartItems = json['numOfCartItems'];
    cartId = json['cartId'];
    cartDM = json['data'] != null ? CartDM.fromJson(json['data']) : null;
  }

  String? status;
  num? numOfCartItems;
  String? cartId;
  CartDM? cartDM;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['numOfCartItems'] = numOfCartItems;
    map['cartId'] = cartId;
    if (cartDM != null) {
      map['data'] = cartDM?.toJson();
    }
    return map;
  }
}
