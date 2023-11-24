import 'package:flutter/material.dart';
import 'package:shooe_pos/commons/colors.dart';
import 'package:shooe_pos/commons/utils/int_utils.dart';

class CheckoutPaymentDetailWidget extends StatelessWidget {
  final String title;
  final int? amount;
  final int totalPrice;
  final bool isBold;

  const CheckoutPaymentDetailWidget({
    Key? key,
    required this.title,
    this.amount,
    required this.totalPrice,
    this.isBold = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "$title${amount != null ? " (${amount}x)" : ""}",
              style: TextStyle(
                fontSize: 12.0,
                color: totalPrice > 0 ? ShooeColor.darkGrey : ShooeColor.red,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Text(
            IntUtils.convertToRupiahCurrency(totalPrice),
            style: TextStyle(
              fontSize: 12.0,
              color: totalPrice > 0 ? ShooeColor.purple : ShooeColor.red,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }
}
