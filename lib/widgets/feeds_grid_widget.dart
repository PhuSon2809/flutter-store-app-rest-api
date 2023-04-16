import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/model/products_model.dart';
import 'package:store_app/widgets/feeds_widget.dart';

class FeedsGridWidget extends StatelessWidget {
  const FeedsGridWidget({super.key, required this.productsList});

  final List<ProductsModel> productsList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 0.0,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider.value(
          value: productsList[index],
          child: const FeedsWidget(),
        );
      },
    );
  }
}
