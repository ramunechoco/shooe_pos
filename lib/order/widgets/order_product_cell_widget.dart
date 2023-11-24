import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shooe_pos/commons/colors.dart';
import 'package:shooe_pos/commons/utils/int_utils.dart';
import 'package:shooe_pos/order/cubits/order_cubit.dart';
import 'package:shooe_pos/order/models/get_clean_product_response.dart';

class OrderProductCellWidget extends StatelessWidget {
  final CleanProductDetailModel model;
  final String categoryId;

  const OrderProductCellWidget({
    Key? key,
    required this.model,
    required this.categoryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 120,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: ShooeColor.lightPurple,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                model.name,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 12.0, color: ShooeColor.darkGrey),
              ),
              const SizedBox(height: 2.0),
              Text(
                "${model.duration} | ${IntUtils.convertToRupiahCurrency(model.pricePerItem)} / item",
                style: const TextStyle(
                    fontSize: 11.0, color: ShooeColor.mediumGrey),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: model.quantity > 0
                        ? () {
                            context.read<OrderCubit>().changeQuantity(
                                  categoryId: categoryId,
                                  productId: model.id,
                                  quantity: model.quantity - 1,
                                  isService: true,
                                );
                          }
                        : null,
                    child: Container(
                      height: 22.0,
                      width: 26.0,
                      decoration: BoxDecoration(
                        color: model.quantity > 0
                            ? ShooeColor.lightGrey
                            : const Color(0xFFF4F4F4),
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "-",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: model.quantity > 0
                                  ? Colors.black
                                  : ShooeColor.mediumGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 42.0,
                    child: Text(
                      "${model.quantity}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        color: ShooeColor.darkGrey,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => context.read<OrderCubit>().changeQuantity(
                          categoryId: categoryId,
                          productId: model.id,
                          quantity: model.quantity + 1,
                          isService: true,
                        ),
                    child: Container(
                      height: 22.0,
                      width: 26.0,
                      decoration: BoxDecoration(
                        color: ShooeColor.lightGrey,
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "+",
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
