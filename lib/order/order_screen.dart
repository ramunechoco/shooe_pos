import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shooe_pos/commons/colors.dart';
import 'package:shooe_pos/commons/utils/int_utils.dart';
import 'package:shooe_pos/commons/widgets/shooe_button.dart';
import 'package:shooe_pos/commons/widgets/shooe_text_field.dart';
import 'package:shooe_pos/order/cubits/order_cubit.dart';
import 'package:shooe_pos/order/cubits/order_state.dart';
import 'package:shooe_pos/order/widgets/order_category_section_widget.dart';
import 'package:shooe_pos/order/widgets/order_confirmation_dialog_widget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final paymentMethods = ["BCA", "QRIS", "Tunai"];
    return BlocProvider(
        create: (context) => OrderCubit(context)
          ..getServices()
          ..getProducts(),
        child: BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
          final cubit = context.read<OrderCubit>();

          return Scaffold(
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4.0,
                    offset: const Offset(0.0, -4.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Total Biaya Awal",
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                      Text(
                        IntUtils.convertToRupiahCurrency(
                          state.totalPrice,
                        ),
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: ShooeColor.purple,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Potongan",
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                      Text(
                        IntUtils.convertToRupiahCurrency(
                          -state.totalDiscount,
                        ),
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: ShooeColor.red,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  const Divider(height: 1.0, color: ShooeColor.lightGrey),
                  const SizedBox(height: 12.0),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Total Biaya Akhir",
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        IntUtils.convertToRupiahCurrency(
                          state.finalPrice,
                        ),
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: ShooeColor.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  SafeArea(
                    child: ShooeButton(
                      onPressed: state.totalPrice == 0 ||
                              state.customerName.isEmpty ||
                              state.customerPhone.isEmpty ||
                              state.paymentMethod.isEmpty
                          ? null
                          : () {
                              // cubit.chargePayment();
                              var orders = cubit.getCheckoutOrdersModel();
                              showDialog(
                                  context: context,
                                  builder: (_) => BlocProvider.value(
                                      value:
                                          BlocProvider.of<OrderCubit>(context),
                                      child: OrderConfirmationDialogWidget(
                                          orders: orders)));
                            },
                      title: "Konfirmasi",
                      backgroundGradient: ShooeColor.mainGradient,
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShooeTextField(
                        title: "Nama",
                        placeholder: "Nama customer",
                        isMandatory: true,
                        onValueChanged: cubit.changeName),
                    ShooeTextField(
                        title: "No. WA",
                        placeholder: "Nomor WA customer",
                        isMandatory: true,
                        onValueChanged: cubit.changePhone),
                    ShooeTextField(
                        title: "ID Shooe",
                        placeholder: "ID Shooe customer",
                        isMandatory: true,
                        onValueChanged: cubit.changeId),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Metode Pembayaran",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: ShooeColor.darkGrey,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: paymentMethods
                                .map(
                                  (value) => InkWell(
                                    onTap: () {
                                      cubit.changePaymentMethod(value);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                        vertical: 6.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            cubit.state.paymentMethod == value
                                                ? ShooeColor.purple
                                                : Colors.white,
                                        border: Border.all(
                                          color: ShooeColor.purple,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Text(
                                        value,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color:
                                              cubit.state.paymentMethod == value
                                                  ? Colors.white
                                                  : ShooeColor.purple,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ]),
                    const SizedBox(height: 32.0),
                    const Center(
                      child: Text(
                        "Jasa",
                        style: TextStyle(
                          fontSize: 28.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Column(
                      children: [
                        ...(state.services?.categories ?? []).map(
                          (category) => OrderCategorySectionWidget(
                            category: category,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32.0),
                    const Center(
                      child: Text(
                        "Produk",
                        style: TextStyle(
                          fontSize: 28.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
