import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/localization_provider.dart';
import '../../../../screen/main_screen/shop/widget/quantity_selector.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/constant.dart';
import '../../../../provider/shop_provider.dart';

class ShopProductCard extends StatefulWidget {
  final bool? userFavourites;
  final String stock;
  final String image;
  final String name;
  final int productId;
  final int productionYear;
  final String masterMaterial;
  final int productIdProdYear;
  final String price;
  final List<String> promotions;

  const ShopProductCard({
    Key? key,
    required this.userFavourites,
    required this.stock,
    required this.name,
    required this.image,
    required this.productId,
    required this.productionYear,
    required this.masterMaterial,
    required this.price,
    required this.productIdProdYear,
    required this.promotions
  }) : super(key: key);

  @override
  State<ShopProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ShopProductCard> {
  int quantity = 0;

  // 0 -> not favorite product
  // 1 -> favorite product
  // -1 -> changing state of product(loading indicator)
  int isFavourite = 0;

  bool addToCartLoading = false;

  @override
  void initState() {
    isFavourite = widget.userFavourites == null ? 0 : 1;
    setState(() {});
    super.initState();
  }

  getFormattedPromotion({required String title}) {
    List<String> promotion = title.split(" ");
    return "${promotion[0]} ${promotion[1]}\n${promotion[2]} ${promotion[3]}";
  }

  @override
  Widget build(BuildContext context) {
    var localizationProvider = Provider.of<LocalizationProvider>(context,listen: false);

    bool leftBound = quantity == 0;
    bool rightBound = quantity >= int.parse(widget.stock) || quantity >= 100;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: Constant().boxDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 22,
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            )),
                        child: Constant().getImage(
                            imgSrc: widget.image == "0"
                                ? Constant().comingSoonImg
                                : widget.image),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              InkWell(
                                onTap: () async {
                                  var shopProvider = Provider.of<ShopProvider>(
                                      context,
                                      listen: false);
                                  if (isFavourite == 0) {
                                    setState(() {
                                      isFavourite = -1;
                                    });
                                    bool res =
                                        await shopProvider.switchFavorite(
                                            productId: widget.productId,
                                            productionYear:
                                                widget.productionYear,
                                            context: context,
                                            type: "add");
                                    setState(() {
                                      isFavourite = res == true ? 1 : 0;
                                    });
                                  } else {
                                    setState(() {
                                      isFavourite = -1;
                                    });
                                    bool res =
                                        await shopProvider.switchFavorite(
                                            productId: widget.productId,
                                            productionYear:
                                                widget.productionYear,
                                            context: context,
                                            type: "remove");
                                    setState(() {
                                      isFavourite = res == true ? 0 : 1;
                                    });
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: isFavourite == 1
                                          ? Theme.of(context).primaryColor
                                          : null,
                                      border: Border.all(
                                          color:
                                              Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      )),
                                  child: isFavourite == -1
                                      ? Container(
                                          padding: EdgeInsets.all(4),
                                          height: 26,
                                          width: 26,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ))
                                      : Icon(
                                          Icons.star_border_outlined,
                                          color: isFavourite == 0
                                              ? Theme.of(context).primaryColor
                                              : Colors.white,
                                        ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
     AppLocalizations.of(context)!.sku,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      Text(widget.masterMaterial.toString())
                                    ],
                                  )),
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.year,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  Text(
                                      (widget.productionYear + 2000).toString())
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.stock,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  Text(int.parse(widget.stock) > 100
                                      ? "100+"
                                      : widget.stock)
                                ],
                              )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Text("AED ${widget.price}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      if (!leftBound) {
                        setState(() {
                          quantity--;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: leftBound
                              ? Theme.of(context).primaryColor.withOpacity(.5)
                              : Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(localizationProvider.isLTR?0: 8),
                            bottomRight: Radius.circular(localizationProvider.isLTR?0: 8),
                            topLeft: Radius.circular(localizationProvider.isLTR?8: 0),
                            bottomLeft: Radius.circular(localizationProvider.isLTR?8: 0),

                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2.0, vertical: 4),
                        child: Icon(
                          Icons.remove_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      int? val = await showDialog(
                          context: context,
                          builder: (context) {
                            return QuantitySelector(
                              minVal: 0,
                              maxVal: int.parse(widget.stock) > 100
                                  ? 100
                                  : int.parse(widget.stock),
                              selectedVal: quantity,
                            );
                          });
                      if (val != null) {
                        setState(() {
                          quantity = val;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      height: 50,
                      child: Center(
                          child: Text(
                        quantity.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColor,
                        ),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (!rightBound) {
                        setState(() {
                          quantity++;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: rightBound
                              ? Theme.of(context).primaryColor.withOpacity(.5)
                              : Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(localizationProvider.isLTR?8: 0),
                              bottomRight: Radius.circular(localizationProvider.isLTR?8: 0),
                              topLeft: Radius.circular(localizationProvider.isLTR?0: 8),
                              bottomLeft: Radius.circular(localizationProvider.isLTR?0: 8),

                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2.0, vertical: 4),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      if(quantity == 0){
                        Constant().getToast(title: "Please select quantity");
                      }else {
                        var shopProvider =
                        Provider.of<ShopProvider>(context, listen: false);

                        setState(() {
                          addToCartLoading = true;
                        });

                        await shopProvider.addProductToCart(
                            quantity: quantity,
                            productIdProdYear: widget.productIdProdYear,
                            context: context);

                        setState(() {
                          addToCartLoading = false;
                        });
                      }  },
                    child: addToCartLoading
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 2),
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                      AppLocalizations.of(context)!.addtocart,
                            style: TextStyle(color: Colors.white),
                          ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
        if (widget.promotions.isNotEmpty)
          Positioned(
            top: 8,
            child: Transform.rotate(
              angle:localizationProvider.isLTR? 0: math.pi,
              child: Image.asset(
                "assets/label.png",
                height: widget.promotions.length > 1 ? 50 : 40,
                width: 65,
                fit: BoxFit.fill,
              ),
            ),
          ),
        if (widget.promotions.isNotEmpty)
          Positioned(
            top: 10,
            right: localizationProvider.isLTR? 0: 8,
            left: localizationProvider.isLTR? 8: 0,
            child: GestureDetector(
              onTap: () => showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      insetPadding: EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18),
                            child: Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.offers,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(Icons.close),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: .5,
                            color: Colors.grey.withOpacity(.5),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...widget.promotions
                                    .map((promotion) => Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 4.0),
                                  child: Text(
                                    promotion,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ))
                                    .toList(),
                                SizedBox(
                                  height: 12,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              child: Container(
                  height: widget.promotions.length > 1 ? 50 : 40,
                  width: 65,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        getFormattedPromotion(
                            title: widget.promotions[0]),
                        style: TextStyle(color: Colors.white),
                      ),
                      if (widget.promotions.length > 1)
                        Text(
                          "+${widget.promotions.length - 1} Offer",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.white),
                        )
                    ],
                  )),
            ),
          )
      ],
    );
  }
}
