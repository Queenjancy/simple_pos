import 'package:bloc/bloc.dart';
import 'package:evlogy_supply/bloc/event/home.event.dart';
import 'package:evlogy_supply/bloc/state/home.state.dart';
import 'package:evlogy_supply/model/product.mode.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeInitialized();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is SearchBarEvent) {
      yield SearchBarState(isSearching: event.isSearching);
    } else if (event is SearchProductEvent) {
      List<Product> filterProducts = [];
      List<Product> products = event.products;

      products.forEach((product) {
        if (product.name.toLowerCase().contains(event.name.toLowerCase()))
          filterProducts.add(product);
      });

      print(filterProducts.length);

      yield SearchProductState(products: filterProducts);
    } else if (event is ChangeProductEvent) {
      yield ChangeProductState(mode: event.mode);
    } else if (event is CategorySelectedEvent) {
      List<Product> filterProducts = [];
      List<Product> products = event.products;

      products.forEach((product) {
        if (event.id == '0') {
          filterProducts.add(product);
        } else if (product.category_id == event.id) filterProducts.add(product);
      });

      yield CategorySelectedState(id: event.id, products: filterProducts);
    }
  }
}
