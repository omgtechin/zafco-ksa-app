import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/constant.dart';
import '../model/data_model/dashboard_model.dart';

class ProductCard extends StatefulWidget {
  final Products products;
  const ProductCard({Key? key, required this.products}) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int quantity = 1;


  @override
  Widget build(BuildContext context) {
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
                            border:
                                Border.all(color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            )),
                        child: Constant().getImage(imgSrc: widget.products.image),
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
                                  widget.products.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700, fontSize: 16),
                                ),
                              ),
                              SizedBox(width: 12,),
                              Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    )),
                                child: Icon(
                                  Icons.star_border_outlined,
                                  color: Theme.of(context).primaryColor,
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "SKU",
                                        style: TextStyle(
                                            color: Theme.of(context).primaryColor),
                                      ),
                                      Text(widget.products.sku)
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
                                  Text(widget.products.year.toString())
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
                                  Text(widget.products.stock)
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("AED ${widget.products.price}",
                          style:
                              TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                      Row(
                        children: [
                          Text("AED 828.00",
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.black.withOpacity(.7),
                                  fontWeight: FontWeight.w700)),
                          Text(" 50% off",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(.7),
                                  fontWeight: FontWeight.w700))
                        ],
                      )
                    ],
                  ),
                  Spacer(),

                  InkWell(
                    onTap: (){
                      setState(() {
                        if(quantity >1){
                          quantity--;
                        }

                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8))),
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4),
                        child: Icon(
                          Icons.remove_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      quantity.toString(),
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        quantity++;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8))),
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4),
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
                    onPressed: () {

                    },
                    child: Text(
                      "Add to cart",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
        Positioned(
          top: 8,

          child: Image.asset("assets/label.png",height: 35,width: 60,fit: BoxFit.fill,),),

        Positioned(
          top: 10,
          left: 8,
          child: Container(

            child: Column(children: [
              Text("buy 50",style: TextStyle(color: Colors.white),),
              Text("get 10",style: TextStyle(color: Colors.white),),

            ],)
          ),
        )
      ],
    );
  }
}
