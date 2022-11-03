



import 'package:flutter/material.dart';
import '../../../../model/data_model/dashboard_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../../core/routes.dart';
import 'dashboard_product_card.dart';

class BestSellers extends StatelessWidget {
  final DashboardModel data;
  const BestSellers({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.bestSellers,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor),
                  ),
                  Spacer(),
                  Container(
                      width: 110,
                      height: 35,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              Screen.mainScreen.toString(),
                              arguments: {"pageId": 3,"filterType":"best"});

                        },
                        child: Text(AppLocalizations.of(context)!.viewAll),
                      )),
                ],
              ),

              ...data.dashboard.bestSellers.products.map((product) => Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  DashBoardProductCard(
                    stock: product.stock,
                    productionYear: product.year,
                    productIdProdYear: product.productIdProdYear,
                    productId: product.id,
                    name: product.name,
                    masterMaterial: product.sku,
                    image: product.image,
                    price: product.price,
                    promotions: product.promotions,
                    userFavourites: false,
                  ),
                ],
              )),

            ],
          ),
        ),

      ],
    );
  }
}
