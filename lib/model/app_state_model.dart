import 'package:flutter/cupertino.dart';
import 'package:notepad_demo/model/product.dart';
import 'package:notepad_demo/model/products_repository.dart';

double _shippingConstPerItem = 7.0; //运费单价

class AppStateModel extends ChangeNotifier {
  List<Product> _availableProducts=<Product>[]; //可用商品列
  Category _selectedCategory = Category.all; //搜索状态的产品

  //购物车中的产品int代表产品id和数量
  final Map<int, int> _productsInCart = <int, int>{};

  Map<int, int> get productsInCart => Map<int, int>.from(_productsInCart);

  //计算购物车中的商品数量
  int get totalCartQuantity =>
      _productsInCart.values.fold(0, (int v, int e) => v + e);

  //获取搜索到的产品
  Category get selectedCategory => _selectedCategory;

  //计算购物车中的商品总价
  double get subtotalCost {
    double sum = 0;
    _productsInCart.keys
        .forEach((id) => sum += _productsInCart[id] * getProductById(id).price);
    return sum;
  }

  //计算购物车中商品的总运输费
  double get shippingCost {
    return totalCartQuantity * _shippingConstPerItem;
  }

  //计算购物车中商品和运输费的总和
  double get totalCost => subtotalCost + shippingCost;

  //获取商品方法
  List<Product> getProducts() {
    if (_availableProducts == null) {
      print('kong');
    }
    if (_selectedCategory == Category.all) {
      return List<Product>.from(_availableProducts);
    } else {
      return _availableProducts
          .where((Product p) => p.category == _selectedCategory)
          .toList();
    }
  }

  //将商品添加到购物车的方法
  void addProductToCart(int productId) {
    if (!_productsInCart.containsKey(productId)) {
      _productsInCart[productId] = 1;
    } else {
      _productsInCart[productId]++;
    }
    notifyListeners();
  }

  //删除购物车中商品的方法
  void removeItemFromCart(int productId) {
    if (_productsInCart.containsKey(productId)) {
      if (_productsInCart[productId] == 1) {
        _productsInCart.remove(productId);
      } else {
        _productsInCart[productId]--;
      }
    }
    notifyListeners();
  }

  //通过id获取商品
  Product getProductById(int id) {
    return _availableProducts.firstWhere((Product p) => p.id == id);
  }

  //通过搜索获取商品
  List<Product> getProductBySearch(String query) {
    return _availableProducts
        .where((Product p) => p.name.startsWith(query))
        .toList();
  }

  //清空购物车
  void clearCart() {
    _productsInCart.clear();
    notifyListeners();
  }

  //加载产品
  void loadProducts() {
    _availableProducts = ProductsRepository.loadProducts(Category.all);
    notifyListeners();
  }

  //设置商品类别
  void setCategory(Category newCategory) {
    _selectedCategory = newCategory;
    notifyListeners();
  }

  @override
  String toString() {
    return 'AppStateModel(totalCost:$totalCost)';
  }
}
