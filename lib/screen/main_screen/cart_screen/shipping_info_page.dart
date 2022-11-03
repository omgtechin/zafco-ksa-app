import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/app_bar.dart';
import '../../../../provider/cart_provider.dart';
import '../../../../screen/main_screen/cart_screen/widget/billing_address.dart';
import '../../../../screen/main_screen/cart_screen/widget/cart_button.dart';
import '../../../../screen/main_screen/cart_screen/widget/order_summary.dart';
import '../../../../screen/main_screen/cart_screen/widget/shipping_address.dart';
import '../../../../screen/main_screen/cart_screen/widget/shipping_info.dart';

import '../../../core/enum/connection_status.dart';
import '../../../core/enum/user_type.dart';
import '../../../core/routes.dart';
import '../../../provider/auth_provider.dart';
import '../../../widget/customer_selector.dart';
import '../../../widget/loading_idicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShippingInfoScreen extends StatefulWidget {
  const ShippingInfoScreen({Key? key}) : super(key: key);

  @override
  State<ShippingInfoScreen> createState() => _ShippingInfoPageState();
}

class _ShippingInfoPageState extends State<ShippingInfoScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      var data = Provider.of<CartProvider>(context, listen: false);
      data.loadShippingDetailsPage(context: context);
    });
    super.initState();
  } @override
  Widget build(BuildContext context) {
    return  Consumer<CartProvider>(builder: (context, data, _) {
      var authData = Provider.of<AuthProvider>(context, listen: false);

      if (data.connectionStatus == ConnectionStatus.done) {
        return Scaffold(
          appBar: getAppBar(
              title: Text(
                AppLocalizations.of(context)!.checkout,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
              ),
              context: context),
          bottomNavigationBar: CartButton(
            price: "AED ${data.shippingDetailModel.orderQuantity.grandTotal.toStringAsFixed(2)}",
            title:
                data.buttonLoadingStatus == ConnectionStatus.active? Container(

                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(color: Colors.white,)):
            Text( AppLocalizations.of(context)!.shippingInfo,style: TextStyle(color: Colors.white),),
            onTap: () {
              data.checkout(context: context);

              // Navigator.of(context).pushNamed(
              //     Screen.orderPlacedScreen.toString());
            },
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                SizedBox(
                  height: 12,
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
                ShippingInfo(),

                SizedBox(
                  height: 18,
                ),
                BillingAddress(billingAddress: data.shippingDetailModel.billingAddress.address),
                SizedBox(
                  height: 18,
                ),
                ShippingAddress(shippingAddresses: data.shippingDetailModel.shippingAddresses),
                SizedBox(
                  height: 18,
                ),
                OrderSummaryCard(
                    orderSummary:
                    Provider
                        .of<CartProvider>(context)
                        .cartModel
                        .orderSummary),

                SizedBox(
                  height: 22,
                ),
              ],
            ),
          ),
        );
      }else if (data.connectionStatus == ConnectionStatus.error) {
        var auth = Provider.of<AuthProvider>(context, listen: false);
        return Scaffold(
          appBar: getAppBar(
              title: Text(
                AppLocalizations.of(context)!.checkout,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
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
                      data.loadShippingDetailsPage(context: context);
                    }),
              Spacer(),
              Center(
                child: Text( AppLocalizations.of(context)!.yourCartIsEmpty),
              ),
              Spacer(),
            ],
          ),
        );
      } else {
        return Scaffold(
            bottomNavigationBar: Shimmer.fromColors(
                child: Container(height: 70, color: Colors.grey,),
                baseColor: Theme
                    .of(context)
                    .primaryColor
                    .withOpacity(.4),
                highlightColor: Colors.grey.withOpacity(.1)),
            body: LoadingIndicator());
      }
    });
  }
}
