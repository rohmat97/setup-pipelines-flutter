import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kai_wisata/data/config.dart';
import 'package:kai_wisata/data/lozalizations.dart';
import 'package:kai_wisata/digital_goods/pages/01goods_dashboard_page.dart';
import 'package:kai_wisata/digital_goods/pages/02goods_brand_page.dart';
import 'package:kai_wisata/digital_goods/pages/05digital_goods_selected_payment_page.dart';
import 'package:kai_wisata/digital_goods/pages/goods_listrik_home_page.dart';
import 'package:kai_wisata/digital_goods/providers/brand_state.dart';
import 'package:kai_wisata/digital_goods/providers/digital_goods_selected_payment_state.dart';
import 'package:kai_wisata/digital_goods/providers/goods_home_state.dart';
import 'package:kai_wisata/digital_goods/providers/pulsa_confirmation_state.dart';
import 'package:kai_wisata/digital_goods/providers/pulsa_home_state.dart';
// import 'package:kai_wisata/digital_goods/providers/goods_listrik_home_page_state.dart';
import 'package:kai_wisata/flights/pages/flight_booking_page.dart';
import 'package:kai_wisata/flights/pages/flight_detail_page.dart';
import 'package:kai_wisata/flights/pages/flight_doku_page.dart';
import 'package:kai_wisata/flights/pages/flight_result_page.dart';
import 'package:kai_wisata/flights/pages/flight_ticket_page.dart';
import 'package:kai_wisata/flights/providers/flight_booking_state.dart';
import 'package:kai_wisata/flights/providers/flight_detail_state.dart';
import 'package:kai_wisata/flights/providers/flight_doku_state.dart';
import 'package:kai_wisata/flights/providers/flight_result_state.dart';
import 'package:kai_wisata/flights/providers/flight_ticket_state.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/home/pages/egoods_home_booking_page.dart';
import 'package:kai_wisata/home/pages/flight_booking_detail_page.dart';
import 'package:kai_wisata/home/pages/flight_home_booking_page.dart';
import 'package:kai_wisata/home/pages/rail_home_booking_page.dart';
import 'package:kai_wisata/home/providers/egoods_home_dashboard_state.dart';
import 'package:kai_wisata/home/providers/flight_booking_detail_state.dart';
import 'package:kai_wisata/home/providers/flight_home_dashboard_state.dart';
import 'package:kai_wisata/home/providers/home_account_state.dart';
import 'package:kai_wisata/home/providers/home_booking_state.dart';
import 'package:kai_wisata/home/providers/rail_home_dashboard_state.dart';
import 'package:kai_wisata/home/providers/tourism_booking_detail_state.dart';
import 'package:kai_wisata/hotel/pages/02hotel_list_page.dart';
import 'package:kai_wisata/hotel/pages/03hotel_detail_page.dart';
import 'package:kai_wisata/hotel/pages/07hotel_order_loading_page.dart';
import 'package:kai_wisata/hotel/pages/08hotel_doku_payment_page.dart';
import 'package:kai_wisata/hotel/providers/hotel_detail_state.dart';
import 'package:kai_wisata/hotel/providers/hotel_list_state.dart';
import 'package:kai_wisata/hotel/providers/hotel_room_detail_state.dart';
import 'package:kai_wisata/hotel/providers/hotel_search_state.dart';
import 'package:kai_wisata/kai_reguler/pages/04booking_loading_page.dart';
import 'package:kai_wisata/kai_reguler/pages/06doku_payment_page.dart';
import 'package:kai_wisata/kai_reguler/pages/03input_passenger_page.dart';
import 'package:kai_wisata/kai_reguler/pages/order_data_page.dart';
import 'package:kai_wisata/kai_reguler/pages/passenger_data_page.dart';
import 'package:kai_wisata/kai_reguler/pages/01regular_ticket_page.dart';
import 'package:kai_wisata/kai_reguler/pages/02search_result_page.dart';
import 'package:kai_wisata/kai_reguler/pages/05selected_payment_page.dart';
import 'package:kai_wisata/home/pages/rail_booking_detail_page.dart';
import 'package:kai_wisata/kai_reguler/pages/select_payment_method_page.dart';
import 'package:kai_wisata/kai_reguler/pages/select_seat_page.dart';
import 'package:kai_wisata/kai_reguler/providers/doku_payment_state.dart';
import 'package:kai_wisata/kai_reguler/providers/input_passenger_state.dart';
import 'package:kai_wisata/kai_reguler/providers/order_data_state.dart';
import 'package:kai_wisata/kai_reguler/providers/order_details_state.dart';
import 'package:kai_wisata/kai_reguler/providers/passenger_data_state.dart';
import 'package:kai_wisata/kai_reguler/providers/regular_ticket_state.dart';
import 'package:kai_wisata/kai_reguler/providers/search_result_state.dart';
import 'package:kai_wisata/kai_reguler/providers/select_payment_method_state.dart';
import 'package:kai_wisata/kai_reguler/providers/select_seat_state.dart';
import 'package:kai_wisata/kai_reguler/providers/selected_payment_state.dart';
import 'package:kai_wisata/pages/booking/booking_ticket_page.dart';
import 'package:kai_wisata/pages/forgot_password/forgot_password_page.dart';
import 'package:kai_wisata/pages/home/home_page.dart';
import 'package:kai_wisata/hotel/pages/01hotel_search_page.dart';
import 'package:kai_wisata/pdf_viewer_page.dart';
import 'package:kai_wisata/providers/payment_state.dart';
import 'package:kai_wisata/home/providers/rail_booking_detail_state.dart';
import 'package:kai_wisata/user/providers/verification_state.dart';
import 'package:kai_wisata/user/pages/login_page.dart';
import 'package:kai_wisata/pages/my_points_page.dart';
import 'package:kai_wisata/pages/mice/mice_search_page.dart';
import 'package:kai_wisata/pages/onboarding/onboarding_screen.dart';
import 'package:kai_wisata/pages/order_details_page.dart';
import 'package:kai_wisata/pages/ordered_successfully_page.dart';
import 'package:kai_wisata/pages/payment_page.dart';
import 'package:kai_wisata/user/pages/register_page.dart';
import 'package:kai_wisata/pages/splash_page.dart';
import 'package:kai_wisata/kai_reguler/pages/station_page.dart';
import 'package:kai_wisata/home/pages/transaction_history_page.dart';
import 'package:kai_wisata/user/pages/verification_page.dart';
import 'package:kai_wisata/providers/apps_state.dart';
import 'package:kai_wisata/providers/booking_state.dart';
import 'package:kai_wisata/providers/forgot_password/forgot_password_state.dart';
import 'package:kai_wisata/providers/home/home_inbox_state.dart';
import 'package:kai_wisata/providers/home/home_state.dart';
import 'package:kai_wisata/user/providers/login_state.dart';
import 'package:kai_wisata/providers/my_points_state.dart';
import 'package:kai_wisata/providers/onboarding/onboarding_state.dart';
import 'package:kai_wisata/providers/ordered_successfully_state.dart';
import 'package:kai_wisata/providers/prefs_state.dart';
import 'package:kai_wisata/user/providers/register_state.dart';
import 'package:kai_wisata/providers/splash_state.dart';
import 'package:kai_wisata/kai_reguler/providers/station_state.dart';
import 'package:kai_wisata/home/providers/transaction_history_state.dart';
import 'package:kai_wisata/wisata/pages/01tourism_list_page.dart';
import 'package:kai_wisata/wisata/pages/02tourism_destination_page.dart';
import 'package:kai_wisata/wisata/pages/03tourism_checkout_page.dart';
import 'package:kai_wisata/wisata/providers/tourism_checkout_state.dart';
import 'package:kai_wisata/wisata/providers/tourism_destination_state.dart';
import 'package:kai_wisata/wisata/providers/tourism_list_state.dart';
import 'package:provider/provider.dart';

import 'digital_goods/pages/03goods_pulsa_home_page.dart';
import 'digital_goods/pages/04goods_pulsa_payment_method_page.dart';
import 'digital_goods/pages/04order_loading_page.dart';
import 'digital_goods/pages/05doku_payment_page.dart';
import 'digital_goods/pages/digital_goods_select_payment_method_page.dart';
import 'digital_goods/pages/goods_listrik_checkout_page.dart';
import 'digital_goods/providers/digital_goods_select_payment_method_state.dart';
import 'digital_goods/providers/listrik_home_state.dart';
import 'home/pages/egoods_booking_detail_page.dart';
import 'home/pages/special_booking_detail_page.dart';
import 'home/pages/special_home_booking_page.dart';
import 'home/pages/tourism_booking_detail_page.dart';
import 'home/pages/tourism_home_booking_page.dart';
import 'home/providers/special_booking_detail_state.dart';
import 'home/providers/special_home_dashboard_state.dart';
import 'home/providers/tourism_home_dashboard_state.dart';
import 'hotel/pages/04hotel_room_detail_page.dart';
import 'hotel/pages/05hotel_order_page.dart';
import 'hotel/pages/06hotel_checkout_page.dart';
import 'hotel/providers/hotel_checkout_state.dart';
import 'hotel/providers/hotel_order_state.dart';
import 'kai_istimewa/pages/01special_ticket_page.dart';
import 'kai_istimewa/pages/02special_detail_page.dart';
import 'kai_istimewa/pages/special_customer_page.dart';
import 'kai_istimewa/providers/special_customer_state.dart';
import 'kai_istimewa/providers/special_detail_state.dart';
import 'kai_istimewa/providers/special_ticket_state.dart';
import 'kai_wisata/pages/01tourism_ticket_page.dart';
import 'kai_wisata/pages/02tourism_result_page.dart';
import 'kai_wisata/pages/02tourism_detail_page_other.dart';
import 'kai_wisata/pages/03tourism_wagon_page.dart';
import 'kai_wisata/pages/04tourism_detail_page.dart';
import 'kai_wisata/pages/tourism_customer_page.dart';
import 'kai_wisata/providers/tourism_customer_state.dart';
import 'kai_wisata/providers/tourism_detail_state.dart';
import 'kai_wisata/providers/tourism_result_state.dart';
import 'kai_wisata/providers/tourism_ticket_state.dart';
import 'kai_wisata/providers/tourism_wagon_state.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PrefsState(1),
        ),
        ChangeNotifierProvider(
          create: (_) => AppState(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('id'),
        ],
        title: 'Super Apple Pie',
        initialRoute: '/splash-pages',
        theme: appTheme,
        routes: {
          SplashPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => SplashState(),
                  child: const SplashPage(),
                ),
              ),
            );
          },
          OnBoardingPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => OnBoardingState(),
                  child: const OnBoardingPage(),
                ),
              ),
            );
          },
          LoginPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => LoginState(),
                  child: const LoginPage(),
                ),
              ),
            );
          },
          RegisterPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => RegisterState(),
                  child: const RegisterPage(),
                ),
              ),
            );
          },
          HomePage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider<HomeState>(
                      create: (_) => HomeState(),
                    ),
                    ChangeNotifierProvider<RailHomeDashboardState>(
                      create: (_) => RailHomeDashboardState(),
                    ),
                    ChangeNotifierProvider<HomeBookingState>(
                      create: (_) => HomeBookingState(),
                    ),
                    ChangeNotifierProvider<HomeInboxState>(
                      create: (_) => HomeInboxState(),
                    ),
                    ChangeNotifierProvider<HomeAccountState>(
                      create: (_) => HomeAccountState(),
                    ),
                  ],
                  child: const HomePage(),
                ),
                // child: ChangeNotifierProvider(
                //   create: (context) => HomeState(),
                //   child: const HomePage(),
                // ),
              ),
            );
          },
          ForgotPasswordPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => ForgotPasswordState(),
                  child: const ForgotPasswordPage(),
                ),
              ),
            );
          },
          VerificationPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => VerificationState(),
                  child: const VerificationPage(),
                ),
              ),
            );
          },
          MyPointsPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => MyPointsState(),
                  child: const MyPointsPage(),
                ),
              ),
            );
          },
          BookingTicketPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => BookingState(),
                  child: const BookingTicketPage(),
                ),
              ),
            );
          },
          RegularTicketPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => RegularTicketState(),
                  child: const RegularTicketPage(),
                ),
              ),
            );
          },
          SelectSeatPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider<SelectSeatState>(
                      create: (_) => SelectSeatState(),
                    ),
                  ],
                  child: const SelectSeatPage(),
                ),
              ),
            );
          },
          SelectPaymentMethodPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider<SelectPaymentMethodState>(
                      create: (_) => SelectPaymentMethodState(),
                    ),
                  ],
                  child: const SelectPaymentMethodPage(),
                ),
              ),
            );
          },
          FlightTicketPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => FlightTicketState(),
                  child: const FlightTicketPage(),
                ),
              ),
            );
          },
          FlightResultPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider<FlightTicketState>(
                      create: (_) => FlightTicketState(),
                    ),
                    ChangeNotifierProvider<FlightResultState>(
                      create: (_) => FlightResultState(),
                    ),
                  ],
                  child: const FlightResultPage(),
                ),
              ),
            );
          },
          FlightDetailPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider<FlightDetailState>(
                      create: (_) => FlightDetailState(),
                    ),
                    ChangeNotifierProvider<FlightBookingState>(
                      create: (_) => FlightBookingState(),
                    ),
                  ],
                  child: const FlightDetailPage(),
                ),
              ),
            );
          },
          FlightBookingPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider<FlightBookingState>(
                      create: (_) => FlightBookingState(),
                    ),
                    ChangeNotifierProvider<FlightDokuState>(
                      create: (_) => FlightDokuState(),
                    ),
                  ],
                  child: const FlightBookingPage(),
                ),
              ),
            );
          },
          FlightDokuPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider<FlightDokuState>(
                      create: (_) => FlightDokuState(),
                    ),
                  ],
                  child: const FlightDokuPage(),
                ),
              ),
            );
          },
          SearchResultPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => SearchResultState(),
                  child: const SearchResultPage(),
                ),
              ),
            );
          },
          InputPassengerPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => InputPassengerState(),
                  child: const InputPassengerPage(),
                ),
              ),
            );
          },
          PaymentPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => PaymentState(),
                  child: const PaymentPage(),
                ),
              ),
            );
          },
          OrderedSuccessfullyPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => OrderedSuccessfullyState(),
                  child: const OrderedSuccessfullyPage(),
                ),
              ),
            );
          },
          SelectedPaymentPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => SelectedPaymentState(),
                  child: const SelectedPaymentPage(),
                ),
              ),
            );
          },
          OrderDetailsPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => OrderDetailsState(),
                  child: const OrderDetailsPage(),
                ),
              ),
            );
          },
          StationPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => RegularTicketState(),
                  child: Consumer<RegularTicketState>(
                      builder: (context, state, _) => StationPage()),
                ),
              ),
            );
          },
          OrderDataPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => OrderDataState(),
                  child: Consumer<OrderDataState>(
                      builder: (context, state, _) => OrderDataPage()),
                ),
              ),
            );
          },
          PassengerDataPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => PassengerDataState(),
                  child: Consumer<PassengerDataState>(
                      builder: (context, state, _) => PassengerDataPage()),
                ),
              ),
            );
          },
          BookingLoadingPage.routeName: (context) {
            return Consumer<PrefsState>(
                builder: (context, notifier, _) => OverrideLocalization(
                      locale: notifier.locale,
                      child: BookingLoadingPage(),
                    ));
          },
          DokuPaymentPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => DokuPaymentState(),
                  child: Consumer<DokuPaymentState>(
                      builder: (context, state, _) => DokuPaymentPage()),
                ),
              ),
            );
          },
          RailHomeBookingPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => RailHomeDashboardState(),
                  child: Consumer<RailHomeDashboardState>(
                      builder: (context, state, _) =>
                          const RailHomeBookingPage()),
                ),
              ),
            );
          },
          TourismHomeBookingPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => TourismHomeDashboardState(),
                  child: Consumer<TourismHomeDashboardState>(
                      builder: (context, state, _) =>
                          const TourismHomeBookingPage()),
                ),
              ),
            );
          },
          SpecialHomeBookingPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => SpecialHomeDashboardState(),
                  child: Consumer<SpecialHomeDashboardState>(
                      builder: (context, state, _) =>
                          const SpecialHomeBookingPage()),
                ),
              ),
            );
          },
          FlightHomeBookingPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => FlightHomeDashboardState(),
                  child: Consumer<FlightHomeDashboardState>(
                      builder: (context, state, _) =>
                          const FlightHomeBookingPage()),
                ),
              ),
            );
          },
          FlightBookingDetailPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => FlightBookingDetailState(),
                  child: Consumer<FlightBookingDetailState>(
                      builder: (context, state, _) =>
                          const FlightBookingDetailPage()),
                ),
              ),
            );
          },
          EGoodsBookingDetailPage.routeName: (context) {
            return const EGoodsBookingDetailPage();
          },
          EGoodsHomeBookingPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => EGoodsHomeDashboardState(),
                  child: Consumer<EGoodsHomeDashboardState>(
                      builder: (context, state, _) =>
                          const EGoodsHomeBookingPage()),
                ),
              ),
            );
          },
          TransactionHistoryPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => TransactionHistoryState(),
                  child: Consumer<TransactionHistoryState>(
                      builder: (context, state, _) =>
                          const TransactionHistoryPage()),
                ),
              ),
            );
          },
          RailBookingDetailPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => RailBookingDetailState(),
                  child: Consumer<RailBookingDetailState>(
                      builder: (context, state, _) =>
                          const RailBookingDetailPage()),
                ),
              ),
            );
          },
          TourismBookingDetailPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => TourismBookingDetailState(),
                  child: Consumer<TourismBookingDetailState>(
                      builder: (context, state, _) =>
                          const TourismBookingDetailPage()),
                ),
              ),
            );
          },
          SpecialBookingDetailPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => SpecialBookingDetailState(),
                  child: Consumer<SpecialBookingDetailState>(
                      builder: (context, state, _) =>
                          const SpecialBookingDetailPage()),
                ),
              ),
            );
          },
          SpecialTicketPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => SpecialTicketState(),
                  child: const SpecialTicketPage(),
                ),
              ),
            );
          },
          SpecialDetailPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => SpecialDetailState(),
                  child: const SpecialDetailPage(),
                ),
              ),
            );
          },
          SpecialCustomerPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => SpecialCustomerState(),
                  child: const SpecialCustomerPage(),
                ),
              ),
            );
          },
          TourismTicketPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => TourismTicketState(),
                  child: const TourismTicketPage(),
                ),
              ),
            );
          },
          TourismResultPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => TourismResultState(),
                  child: const TourismResultPage(),
                ),
              ),
            );
          },
          TourismWagonPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => TourismWagonState(),
                  child: const TourismWagonPage(),
                ),
              ),
            );
          },
          TourismDetailPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => TourismDetailState(),
                  child: const TourismDetailPage(),
                ),
              ),
            );
          },
          TourismCustomerPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => TourismCustomerState(),
                  child: const TourismCustomerPage(),
                ),
              ),
            );
          },
          HotelSearchPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => HotelSearchState(),
                  child: Consumer<HotelSearchState>(
                      builder: (context, state, _) => const HotelSearchPage()),
                ),
              ),
            );
          },
          HotelListPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => HotelListState(),
                  child: Consumer<HotelListState>(
                      builder: (context, state, _) => const HotelListPage()),
                ),
              ),
            );
          },
          HotelDetailPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => HotelDetailState(),
                  child: Consumer<HotelDetailState>(
                      builder: (context, state, _) => const HotelDetailPage()),
                ),
              ),
            );
          },
          HotelRoomDetailPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => HotelRoomDetailState(),
                  child: Consumer<HotelRoomDetailState>(
                      builder: (context, state, _) => HotelRoomDetailPage()),
                ),
              ),
            );
          },
          HotelOrderPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => HotelOrderState(),
                  child: Consumer<HotelOrderState>(
                      builder: (context, state, _) => const HotelOrderPage()),
                ),
              ),
            );
          },
          HotelCheckoutPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => HotelCheckoutState(),
                  child: Consumer<HotelCheckoutState>(
                      builder: (context, state, _) =>
                          const HotelCheckoutPage()),
                ),
              ),
            );
          },
          HotelOrderLoadingPage.routeName: (context) {
            return HotelOrderLoadingPage();
          },
          HotelDokuPaymentPage.routeName: (context) {
            return const HotelDokuPaymentPage();
          },
          GoodsDashboardPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => GoodsHomeState(),
                  child: Consumer<GoodsHomeState>(
                      builder: (context, state, _) =>
                          const GoodsDashboardPage()),
                ),
              ),
            );
          },
          GoodsPulsaHomePage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => PulsaHomeState(),
                  child: Consumer<PulsaHomeState>(
                      builder: (context, state, _) =>
                          const GoodsPulsaHomePage()),
                ),
              ),
            );
          },
          GoodsPulsaPaymentMethodPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => SpecialCustomerState(),
                  child: const SpecialCustomerPage(),
                ),
              ),
            );
          },
          MiceSearchPage.routeName: (context) {
            return const MiceSearchPage();
          },
          TourismListPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => TourismListState(),
                  child: const TourismListPage(),
                ),
              ),
            );
          },
          TourismDestinationPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => TourismDestinationState(),
                  child: const TourismDestinationPage(),
                ),
              ),
            );
          },
          TourismCheckoutPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => TourismCheckoutState(),
                  child: const TourismCheckoutPage(),
                ),
              ),
            );
          },
          DetailOtherPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => TourismTicketState(),
                  child: const DetailOtherPage(),
                ),
              ),
            );
          },
          GoodsBrandPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => BrandState(),
                  child: const GoodsBrandPage(),
                ),
              ),
            );
          },
          GoodsListrikHomePage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => BrandState(),
                  child: const GoodsListrikHomePage(),
                ),
              ),
            );
          },
          GoodsListrikCheckoutPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => ListrikHomeState(),
                  child: const GoodsListrikCheckoutPage(),
                ),
              ),
            );
          },
          DigitalGoodsSelectPaymentMethodPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => DigitalGoodsSelectPaymentMethodState(),
                  child: const DigitalGoodsSelectPaymentMethodPage(),
                ),
              ),
            );
          },
          DigitalGoodsSelectedPaymentPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => DigitalGoodsSelectedPaymentState(),
                  child: const DigitalGoodsSelectedPaymentPage(),
                ),
              ),
            );
          },
          DigitalGoodsSelectedPaymentPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => DigitalGoodsSelectedPaymentState(),
                  child: const DigitalGoodsSelectedPaymentPage(),
                ),
              ),
            );
          },
          GoodsDokuPaymentPage.routeName: (context) {
            return Consumer<PrefsState>(
              builder: (context, notifier, _) => OverrideLocalization(
                locale: notifier.locale,
                child: ChangeNotifierProvider(
                  create: (context) => DigitalGoodsSelectedPaymentState(),
                  child: const GoodsDokuPaymentPage(),
                ),
              ),
            );
          },
          PdfViewerPage.routeName: (context) => const PdfViewerPage(),
        },
      ),
    );
  }
}
