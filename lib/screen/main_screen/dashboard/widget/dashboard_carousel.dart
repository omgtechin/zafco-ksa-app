import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../model/data_model/dashboard_model.dart';

class DashboardCarousel extends StatefulWidget {
  final DashboardModel data;

  const DashboardCarousel({Key? key, required this.data}) : super(key: key);

  @override
  _HomeCarouselState createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<DashboardCarousel> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    double carouselHeight = 110;
    buildSlider(List<String> imgList) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              // decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(18))),
              height: carouselHeight,

              width: double.infinity,
              child: CarouselSlider.builder(
                itemCount: imgList.length,
                itemBuilder: (BuildContext context, int itemIndex, _) {
               return   ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: CachedNetworkImage(
                        placeholder: (context, _) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(.2),
                            highlightColor:
                                Theme.of(context).primaryColor.withOpacity(.2),
                            child: Container(
                              color: Colors.grey,
                            ),
                          );
                        },
                        imageUrl: imgList[itemIndex],
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ));
                },
                options: CarouselOptions(
                    initialPage: 0,
                    viewportFraction: 1,
                    onPageChanged: (index, _) {
                      setState(() {
                        activeIndex = index;
                      });
                    }),
              ),
            ),
            Positioned(
              bottom: 12,
              child: AnimatedSmoothIndicator(
                count: imgList.length,
                effect: WormEffect(
                  dotHeight: 7,
                  paintStyle: PaintingStyle.fill,
                  dotWidth: 7,
                  dotColor: Colors.white,
                  strokeWidth: 1,
                  activeDotColor: Theme.of(context).primaryColor,
                ),
                // your preferred effect
                activeIndex: activeIndex,
              ),
            )
          ],
        ),
      );
    }

    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSlider(widget.data.dashboard.banners),
      ],
    );
  }
}
