import 'dart:convert';

String addToOrderToJson(ConfirmModel data) => json.encode(data.toJson());
class ConfirmModel {
  String userId;
  String image;
  String name;
  String productId;
  int quantity;
  String deliveryStatus;
  String paymentStatus;
  String total;

  ConfirmModel(
      {required this.userId,
        required this.image,
        required this.name,
        required this.productId,
        required this.quantity,
        required this.deliveryStatus,
        required this.paymentStatus,
        required this.total});



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['image'] = this.image;
    data['name'] = this.name;
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    data['delivery_status'] = this.deliveryStatus;
    data['payment_status'] = this.paymentStatus;
    data['total'] = this.total;
    return data;
  }
}

