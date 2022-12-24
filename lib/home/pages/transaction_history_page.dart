import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kai_wisata/commons/models/transaction.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/home/models/history_payment.dart';
import 'package:kai_wisata/kai_reguler/arguments/passenger_data_arguments.dart';
import 'package:kai_wisata/home/providers/transaction_history_state.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:kai_wisata/widgets/kai_last_transaction.dart';
import 'package:kai_wisata/widgets/kai_text_field.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TransactionHistoryPage extends StatefulWidget {
  static const routeName = '/transaction-history-pages';

  const TransactionHistoryPage({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  TransactionHistoryState? state;

  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();

  int page = 1;
  int perPage = 10;
  String orderBy = "desc";
  String sortBy = "id";
  String trxStatus = "";
  String payStatus = "";
  String productType = "";

  @override
  initState() {
    super.initState();
  }

  Widget buildHistory(Transaction payment){
    return Padding(
      padding: const EdgeInsets.only(
        right: 18.0,
        left: 18.0,
        bottom: 10.0,
      ),
      child: KaiLastTransaction(
        onClick: () {},
        title: "${payment.excerpt(25)}",
        subtitle: DateFormat("dd MMM yyyy").format(payment.transactionDate),
        status: payment.status.display,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    state = Provider.of<TransactionHistoryState>(context);
    state?.initState(context, scaffoldKey);
    state?.fetchHistories(page, perPage, orderBy, sortBy, trxStatus, payStatus, productType);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: KaiColor.blue,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(
                                20.0,
                              ),
                              child: InkWell(
                                child: SvgPicture.asset(
                                  'assets/svg/arrow_left.svg',
                                  height: 18,
                                  color: KaiColor.white,
                                ),
                                onTap: () => state?.onBackButton(),
                              ),
                            ),
                            Text(
                              'Riwayat Pemesanan',
                              style: KaiTextStyle.titleSmallBold
                                  .apply(color: KaiColor.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 20,
                      child: SvgPicture.asset(
                        'assets/svg/ic_silhoutte.svg',
                        height: 200,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 18.0,
                      right: 18.0,
                      top: 18.0,
                      bottom: 10.0,
                    ),
                    child: Text(
                      'Riwayat Pemesanan',
                      style: KaiTextStyle.bodyLargeBold,
                    ),
                  ),
        Container(
          height: MediaQuery.of(context).size.height*0.45,
          child:
          ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                      children: <Widget>[
                        ...(state!.histories.map((e) => buildHistory(e)))]
                  )),
                  KaiButton(
                    padding: const EdgeInsets.all(18.0),
                    text: 'Lihat Semua Transaksi',
                    onClick: () {},
                    buttonColor: KaiColor.white,
                    textColor: KaiColor.blue,
                    sideColor: KaiColor.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
