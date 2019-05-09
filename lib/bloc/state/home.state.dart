import 'package:evlogy_supply/model/product.mode.dart';
import 'package:meta/meta.dart';

abstract class HomeState {}

class HomeInitialized extends HomeState {
  @override
  String toString() {
    return 'HomeInitialized{}';
  }
}

class CategorySelectedState extends HomeState {
  String id;
  List<Product> products;

  CategorySelectedState({@required this.id, @required this.products});

  @override
  String toString() {
    return 'CategorySelected{id: $id, products: $products}';
  }
}

class ChangeProductState extends HomeState {
  int mode;

  ChangeProductState({@required this.mode});

  @override
  String toString() {
    return 'ProductModeSelected{}';
  }
}