import 'package:flutter/material.dart';
import 'package:notepad_demo/model/app_state_model.dart';
import 'package:notepad_demo/model/product.dart';
import 'package:notepad_demo/pages/product_list.dart';
import 'package:notepad_demo/style/colors.dart';
import 'package:provider/provider.dart';

class ShoppingSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? IconButton(
              tooltip: 'Voice Search',
              onPressed: () {
                this.query = 'TODO: implement voice input';
              },
              icon: Icon(Icons.mic))
          : IconButton(
              tooltip: 'Clear',
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
              icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        this.close(context, null);
      },
      icon: Icon(Icons.arrow_back),
      tooltip: 'Back',
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
        primaryIconTheme:
            theme.primaryIconTheme.copyWith(color: ShoppingColors.brown900),
        primaryColorBrightness: Brightness.light,
        primaryTextTheme: theme.textTheme);
  }

  @override
  Widget buildResults(BuildContext context) {
    final TextStyle smallAmountStyle = Theme.of(context)
        .textTheme
        .body1
        .copyWith(color: ShoppingColors.brown600);
    final TextStyle largeAmountStyle = Theme.of(context).textTheme.display1;

    List<Product> results =
        Provider.of<AppStateModel>(context).getProductBySearch(this.query);
    return Column(
      children: [
        Text.rich(TextSpan(children: [
          TextSpan(text: '您搜索的关键词是：', style: smallAmountStyle),
          TextSpan(text: '$query', style: largeAmountStyle)
        ])),
        SizedBox(
          height: 20.0,
        ),
        Expanded(
            child: Container(
          height: 200.0,
          child: ProductList(
            products: results,
          ),
        ))
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subhead;
    List<String> suggestions = <String>[];
    suggestions = Provider.of<AppStateModel>(context)
        .getProductBySearch(this.query)
        .map((product) => product.name)
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        String suggestion = suggestions[index];
        return ListTile(
          title: RichText(
              text: TextSpan(
                  text: suggestion.substring(0, query.length),
                  style: textTheme.copyWith(fontWeight: FontWeight.bold),
                  children: [
                TextSpan(
                    text: suggestion.substring(query.length), style: textTheme)
              ])),
          onTap: () {
            this.query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}
