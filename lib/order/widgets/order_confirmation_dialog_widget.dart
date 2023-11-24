import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shooe_pos/commons/colors.dart';
import 'package:shooe_pos/commons/widgets/shooe_button.dart';
import 'package:shooe_pos/order/cubits/order_cubit.dart';
import 'package:shooe_pos/order/models/checkout_orders_input_model.dart';
import 'package:shooe_pos/order/widgets/checkout_payment_detail_widget.dart';

class OrderConfirmationDialogWidget extends StatelessWidget {
  final CheckoutOrdersInputModel orders;

  const OrderConfirmationDialogWidget({
    Key? key,
    required this.orders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrderCubit>();
    final state = cubit.state;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 80.0,
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Expanded(
                    child: Text(
                  "Konfirmasi Pesanan",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.close_rounded,
                    size: 24.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            if (orders.services.isNotEmpty) ...[
              const Text(
                "Jasa",
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: ShooeColor.darkGrey,
                ),
              ),
              const SizedBox(height: 8.0),
              ...(orders.services
                  .map(
                    (model) => CheckoutPaymentDetailWidget(
                      title: model.label,
                      amount: model.quantity,
                      totalPrice: model.quantity * model.price,
                    ),
                  )
                  .toList()),
            ],
            if (orders.products.isNotEmpty) ...[
              const Text(
                "Produk",
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: ShooeColor.darkGrey,
                ),
              ),
              const SizedBox(height: 8.0),
              ...(orders.products
                  .map(
                    (model) => CheckoutPaymentDetailWidget(
                      title: model.label,
                      amount: model.quantity,
                      totalPrice: model.quantity * model.price,
                    ),
                  )
                  .toList()),
            ],
            const SizedBox(height: 2.0),
            const Divider(
              height: 1.0,
              color: ShooeColor.mediumGrey,
            ),
            const SizedBox(height: 2.0),
            CheckoutPaymentDetailWidget(
              title: "Total Harga",
              totalPrice: state.totalPrice,
              isBold: true,
            ),
            const SizedBox(height: 8.0),
            SafeArea(
              child: SizedBox(
                width: 200.0,
                child: ShooeButton(
                  onPressed: state.totalPrice == 0
                      ? null
                      : () {
                          cubit.submitOrder();
                          Navigator.of(context).pop();
                        },
                  title: "Submit Order",
                  backgroundGradient: ShooeColor.mainGradient,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
