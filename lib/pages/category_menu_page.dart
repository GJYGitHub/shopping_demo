// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:notepad_demo/style/colors.dart';
import 'package:notepad_demo/model/app_state_model.dart';
import 'package:notepad_demo/model/product.dart';
import 'package:provider/provider.dart';

class CategoryMenuPage extends StatelessWidget {
  const CategoryMenuPage({
    Key key,
    this.onCategoryTap,
  }) : super(key: key);

  final VoidCallback onCategoryTap;

  String getChineseName(Category category) {
    switch (category) {
      case Category.all:
        return '所有商品';
      case Category.clothing:
        return '衣服/首饰/配件';
      case Category.digital:
        return '数码产品';
      case Category.home:
        return '居家';
    }
  }

  Widget _buildCategory(Category category, BuildContext context) {
    final String categoryString =
        category.toString().replaceAll('Category.', '').toUpperCase();
    final ThemeData theme = Theme.of(context);

    return Consumer<AppStateModel>(
      builder: (BuildContext context, AppStateModel model, Widget child) =>
          GestureDetector(
        onTap: () {
          model.setCategory(category);
          if (onCategoryTap != null) {
            onCategoryTap();
          }
        },
        child: model.selectedCategory == category
            ? Column(
                children: <Widget>[
                  const SizedBox(height: 16.0),
                  Text(
                    getChineseName(category),
                    style: theme.textTheme.body2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 14.0),
                  Container(
                    width: 70.0,
                    height: 2.0,
                    color: ShoppingColors.pink400,
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  getChineseName(category),
                  style: theme.textTheme.body2
                      .copyWith(color: ShoppingColors.brown900.withAlpha(153)),
                  textAlign: TextAlign.center,
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 40.0),
        color: ShoppingColors.green200,
        child: ListView(
          children: Category.values
              .map((Category c) => _buildCategory(c, context))
              .toList(),
        ),
      ),
    );
  }
}
