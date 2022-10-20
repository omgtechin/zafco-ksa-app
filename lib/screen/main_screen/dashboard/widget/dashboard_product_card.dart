import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constant.dart';
import '../../../../provider/shop_provider.dart';

class DashBoardProductCard extends StatefulWidget {
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

  const DashBoardProductCard({
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
  State<DashBoardProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<DashBoardProductCard> {
  int quantity = 0;

  // 0 -> not favorite product
  // 1 -> favorite product
  // -1 -> changing state of product(loading indicator)
  int isFavourite = 0;


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
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "SKU",
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
                                    "Year",
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
                                    "Stock",
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
                  Text("AED ${widget.price}.00",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                  Spacer(),
                 ]
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
            child: Image.asset(
              "assets/label.png",
              height: widget.promotions.length > 1 ? 50 : 40,
              width: 65,
              fit: BoxFit.fill,
            ),
          ),
        if (widget.promotions.isNotEmpty)
          Positioned(
            top: 10,
            left: 8,
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
                                  "Offers",
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
