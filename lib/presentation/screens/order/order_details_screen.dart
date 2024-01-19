import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/data/models/order/order_model.dart';
import 'package:flutter_cart/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:flutter_cart/logic/cubits/cart_cubit/cart_state.dart';
import 'package:flutter_cart/logic/cubits/order_cubit/order_cubit.dart';
import 'package:flutter_cart/logic/cubits/user_cubit/user_cubit.dart';
import 'package:flutter_cart/logic/cubits/user_cubit/user_state.dart';
import 'package:flutter_cart/presentation/screens/order/order_placed_screen.dart';
import 'package:flutter_cart/presentation/screens/order/providers/order_detail_provider.dart';
import 'package:flutter_cart/presentation/screens/user/edit_profile.dart';
import 'package:flutter_cart/presentation/widgets/cart_list_view.dart';
import 'package:flutter_cart/presentation/widgets/gap_widget.dart';
import 'package:flutter_cart/presentation/widgets/link_button.dart';
import 'package:flutter_cart/presentation/widgets/primary_button.dart';
import 'package:provider/provider.dart';

import '../../../core/ui.dart';
import '../../../data/models/user/user_model.dart';
import '../../../logic/services/razorpay.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  static const String routeName = "order_detail";
  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Orders"),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            BlocBuilder<UserCubit, UserState>(builder: (context, state) {
              if (state is UserLoadingState) {
                return const CircularProgressIndicator();
              }
              if (state is UserLoggedInState) {
                UserModel user = state.userModel;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User Details",
                      style: TextStyles.body2
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const GapWidget(),
                    Text(
                      "${user.fullName}",
                      style: TextStyles.heading3,
                    ),
                    Text(
                      "Email: ${user.email}",
                      style: TextStyles.body2,
                    ),
                    Text(
                      "Phone: ${user.phoneNumber}",
                      style: TextStyles.body2,
                    ),
                    Text(
                      "Address: ${user.address}, ${user.city}, ${user.state}",
                      style: TextStyles.body2,
                    ),
                    LinkButton(
                      text: "Edit Profile",
                      onPressed: () {
                        Navigator.pushNamed(
                            context, EditProfileScreen.routeName);
                      },
                    ),
                  ],
                );
              }

              if (state is UserErrorState) {
                return Text(state.message);
              }

              return const SizedBox();
            }),
            GapWidget(size: 10),
            Text(
              "Items",
              style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),
            ),
            const GapWidget(),
            BlocBuilder<CartCubit, CartState>(builder: (context, state) {
              if (state is CartLoadingState && state.items.isEmpty) {
                return const CircularProgressIndicator();
              }

              if (state is CartErrorState && state.items.isEmpty) {
                return Text(state.message);
              }
              return CartListView(
                items: state.items,
                shrinkWrap: true,
                noScroll: true,
              );
            }),
            GapWidget(size: 10),
            Text(
              "Payment",
              style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),
            ),
            const GapWidget(),
            Consumer<OrderDetailProvider>(builder: (context, provider, child) {
              return Column(
                children: [
                  RadioListTile(
                    value: "pay-on-delivery",
                    groupValue: provider.paymentMethod,
                    onChanged: provider.changePaymentMethod,
                    title: const Text("Pay on Delivery"),
                    contentPadding: EdgeInsets.zero,
                  ),
                  RadioListTile(
                    value: "pay-now",
                    groupValue: provider.paymentMethod,
                    onChanged: provider.changePaymentMethod,
                    title: const Text("Pay Now"),
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              );
            }),
            GapWidget(),
            PrimaryButton(
              text: "Place Order",
              onPressed: () async {
                OrderModel? newOrder =
                    await BlocProvider.of<OrderCubit>(context).createOrder(
                        items: BlocProvider.of<CartCubit>(context).state.items,
                        paymentMethod: Provider.of<OrderDetailProvider>(context,
                                listen: false)
                            .paymentMethod
                            .toString());

                if (newOrder == null) return;

                //payment gateway trigger
                if (newOrder.status == "payment-pending") {
                  await RazorPayService.checkoutOrder(newOrder,
                      onSuccess: (response) async {
                    newOrder.status = "order-placed";
                    bool success = await BlocProvider.of<OrderCubit>(context)
                        .updateOrder(newOrder,
                            paymentId: response.paymentId,
                            signature: response.signature);

                    if (!success) {
                      log("Can't update the order!");
                      return;
                    }
                    if(!mounted) return;
                    Navigator.pushReplacementNamed(
                        context, OrderPlacedScreen.routeName);
                  }, onFailure: (response) {
                    log("Payment Failed");
                  });
                }

                //COD trigger
                if (newOrder.status == "order-placed") {
                  if(!mounted) return;
                  Navigator.pushReplacementNamed(
                      context, OrderPlacedScreen.routeName);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
