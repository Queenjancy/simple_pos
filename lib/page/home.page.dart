import 'package:evlogy_supply/bloc/event/home.event.dart';
import 'package:evlogy_supply/bloc/home.bloc.dart';
import 'package:evlogy_supply/bloc/state/home.state.dart';
import 'package:evlogy_supply/config/color.config.dart';
import 'package:evlogy_supply/model/category.mode.dart';
import 'package:evlogy_supply/model/product.mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc;

  List<Category> _categories = [];
  List<Product> _products = [];

  List<Product> _filterProducts;

  int _mode = 0;

  @override
  void initState() {
    _homeBloc = HomeBloc();

    _categories = [
      Category('1', 'Vans', null),
      Category('2', 'Converse', null)
    ];

    _products = [
      Product('1', '1', 'Oldskool Black White', 'Global Release',
          'assets/logo/ic_os_bw_g.jpg', '750.000'),
      Product('2', '1', 'Slipon Checkerboard', 'Global Release',
          'assets/logo/ic_so_g.jpg', '700.000'),
    ];

    super.initState();
  }

  @override
  void dispose() {
    _homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder(
      bloc: _homeBloc,
      builder: (context, HomeState state) {
        if (state is CategorySelectedState) {
          _filterProducts = state.products;
        }

        if (state is ChangeProductState) {
          _mode = state.mode;
        }

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                AppColors.primaryColor[500],
                AppColors.primaryColor[600],
                AppColors.primaryColor[700],
                AppColors.primaryColor[800],
              ],
            ),
          ),
          child: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 32.0,
                    ),
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 24.0,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Kategori',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8.0),
                      height: 40.0,
                      alignment: Alignment.center,
                      child: ListView.builder(
                        itemBuilder: (context, position) {
                          Category category = _categories[position];
                          return Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                right: position == (_categories.length - 1)
                                    ? 0.0
                                    : 8.0),
                            child: RaisedButton(
                              onPressed: () {
                                _categorySelectHandler(position);
                              },
                              color: AppColors.skyBlueColor,
                              splashColor: AppColors.primaryColor,
                              padding: EdgeInsets.symmetric(horizontal: 48.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0))),
                              child: Text(
                                category.title,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          );
                        },
                        itemCount: _categories.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Produk',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: <Widget>[
                              InkWell(
                                child: Image.asset('assets/logo/ic_columns.png',
                                    width: 24.0,
                                    height: 24.0,
                                    color: _mode == 0
                                        ? AppColors.skyBlueColor
                                        : Colors.white),
                                onTap: () {
                                  _homeBloc
                                      .dispatch(ChangeProductEvent(mode: 0));
                                },
                              ),
                              Container(
                                width: 8.0,
                              ),
                              InkWell(
                                child: Image.asset('assets/logo/ic_list.png',
                                    width: 24.0,
                                    height: 24.0,
                                    color: _mode == 1
                                        ? AppColors.skyBlueColor
                                        : Colors.white),
                                onTap: () {
                                  _homeBloc
                                      .dispatch(ChangeProductEvent(mode: 1));
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    _generateProductView()
                  ],
                ),
              ),
            ],
          )),
        );
      },
    ));
  }

  _categorySelectHandler(int pos) {
    String id = _categories[pos].id;
    _homeBloc.dispatch(CategorySelectedEvent(id: id, products: _products));
  }

  _generateProductView() {
    if (_filterProducts == null || _filterProducts.length == 0) {
      return Container(
        height: 250.0,
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            _filterProducts == null
                ? 'Pilih Kategori Terlebih Dahulu'
                : 'Produk Kosong',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w600),
          ),
        ),
      );
    } else {
      if (_mode == 0) {
        return Container(
          margin: EdgeInsets.only(top: 8.0),
          height: 250.0,
          child: ListView.builder(
            itemBuilder: (context, position) {
              Product product = _filterProducts[position];
              return _generateProductCard(
                  product.name,
                  product.sub_name,
                  product.photo_url,
                  product.price,
                  position == (_filterProducts.length - 1));
            },
            itemCount: _filterProducts.length,
            scrollDirection: Axis.horizontal,
          ),
        );
      } else {
        return Container(
          margin: EdgeInsets.only(top: 8.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, position) {
              Product product = _filterProducts[position];
              return _generateProductList(
                  product.name,
                  product.sub_name,
                  product.photo_url,
                  product.price,
                  position == (_filterProducts.length - 1));
            },
            itemCount: _filterProducts.length,
            scrollDirection: Axis.vertical,
          ),
        );
      }
    }
  }

  _generateProductCard(String name, String subname, String photoUrl,
      String price, bool lastIndex) {
    return Container(
      height: 250.0,
      width: 200.0,
      margin: EdgeInsets.only(right: lastIndex ? 0.0 : 16.0),
      decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)))),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset(
            photoUrl,
            width: 180.0,
            height: 180.0,
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            height: 250.0,
            width: 200.0,
            decoration: ShapeDecoration(
                color: Color(0xACffffff),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Text(
                        subname,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Rp $price',
                  style: TextStyle(
                      color: AppColors.skyBlueColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _generateProductList(String name, String subname, String photoUrl,
      String price, bool lastIndex) {
    return Container(
        margin: EdgeInsets.only(top: 1.0),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Image.asset(
              photoUrl,
              width: 84.0,
              height: 84.0,
            ),
            Container(
              width: 12.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        subname,
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Text(
                          'Rp $price',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: AppColors.skyBlueColor),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }
}
