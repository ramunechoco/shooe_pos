class CheckoutOrdersInputModel {
  final List<CheckoutOrderDetailModel> services;
  final List<CheckoutOrderDetailModel> products;

  CheckoutOrdersInputModel({required this.services, required this.products});

  Map<String, dynamic> toJson() {
    return {
      "services": services
          .map(
            (order) => order.toJson(),
          )
          .toList(),
      "products": products
          .map(
            (order) => order.toJson(),
          )
          .toList(),
    };
  }
}

class CheckoutOrderDetailModel {
  final String id;
  final String label;
  final int price;
  final int quantity;

  CheckoutOrderDetailModel({
    required this.id,
    required this.label,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "label": label,
    };
  }
}
