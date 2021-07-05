import 'package:flutter/material.dart';
import 'package:notepad_demo/model/app_state_model.dart';
import 'package:notepad_demo/pages/category_menu_page.dart';
import 'package:notepad_demo/pages/product_list.dart';
import 'package:notepad_demo/pages/shopping_cart.dart';
import 'package:notepad_demo/style/colors.dart';
import 'package:notepad_demo/widgets/backdrop.dart';
import 'package:notepad_demo/widgets/card_button.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(builder: (
      BuildContext context,
      AppStateModel model,
      Widget child,
    ) {
      return ProductList(products: model.getProducts());
    });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  int _cuiIndex;

  @override
  void initState() {
    super.initState();
    _cuiIndex = 0;
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000), value: 0.0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Backdrop backdrop = Backdrop(
        frontLayer: ProductPage(),
        backLayer: CategoryMenuPage(),
        frontTitle: Text('首页'),
        backTitle: Text('菜单'),
        controller: _controller);
    return Scaffold(
      body: _cuiIndex == 0 ? backdrop : ShoppingCartPage(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ShoppingColors.green200,
        selectedItemColor: Colors.pink,
        onTap: (index) {
          setState(() {
            _cuiIndex = index;
          });
        },
        currentIndex: _cuiIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(
              icon: Consumer<AppStateModel>(
                builder:
                    (BuildContext context, AppStateModel model, Widget child) {
                  return CartButton(
                    itemCount: model.totalCartQuantity,
                  );
                },
              ),
              title: Text('购物车'))
        ],
      ),
    );
  }
}
