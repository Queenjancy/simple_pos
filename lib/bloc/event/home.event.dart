import 'package:evlogy_supply/model/product.mode.dart';
import 'package:meta/meta.dart';

abstract class HomeEvent {}

class SearchBarEvent extends HomeEvent {
  bool isSearching;

  SearchBarEvent({this.isSearching});
}

class SearchProductEvent extends HomeEvent {
  String name;
  List<Product> products;

  SearchProductEvent({this.name, this.products});
}

class CategorySelectedEvent extends HomeEvent {
  String id;
  List<Product> products;

  CategorySelectedEvent({@required this.id, @required this.products});

  @override
  String toString() {
    return 'CategorySelected{id: $id, products: $products}';
  }
}

class ChangeProductEvent extends HomeEvent {
  int mode;

  ChangeProductEvent({@required this.mode});
}
