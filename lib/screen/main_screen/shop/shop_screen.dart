import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';

import '../../../../provider/auth_provider.dart';
import '../../../../provider/shop_provider.dart';
import '../../../../screen/main_screen/shop/widget/filter_modal.dart';
import '../../../../screen/main_screen/shop/widget/filter_tags.dart';
import '../../../../screen/main_screen/shop/widget/shop_product_card.dart';
import '../../../../screen/main_screen/shop/widget/sort_modal.dart';
import '../../../../widget/loading_idicator.dart';



import '../../../core/app_bar.dart';
import '../../../core/enum/connection_status.dart';
import '../../../core/enum/user_type.dart';
import '../../../provider/cart_provider.dart';
import '../../../widget/custom_icon_button.dart';
import '../../../widget/customer_selector.dart';

class ShopScreen extends StatefulWidget {
  final List<String>? filters;
  final String? filterType;

  const ShopScreen({Key? key, required this.filters, required this.filterType}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      var data = Provider.of<ShopProvider>(context, listen: false);
      var auth = Provider.of<AuthProvider>(context, listen: false);
      var cart = Provider.of<CartProvider>(context, listen: false);

      if (auth.userDetail.userType == UserType.employee) {
        auth.updateCustomer(updatedCustomerId: -1);
      }
      if (widget.filterType != null) {
        if (widget.filters != null) {
          data.getOffer(context: context, offers: widget.filters!);
        } else {
          data.getBestSellers(context: context);
        }
      }
      if (auth.userDetail.userType == UserType.customer) {
        data.loadShop(context: context);
      }
      cart.getCartCount(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<AuthProvider>(context, listen: false);
    var shopData = Provider.of<ShopProvider>(context, listen: false);

    return Scaffold(
        appBar: getAppBar(
            title: Text(
            AppLocalizations.of(context)!.shop,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            context: context),
        body: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                if (userData.userDetail.userType == UserType.employee)
                  CustomerSelector(
                      showAll: false,
                      onCustomerChange: () {
                        var data =
                            Provider.of<ShopProvider>(context, listen: false);
                        data.loadShop(context: context);
                      }),
                if (userData.userDetail.userType == UserType.employee)
                  SizedBox(
                    height: 12,
                  ),
              ],
            ),
            Consumer<AuthProvider>(builder: (context, authData, _) {
              if (authData.userDetail.customerId != -1) {
                return Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: .8)),
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: shopData.searchController,
                                        onSubmitted: (_) {
                                          shopData.getFilterData(
                                              context: context);
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:  AppLocalizations.of(context)!.search,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        shopData.getFilterData(
                                            context: context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.search,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        shopData.searchController.clear();
                                        shopData.getFilterData(
                                            context: context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.clear,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            CustomIconButton(
                              icon: Icons.filter_list,
                              onTap: () {
                                if (shopData.shopModel.attributes != null) {
                                  showMaterialModalBottomSheet(
                                    context: context,
                                    builder: (context) => ShopSortModal(),
                                  );
                                }
                              },
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            CustomIconButton(
                              icon: Icons.filter_alt_outlined,
                              onTap: () {
                                if (shopData.shopModel.attributes != null) {
                                  showMaterialModalBottomSheet(
                                    context: context,
                                    builder: (context) => ShopFilterModal(),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ShopFilterTags(),
                      SizedBox(
                        height: 20,
                      ),
                      userData.userDetail.customerId == -1
                          ? Container()
                          : Expanded(
                              child: Consumer<ShopProvider>(
                                  builder: (context, shopData, _) {
                                if (shopData.connectionStatus ==
                                    ConnectionStatus.done) {
                                  if (shopData
                                      .shopModel.products.data.isEmpty) {
                                    return  Center(
                                      child: Text( AppLocalizations.of(context)!.noProductsFound),
                                    );
                                  } else {
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        itemCount: shopData
                                            .shopModel.products.data.length,
                                        itemBuilder: (context, index) {
                                          var product = shopData
                                              .shopModel.products.data[index];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12),
                                            child: Column(
                                              children: [
                                                ShopProductCard(
                                                  price: product.price,
                                                  image: product.product.image,
                                                  masterMaterial:
                                                      product.masterMaterial,
                                                  name: product.name,
                                                  productId: product.id,
                                                  productIdProdYear:
                                                      product.productIdProdYear,
                                                  productionYear:
                                                      product.productionYear,
                                                  promotions:
                                                      product.promotions,
                                                  stock: product.stock,
                                                  userFavourites:
                                                      product.userFavourites ==
                                                              null
                                                          ? null
                                                          : true,
                                                ),
                                                if (index ==
                                                        shopData
                                                                .shopModel
                                                                .products
                                                                .data
                                                                .length -
                                                            1 &&
                                                    shopData.shopModel.products
                                                            .lastPage !=
                                                        shopData
                                                            .shopModel
                                                            .products
                                                            .currentPage)
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 22,
                                                      ),
                                                      Text(
                                                        "${AppLocalizations.of(
                                                            context)!
                                                            .showing} ${shopData
                                                            .shopModel.products
                                                            .from} ${AppLocalizations
                                                            .of(context)!
                                                            .to} ${shopData
                                                            .shopModel.products
                                                            .to} ${AppLocalizations
                                                            .of(context)!
                                                            .ofKey} ${shopData
                                                            .shopModel.products
                                                            .total} ${AppLocalizations
                                                            .of(context)!
                                                            .products}",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Spacer(),
                                                          Container(
                                                            width: 160,
                                                            child:
                                                                NumberPaginator(
                                                              config: NumberPaginatorUIConfig(
                                                                  buttonSelectedBackgroundColor:
                                                                      Theme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                  buttonShape: const RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(
                                                                              8))),
                                                                  contentPadding:
                                                                      const EdgeInsets.all(
                                                                          0),
                                                                  buttonUnselectedForegroundColor:
                                                                      Theme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                  mode: ContentDisplayMode
                                                                      .dropdown),
                                                              numberPages: shopData
                                                                      .shopModel
                                                                      .products
                                                                      .lastPage! -
                                                                  1,
                                                              initialPage: (shopData
                                                                          .shopModel
                                                                          .products
                                                                          .currentPage ??
                                                                      1) -
                                                                  1,
                                                              onPageChange:
                                                                  (int index) {
                                                                if (shopData
                                                                    .showWhereHouse) {
                                                                  shopData.loadShop(
                                                                      context:
                                                                          context,
                                                                      pageIdx:
                                                                          index +
                                                                              1);
                                                                } else {
                                                                  shopData.getFilterData(
                                                                      context:
                                                                          context,
                                                                      pageIdx:
                                                                          index +
                                                                              1);
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                              ],
                                            ),
                                          );
                                        });
                                  }
                                } else if (shopData.connectionStatus ==
                                    ConnectionStatus.error) {
                                  return Center(
                                    child: Text(AppLocalizations.of(context)!.wrongText),
                                  );
                                } else {
                                  return LoadingIndicator();
                                }
                              }),
                            ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }),
          ],
        ));
  }
}
