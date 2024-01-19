import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';
import '../../core/ui.dart';
import '../../data/models/cart/cart_model.dart';
import '../../logic/cubits/cart_cubit/cart_cubit.dart';
import '../../logic/services/conversions.dart';
import 'link_button.dart';

class CartListView extends StatelessWidget {
  final List<CartItemModel> items;
  final bool shrinkWrap;
  final bool noScroll;
  const CartListView(
      {super.key,
      required this.items,
      this.shrinkWrap = false,
      this.noScroll = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      physics: noScroll ? const NeverScrollableScrollPhysics() : null,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final cartItem = items[index];
        return ListTile(
          leading:
              CachedNetworkImage(imageUrl: cartItem.product!.images!.first,),
          title: Text(cartItem.product!.title.toString(),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${Conversion.formatPrice(cartItem.product!.price!)} x ${cartItem.quantity} = ${Conversion.formatPrice(cartItem.product!.price! * cartItem.quantity!)}",
              ),
              LinkButton(
                text: "Delete",
                onPressed: () {
                  BlocProvider.of<CartCubit>(context)
                      .removeFromCart(cartItem.product!);
                },
                color: Colors.red,
              ),
            ],
          ),
          trailing: InputQty(
            maxVal: 99,
            initVal: cartItem.quantity!,
            minVal: 1,
            qtyFormProps: const QtyFormProps(enableTyping: false),
            onQtyChanged: (value) {
              BlocProvider.of<CartCubit>(context)
                  .addToCart(cartItem.product!, value.toInt());
            },
          ),
        );
      },
    );
  }
}
