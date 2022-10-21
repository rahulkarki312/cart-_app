import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "screens/products_overview_page.dart";
import 'screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import '../providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import 'screens/edit_product_screen.dart';
import 'screens/auth_screen.dart';
import 'providers/auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
              create: (_) => Products("", "", []),
              update: (ctx, auth, previousProducts) => Products(
                  auth.token.toString(),
                  auth.userId.toString(),
                  previousProducts == null ? [] : previousProducts.items)),
          ChangeNotifierProvider(create: (_) => Cart()),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (_) => Orders("", []),
            update: (ctx, auth, previousOrders) => Orders(auth.token.toString(),
                previousOrders == null ? [] : previousOrders.orders),
          )
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: Colors.brown,
                accentColor: Color.fromARGB(255, 108, 150, 61),
                fontFamily: "Lato"),
            title: " ",
            home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
            routes: {
              ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
              CartScreen.routeName: (context) => CartScreen(),
              OrdersScreen.routeName: (context) => OrdersScreen(),
              UserProductsScreen.routeName: (context) => UserProductsScreen(),
              EditProductScreen.routeName: (context) => EditProductScreen()
            },
          ),
        ));
  }
}
