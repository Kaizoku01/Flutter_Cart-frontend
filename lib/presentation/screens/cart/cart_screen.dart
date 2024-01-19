import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/logic/services/calculations.dart';
import 'package:flutter_cart/logic/services/conversions.dart';
import 'package:flutter_cart/presentation/screens/order/order_details_screen.dart';
import 'package:flutter_cart/presentation/widgets/cart_list_view.dart';
import 'package:flutter_cart/presentation/widgets/link_button.dart';
import 'package:input_quantity/input_quantity.dart';
import '../../../core/ui.dart';
import '../../../logic/cubits/cart_cubit/cart_cubit.dart';
import '../../../logic/cubits/cart_cubit/cart_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const routeName = "cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
          if (state is CartLoadingState && state.items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CartErrorState && state.items.isEmpty) {
            return Center(
              child: Text(state.message),
            );
          }
          if(state is CartLoadedState && state.items.isEmpty){
            return const Center(child: Text("Cart items will show up here.."),);
          }
          return Column(
            children: [
              Expanded(
                child: CartListView(items: state.items),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${state.items.length} Items',
                            style: TextStyles.body1
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Total ${Conversion.formatPrice(
                              Calculations.cartTotal(state.items),
                            )}",
                            style: TextStyles.heading3,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: CupertinoButton(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 22),
                        color: AppColors.accent,
                        child: Text("Place Order"),
                        onPressed: () {
                          Navigator.pushNamed(context, OrderDetailScreen.routeName);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
