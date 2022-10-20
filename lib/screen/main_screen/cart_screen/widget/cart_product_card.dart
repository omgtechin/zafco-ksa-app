import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../model/data_model/cart_model.dart';

import '../../../../core/constant.dart';
import '../../../../provider/cart_provider.dart';
import '../../shop/widget/quantity_selector.dart';

class CartProductCard extends StatefulWidget {
  final CartItem product;

  const CartProductCard({Key? key, required this.product}) : super(key: key);

  @override
  State<CartProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<CartProductCard> {
  int quantity = 0;

  @override
  void initState() {
    quantity = widget.product.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isFreeProduct = widget.product.cloned;
    bool leftBound = quantity == 1 || isFreeProduct;
    bool rightBound = quantity >= widget.product.stock || quantity >= 100 || isFreeProduct;

    return Container(
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
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        )),
                    child: Constant().getImage(
                        imgSrc: widget.product.product.image_256 == "0"
                            ? Constant().comingSoonImg
                            : widget.product.product.image_256),
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
                              widget.product.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                if(!isFreeProduct) {
                                  Provider.of<CartProvider>(context,
                                      listen: false)
                                      .deleteProductFromCart(
                                      context: context,
                                      productId: widget.product.productId,
                                  qty: widget.product.quantity);
                                }    },
                              child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(Icons.delete_outlined, color: isFreeProduct ? Colors.black54: Colors.black,)))
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "SKU",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                widget.product.product.masterMaterial,
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Year",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                (2000 + widget.product.productionYear)
                                    .toString(),
                                style: TextStyle(fontSize: 14),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Stock",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                (widget.product.stock).toString(),
                                style: TextStyle(fontSize: 14),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${widget.product.currency} ${widget.product.totalPrice}.00",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                  if (widget.product.cloned == true)
                    Row(
                      children: [
                        Text(
                          widget.product.promotion,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Offer Applied",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).priceColor),
                        )
                      ],
                    ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  if (!leftBound) {
                    setState(() {
                      quantity--;
                    });

                    Provider.of<CartProvider>(context, listen: false)
                        .updateCart(
                            context: context,
                            quantity: quantity,
                            productIdProdYear:
                                widget.product.productIdProdYear);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color:  leftBound
                          ? Theme.of(context).primaryColor.withOpacity(.5)
                          : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8))),
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
                          minVal: 1,
                          maxVal: widget.product.stock > 100
                              ? 100
                              : widget.product.stock,
                          selectedVal: quantity,
                        );
                      });
                  if (val != null) {
                    setState(() {
                      quantity = val;
                    });
                    Provider.of<CartProvider>(context, listen: false)
                        .updateCart(
                            context: context,
                            quantity: quantity,
                            productIdProdYear:
                                widget.product.productIdProdYear);
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

                    Provider.of<CartProvider>(context, listen: false)
                        .updateCart(
                            context: context,
                            quantity: quantity,
                            productIdProdYear:
                                widget.product.productIdProdYear);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: rightBound
                          ? Theme.of(context).primaryColor.withOpacity(.5)
                          : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8))),
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
            ],
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
