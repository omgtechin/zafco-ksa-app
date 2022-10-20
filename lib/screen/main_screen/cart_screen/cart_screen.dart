import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/app_bar.dart';
import '../../../../core/constant.dart';
import '../../../../screen/main_screen/cart_screen/widget/cart_button.dart';
import '../../../../screen/main_screen/cart_screen/widget/cart_product_card.dart';
import '../../../../screen/main_screen/cart_screen/widget/order_summary.dart';

import '../../../core/enum/connection_status.dart';
import '../../../core/enum/user_type.dart';
import '../../../core/routes.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/cart_provider.dart';
import '../../../widget/customer_selector.dart';
import '../../../widget/loading_idicator.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      var cart = Provider.of<CartProvider>(context, listen: false);
      var data = Provider.of<CartProvider>(context, listen: false);
      var auth = Provider.of<AuthProvider>(context, listen: false);
      if (auth.userDetail.customerId != -1) {
        data.loadCartPage(context: context);
      }
      cart.getCartCount(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, data, _) {
      if (Provider.of<AuthProvider>(context, listen: false)
              .userDetail
              .customerId ==
          -1) {
        return Scaffold(
          appBar: getAppBar(
              title: Text(
                "Checkout",
                style: TextStyle(fontSize: 20),
              ),
              context: context),
          body: Column(
            children: [
              CustomerSelector(
                  showAll: false,
                  onCustomerChange: () {
                    var data =
                        Provider.of<CartProvider>(context, listen: false);
                    data.loadCartPage(context: context);
                  }),
            ],
          ),
        );
      }
      if (data.connectionStatus == ConnectionStatus.done) {
        return Scaffold(
          appBar: getAppBar(
              title: Text(
                "Checkout",
                style: TextStyle(fontSize: 20),
              ),
              context: context),
          bottomNavigationBar: CartButton(
            title: Text(
              "Shipping Info",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(Screen.shippingInfoScreen.toString());
            },
            price:
                "AED ${data.cartModel.orderSummary.orderQuantity.subTotal.toStringAsFixed(2)}",
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Consumer<AuthProvider>(builder: (context, authData, _) {
              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  if (authData.userDetail.userType == UserType.employee)
                    CustomerSelector(
                        showAll: false,
                        onCustomerChange: () {
                          var data =
                              Provider.of<CartProvider>(context, listen: false);
                          data.loadCartPage(context: context);
                        }),
                  if (authData.userDetail.userType == UserType.employee)
                    SizedBox(
                      height: 12,
                    ),
                  SizedBox(
                    height: 12,
                  ),
                  authData.userDetail.customerId != -1
                      ? Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: Constant().boxDecoration,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Cart",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Spacer(),
                                      TextButton(
                                          onPressed: () {
                                            Provider.of<CartProvider>(context, listen: false)
                                                .clearCart(
                                                context: context,
                                            );
                                          },
                                          child: Text(
                                            "Clear All",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.w700),
                                          ))
                                    ],
                                  ),
                                  ...data.cartModel.cartItems
                                      .map((cartItem) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: CartProductCard(
                                                product: cartItem),
                                          ))
                                      .toList(),
                                  SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: OrderSummaryCard(
                                orderSummary: data.cartModel.orderSummary,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      : Container()
                ],
              );
            }),
          ),
        );
      } else if (data.connectionStatus == ConnectionStatus.error) {
        var auth = Provider.of<AuthProvider>(context, listen: false);
        return Scaffold(
          appBar: getAppBar(
              title: Text(
                "Checkout",
                style: TextStyle(fontSize: 20),
              ),
              context: context),
          body: Column(
            children: [
              if (auth.userDetail.userType == UserType.employee)
                CustomerSelector(
                    showAll: false,
                    onCustomerChange: () {
                      var data =
                          Provider.of<CartProvider>(context, listen: false);
                      data.loadCartPage(context: context);
                    }),
              Spacer(),
              Center(
                child: Text("Your cart is empty"),
              ),
              Spacer(),
            ],
          ),
        );
      } else {
        return Scaffold(
            bottomNavigationBar: Shimmer.fromColors(
                child: Container(
                  height: 70,
                  color: Colors.grey,
                ),
                baseColor: Theme.of(context).primaryColor.withOpacity(.4),
                highlightColor: Colors.grey.withOpacity(.1)),
            body: LoadingIndicator());
      }
    });
  }
}
