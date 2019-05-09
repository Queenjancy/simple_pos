import 'package:evlogy_supply/model/product.mode.dart';
import 'package:meta/meta.dart';

abstract class HomeEvent {}

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
