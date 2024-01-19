import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_cart/data/models/product/product_model.dart';
import 'package:flutter_cart/logic/cubits/cart_cubit/cart_state.dart';
import 'package:flutter_cart/logic/services/conversions.dart';
import 'package:flutter_cart/presentation/widgets/gap_widget.dart';
import 'package:flutter_cart/presentation/widgets/primary_button.dart';

import '../../../core/ui.dart';
import '../../../logic/cubits/cart_cubit/cart_cubit.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductDetailScreen({super.key, required this.productModel});

  static const String routeName = "product_details";

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.productModel.title}"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width,
              child: CarouselSlider.builder(
                slideBuilder: (index) {
                  String url = widget.productModel.images![index];

                  return CachedNetworkImage(
                    imageUrl: url,
                  );
                },
                itemCount: widget.productModel.images?.length ?? 0,
              ),
            ),
            const GapWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.productModel.title}",
                      style: TextStyles.heading3),
                  Text(
                    Conversion.formatPrice(widget.productModel.price!),
                    style: TextStyles.heading2,
                  ),
                  const GapWidget(),
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      bool isInCart = BlocProvider.of<CartCubit>(context)
                          .cartContains(widget.productModel);
                      return PrimaryButton(
                        color: isInCart
                            ? AppColors.text
                            : AppColors.accent,
                        text: isInCart
                            ? "Product added to cart"
                            : "Add to cart",
                        onPressed: () {
                          if (isInCart) {
                            return;
                          }
                          BlocProvider.of<CartCubit>(context)
                              .addToCart(widget.productModel, 1);
                        },
                      );
                    }
                  ),
                  const GapWidget(),
                  Text(
                    "Description",
                    style:
                        TextStyles.body2.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.productModel.description}",
                    style: TextStyles.body1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
