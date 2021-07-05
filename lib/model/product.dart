import 'package:flutter/foundation.dart';
//产品类别
enum Category {
  all, //全部
  digital, //数字产品
  clothing, //服装产品
  home, //家具产品
}

//产品属性
class Product {
  const Product({
    @required this.category,
    @required this.id,
    @required this.name,
    @required this.price,
  });

  final Category category;
  final int id;
  final String name;
  final int price;

  String get assetName => 'images/$id-0.jpg'; //产品名称

  @override
  String toString() => '$name(id=$id)';
}
