import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../commons.dart';

class MyCarousel extends StatefulWidget {
  const MyCarousel({
    required this.children,
    Key? key
  }) : super(key: key);

  final List<Widget> children;

  @override
  State<MyCarousel> createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {

  final CarouselController _carouselController = CarouselController();
  int _carouselPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE5E5E5),
      child: Stack(
        children: [
          CarouselSlider(
              carouselController: _carouselController,
              items: widget.children,
              options: CarouselOptions(
                height: 340,
                // aspectRatio: 1,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                // autoPlay: true,
                // autoPlayInterval: Duration(seconds: 3),
                // autoPlayAnimationDuration: Duration(milliseconds: 800),
                // autoPlayCurve: Curves.fastOutSlowIn,
                // enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                    _carouselPosition = index;
                  });
                },
              )
          ),
          Positioned(
            bottom: 6,
            left: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (var i = 0; i < widget.children.length; i++)
                  GestureDetector(
                    onTap: () => _carouselController.animateToPage(
                        i, duration: const Duration(milliseconds: 800),
                        curve: Curves.fastOutSlowIn),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
                      color: Colors.transparent,
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        // margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _carouselPosition == i
                              ? MyColors.primary
                              : const Color(0xFFAAAAAA),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}