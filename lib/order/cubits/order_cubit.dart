import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shooe_pos/commons/api_fetching/api_fetching.dart';
import 'package:shooe_pos/commons/api_fetching/endpoints.dart';
import 'package:shooe_pos/commons/utils/string_utils.dart';
import 'package:shooe_pos/order/cubits/order_state.dart';
import 'package:shooe_pos/order/models/checkout_orders_input_model.dart';
import 'package:shooe_pos/order/models/get_clean_product_response.dart';

class OrderCubit extends Cubit<OrderState> {
  final BuildContext context;

  OrderCubit(this.context) : super(OrderState());

  void getServices() {
    emit(state.copy(
      isLoading: true,
      errorMessage: "",
    ));

    APIFetching.fetch(
      context,
      Endpoints.getCleanProducts,
      onSucccess: (response) {
        if (response.isSuccess) {
          emit(state.copy(
            isLoading: false,
            services: GetCleanProductResponse.fromJson(response.data ?? {}),
          ));
        } else {
          emit(state.copy(
            isLoading: false,
            errorMessage: response.message,
          ));
        }
      },
      onFailure: (error) {
        emit(state.copy(
          isLoading: false,
          errorMessage: error,
        ));
      },
    );
  }

  void getProducts() {
    emit(state.copy(
      isLoading: true,
      errorMessage: "",
    ));

    APIFetching.fetch(
      context,
      Endpoints.getPhysicalProducts,
      onSucccess: (response) {
        if (response.isSuccess) {
          emit(state.copy(
            isLoading: false,
            physicalProducts:
                GetCleanProductResponse.fromJson(response.data ?? {}),
          ));
        } else {
          emit(state.copy(
            isLoading: false,
            errorMessage: response.message,
          ));
        }
      },
      onFailure: (error) {
        emit(state.copy(
          isLoading: false,
          errorMessage: error,
        ));
      },
    );
  }

  void submitOrder() {
    emit(state.copy(isLoading: true, errorMessage: ""));

    var orders = getCheckoutOrdersModel();

    final params = {
      "whatsAppNumber": state.customerPhone,
      "name": state.customerName,
      "shooeId": state.customerId,
      "services": orders.services.map((model) => model.toJson()).toList(),
      "physicalProducts":
          orders.products.map((model) => model.toJson()).toList(),
      "paymentCategory": state.paymentMethod == "BCA"
          ? "VA"
          : state.paymentMethod == "BCA"
              ? "QRCODE"
              : "TUNAI",
      "paymentSubcategory": state.paymentMethod,
    };

    APIFetching.fetch(
      context,
      Endpoints.paymentCharge,
      params: params,
      onSucccess: (response) {
        if (response.isSuccess) {
          emit(state.copy(
            isLoading: false,
          ));
        } else {
          emit(state.copy(
            isLoading: false,
            errorMessage: response.message,
          ));
        }
      },
      onFailure: (error) {
        emit(state.copy(
          isLoading: false,
          errorMessage: error,
        ));
      },
    );
  }

  void changeQuantity(
      {required String categoryId,
      required String productId,
      required int quantity,
      required bool isService}) {
    if (isService) {
      emit(state.copy(
          services: state.services?.changeQuantity(
        categoryId,
        productId,
        quantity,
      )));
    } else {
      emit(state.copy(
          physicalProducts: state.physicalProducts?.changeQuantity(
        categoryId,
        productId,
        quantity,
      )));
    }
    var response = isService ? state.services : state.physicalProducts;
    var totalPrice = 0;
    var totalDiscount = 0;

    response?.categories.forEach((category) {
      var totalSelectedItems = 0;
      final numberOfItemsToGetFree = category.numberOfItemsToGetFree;
      final numberOfFreeItemPerMultiple = category.numberOfFreeItemPerMultiple;
      List<CleanProductDetailModel> choosenProducts = [];

      category.products.forEach((model) {
        if (model.quantity > 0) {
          totalPrice += model.pricePerItem * model.quantity;
          totalSelectedItems += model.quantity;
          choosenProducts.add(model);
        }
      });

      var totalFreeItems =
          (numberOfItemsToGetFree != null ? totalSelectedItems ~/ 4 : 0) *
              (numberOfFreeItemPerMultiple ?? 0);

      choosenProducts.sort(
        (product1, product2) => product1.pricePerItem.compareTo(
          product2.pricePerItem,
        ),
      );

      if (choosenProducts.isEmpty) {
      } else {
        choosenProducts.forEach((model) {
          if (model.quantity >= totalFreeItems) {
            totalDiscount += model.pricePerItem * totalFreeItems;

            totalFreeItems = 0;
          } else {
            totalDiscount += model.pricePerItem * model.quantity;

            totalFreeItems -= model.quantity;
          }
        });
      }
    });

    emit(state.copy(
      totalPrice: totalPrice,
      totalDiscount: totalDiscount,
      finalPrice: totalPrice - totalDiscount,
    ));
  }

  void changeName(String name) {
    emit(state.copy(
      customerName: name,
    ));
  }

  void changeId(String id) {
    emit(state.copy(
      customerId: id,
    ));
  }

  void changePaymentMethod(String paymentMethod) {
    emit(state.copy(
      paymentMethod: paymentMethod,
    ));
  }

  void changePhone(String phone) {
    var phoneErrorMessage = "";

    if (!StringUtils.isValidPhoneNumber(phone) && phone.isNotEmpty) {
      phoneErrorMessage = "Mohon cek format nomor WhatsApp anda.";
    }

    emit(state.copy(
      customerPhone: phone,
      phoneErrorMessage: phoneErrorMessage,
    ));
  }

  CheckoutOrdersInputModel getCheckoutOrdersModel() {
    List<CheckoutOrderDetailModel> services = [];
    List<CheckoutOrderDetailModel> physicalProducts = [];

    state.services?.categories.forEach((category) {
      category.products.forEach((model) {
        if (model.quantity > 0) {
          services.add(CheckoutOrderDetailModel(
            id: model.id,
            label: model.name,
            quantity: model.quantity,
            price: model.pricePerItem,
          ));
        }
      });
    });

    state.physicalProducts?.categories.forEach((category) {
      category.products.forEach((model) {
        if (model.quantity > 0) {
          physicalProducts.add(CheckoutOrderDetailModel(
            id: model.id,
            label: model.name,
            quantity: model.quantity,
            price: model.pricePerItem,
          ));
        }
      });
    });

    return CheckoutOrdersInputModel(
        services: services, products: physicalProducts);
  }
}
