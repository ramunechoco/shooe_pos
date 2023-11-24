import 'package:flutter/material.dart';
import 'package:shooe_pos/commons/colors.dart';
import 'package:shooe_pos/order/models/get_clean_product_response.dart';
import 'package:shooe_pos/order/widgets/order_product_cell_widget.dart';

class OrderCategorySectionWidget extends StatelessWidget {
  final CleanProductCategoryModel category;

  const OrderCategorySectionWidget({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          category.categoryName,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16.0),
        if (category.comingSoonMessage != null)
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
            ),
            child: Text(
              category.comingSoonMessage ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: ShooeColor.mediumGrey,
              ),
            ),
          ),
        Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: category.products
              .map(
                (model) => OrderProductCellWidget(
                  model: model,
                  categoryId: category.id,
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 32.0),
      ],
    );
  }
}
