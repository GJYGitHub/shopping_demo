import 'package:flutter/material.dart';
import 'package:notepad_demo/model/app_state_model.dart';
import 'package:notepad_demo/model/product.dart';
import 'package:notepad_demo/utils/MoneyUtil.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key key, @required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Image imageWidget = Image.asset(
      product.assetName,
      width: 200.0,
      height: 200.0,
      fit: BoxFit.cover,
    );
    final snackBar = SnackBar(
      content: Text('已加入购物车'),
      action: SnackBarAction(label: '查看', onPressed: () {}),
    );

    return Consumer<AppStateModel>(
      builder: (
        BuildContext context,
        AppStateModel model,
        Widget child,
      ) {
        return GestureDetector(
          onTap: () {
            model.addProductToCart(product.id);
            Scaffold.of(context).showSnackBar(snackBar);
          },
          child: child,
        );
      },
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              imageWidget,
              SizedBox(
                height: 4.0,
              ),
              Text(
                product == null ? '' : product.name,
                style: theme.textTheme.button,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Container(
                child: Text(
                    product == null ? '' : MoneyUtil.withPrefix(product.price)),
              )
            ],
          ),
          Positioned(
            child: Icon(Icons.add_shopping_cart),
            top: 18.0,
            left: 10.0,
          )
        ],
      ),
    );
    return Container();
  }
}
