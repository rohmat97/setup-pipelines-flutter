import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kai_wisata/data/constants.dart';
import 'package:kai_wisata/flights/providers/flight_airports_state.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/home/providers/rail_home_dashboard_state.dart';
import 'package:provider/provider.dart';

class HomeDashboardPage extends StatefulWidget {
  const HomeDashboardPage({
    Key? key,
    this.scaffoldKey,
    this.scrollController,
  }) : super(key: key);
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final ScrollController? scrollController;

  @override
  _HomeDashboardPageState createState() => _HomeDashboardPageState();
}

class _HomeDashboardPageState extends State<HomeDashboardPage> {
  RailHomeDashboardState state = RailHomeDashboardState();
  FlightAirportsState airportsState = FlightAirportsState();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {});
  }

  Widget buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Stack(
        children: const [
          Center(
            child: Image(
              image: AssetImage('assets/images/logo_kaiwisata2.png'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWelcomeText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selamat Datang,',
            style: KaiTextStyle.captionLarge.apply(color: KaiColor.dark900),
          ),
          const SizedBox(height: 4),
          Text(
            state.user!.fullName,
            style: KaiTextStyle.bodyLargeBold.apply(color: KaiColor.dark900),
          ),
        ],
      ),
    );
  }

  Widget buildSearchFormField() {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon:
              const Icon(Icons.search, color: KaiColor.dark900, size: 24),
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: .5, color: KaiColor.neutral8),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: 'Cari Tiket Kereta, Hotel, dll...',
          hintStyle: KaiTextStyle.bodySmallRegular.apply(
            color: KaiColor.neutral6,
          ),
        ),
      ),
    );
  }

  Widget buildPromoTile(Map<String, dynamic> item) {
    return Container(
      width: 266.42,
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // image: const DecorationImage(
        //   image: NetworkImage('https://via.placeholder.com/266x120'),
        // ),
        image: DecorationImage(
          image: AssetImage(item["image"]),
        ),
      ),
    );
  }

  Widget buildListOfPromo() {
    List<Widget> widgets = [];
    final int itemCount = promoSpesial.length;
    for (int i = 0; i < itemCount; i++) {
      if (i == 0) {
        widgets.add(const SizedBox(width: 10));
      }
      widgets.add(buildPromoTile(promoSpesial[i]));
      if (i == itemCount - 1) {
        widgets.add(const SizedBox(width: 10));
      }
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Promo Spesial',
                style: KaiTextStyle.titleSmallBold.apply(
                  color: const Color(0xFF001A4D),
                ),
              ),
              Text(
                'Lihat Semua',
                style: KaiTextStyle.titleSmallBold.apply(
                  color: const Color(0xFF085DA1),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widgets,
          ),
        ),
      ],
    );
  }

  Widget buildHotelTile(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: 206,
      height: 236,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFFAFAFA),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 206,
            height: 146,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              image: DecorationImage(
                image: NetworkImage(item['image']),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Text(
                  item['title'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Color(0xFFF38422),
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        item['location'],
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.star,
                      color: Color(0xFFF38422),
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${item['rating']}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListOfHotelRecommendation() {
    List<Widget> widgets = [];
    final int itemCount = recomendedHotel.length;
    for (int i = 0; i < itemCount; i++) {
      if (i == 0) {
        widgets.add(const SizedBox(width: 10));
      }
      widgets.add(buildHotelTile(recomendedHotel[i]));
      if (i == itemCount - 1) {
        widgets.add(const SizedBox(width: 10));
      }
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rekomendasi Hotel',
                style: KaiTextStyle.titleSmallBold.apply(
                  color: const Color(0xFF001A4D),
                ),
              ),
              Text(
                'Lihat Semua',
                style: KaiTextStyle.titleSmallBold.apply(
                  color: const Color(0xFF085DA1),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widgets,
          ),
        ),
      ],
    );
  }

  Widget buildTripTile(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: 206,
      height: 295,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFFAFAFA),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 206,
            height: 207,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              image: DecorationImage(
                image: NetworkImage(item['image']),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.map,
                      color: Color(0xFFF38422),
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item['location'],
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListOfPopularTrip() {
    List<Widget> widgets = [];
    final int itemCount = popularTrips.length;
    for (int i = 0; i < itemCount; i++) {
      if (i == 0) {
        widgets.add(const SizedBox(width: 10));
      }
      widgets.add(buildTripTile(popularTrips[i]));
      if (i == itemCount - 1) {
        widgets.add(const SizedBox(width: 10));
      }
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tempat Wisata Populer',
                style: KaiTextStyle.titleSmallBold.apply(
                  color: const Color(0xFF001A4D),
                ),
              ),
              Text(
                'Lihat Semua',
                style: KaiTextStyle.titleSmallBold.apply(
                  color: const Color(0xFF085DA1),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widgets,
          ),
        ),
      ],
    );
  }

  Widget buildListOfCategory() {
    List<Widget> categories = [];
    for (Map<String, dynamic> item in homeCategory) {
      categories.add(
        Column(
          children: [
            InkWell(
              onTap: () => Navigator.pushNamed(context, item['routeName']),
              // onTap: () => showLevelUpBottomSheet(
              //   context,
              //   onButtonPressed: () {},
              // ),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(item['icon'])),
                    borderRadius: BorderRadius.circular(100),
                    color: KaiColor.neutral10),
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
                child: Text(
              item['title'],
              textAlign: TextAlign.center,
              style: KaiTextStyle.captionSmallMedium,
            ))
          ],
        ),
      );
    }
    return Container(
      height: 230,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GridView.count(
        primary: false,
        mainAxisSpacing: 32,
        crossAxisCount: 4,
        children: categories,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    state = Provider.of<RailHomeDashboardState>(context);
    state.init(context, scaffoldKey: widget.scaffoldKey);
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildAppBar(),
            const SizedBox(height: 28),
            buildWelcomeText(),
            const SizedBox(height: 16),
            buildSearchFormField(),
            const SizedBox(height: 16),
            buildListOfCategory(),
            buildListOfPromo(),
            const SizedBox(height: 30.5),
            buildListOfHotelRecommendation(),
            const SizedBox(height: 30.5),
            buildListOfPopularTrip(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
