import 'package:equatable/equatable.dart';
import 'package:shooe_pos/order/models/get_clean_product_response.dart';

class OrderState extends Equatable {
  final String customerName;
  final String customerPhone;
  final String customerId;
  final bool isLoading;
  final GetCleanProductResponse? services;
  final GetCleanProductResponse? physicalProducts;
  final String errorMessage;
  final int totalPrice;
  final int totalDiscount;
  final int finalPrice;
  final String paymentMethod;
  final String? phoneErrorMessage;

  const OrderState({
    this.customerName = "",
    this.customerPhone = "",
    this.customerId = "",
    this.isLoading = true,
    this.services,
    this.physicalProducts,
    this.errorMessage = "",
    this.totalPrice = 0,
    this.totalDiscount = 0,
    this.finalPrice = 0,
    this.paymentMethod = "",
    this.phoneErrorMessage,
  });

  OrderState copy({
    String? customerName,
    String? customerPhone,
    String? customerId,
    bool? isLoading,
    GetCleanProductResponse? services,
    GetCleanProductResponse? physicalProducts,
    String? errorMessage,
    int? totalPrice,
    int? totalDiscount,
    int? finalPrice,
    String? paymentMethod,
    String? phoneErrorMessage,
  }) {
    return OrderState(
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      customerId: customerId ?? this.customerId,
      isLoading: isLoading ?? this.isLoading,
      services: services ?? this.services,
      physicalProducts: physicalProducts ?? this.physicalProducts,
      errorMessage: errorMessage ?? this.errorMessage,
      totalPrice: totalPrice ?? this.totalPrice,
      totalDiscount: totalDiscount ?? this.totalDiscount,
      finalPrice: finalPrice ?? this.finalPrice,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      phoneErrorMessage: phoneErrorMessage ?? this.phoneErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        customerName,
        customerPhone,
        customerId,
        isLoading,
        physicalProducts,
        services,
        errorMessage,
        totalPrice,
        totalDiscount,
        finalPrice,
        paymentMethod,
        phoneErrorMessage,
      ];
}
