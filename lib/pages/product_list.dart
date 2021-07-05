import 'package:flutter/material.dart';
import 'package:notepad_demo/model/product.dart';
import 'package:notepad_demo/widgets/product_card.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key key, this.products}) : super(key: key);
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 0.7),
        itemBuilder: (context, int index) {
          return Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: ProductCard(product: products[index]),
          );
        });
  }
}
