import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kai_wisata/constant.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/user/pages/login_page.dart';
import 'package:kai_wisata/providers/onboarding/onboarding_state.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  static const routeName = '/on-boarding-pages';
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  OnBoardingState state = OnBoardingState();
  final CarouselController slideController = CarouselController();

  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }

  @override
  Widget build(BuildContext context) {
    state = Provider.of<OnBoardingState>(context);
    state.initState(context, scaffoldKey);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CarouselSlider.builder(
                    carouselController: slideController,
                    options: CarouselOptions(
                      height: 442,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      viewportFraction: 0.9,
                    ),
                    itemCount: onboardImages.length,
                    itemBuilder: (
                      BuildContext context,
                      int itemIndex,
                      int pageViewIndex,
                    ) {
                      return Column(
                        children: [
                          Image.asset(
                            onboardImages[itemIndex]['images']!,
                            width: 232,
                            height: 250,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            onboardImages[itemIndex]['title']!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            onboardImages[itemIndex]['subtitle']!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    height: 250,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: KaiColor.neutral11,
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(35),
                            onTap: () => slideController.previousPage(),
                            child: const Icon(Icons.keyboard_arrow_left),
                          ),
                        ),
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(35),
                            onTap: () => slideController.nextPage(),
                            child: const Icon(Icons.keyboard_arrow_right),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              KaiButton(
                text: 'Mulai',
                onClick: () {
                  _storeOnboardInfo();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LoginPage.routeName,
                    (Route<dynamic> route) => false,
                  );
                },
                buttonColor: KaiColor.primary,
                textColor: KaiColor.white,
                sideColor: KaiColor.primary,
                padding: const EdgeInsets.all(18.0),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
