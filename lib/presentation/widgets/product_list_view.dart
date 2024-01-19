import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import '../../core/ui.dart';
import '../../data/models/product/product_model.dart';
import '../../logic/services/conversions.dart';
import '../screens/product/product_details_screen.dart';
import 'gap_widget.dart';

class ProductListView extends StatelessWidget {
  final List<ProductModel> products;
  const ProductListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return CupertinoButton(
            onPressed: () {
              Navigator.pushNamed(context, ProductDetailScreen.routeName,
                  arguments: product);
            },
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: product.images![0],
                  width: MediaQuery.of(context).size.width / 3,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${product.title}',
                        style: TextStyles.body1
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${product.description}",
                        style: TextStyles.body2
                            .copyWith(color: AppColors.textLight),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const GapWidget(),
                      Text(
                        Conversion.formatPrice(product.price!),
                        style: TextStyles.heading3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
