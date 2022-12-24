import 'package:kai_wisata/digital_goods/models/digital_goods_transaction.dart';
import 'package:kai_wisata/digital_goods/models/postpaid_listrik.dart';

class DigitalGoodsSelectedPaymentArguments {
  final DigitalGoodsTransaction transaction;
  final PostpaidListrik tagihan;
  final int transactionId;
  final String nama;
  final int adm;
  final int tagihanListrik;

  DigitalGoodsSelectedPaymentArguments(this.transaction, this.tagihan,
      this.transactionId, this.nama, this.adm, this.tagihanListrik);
}
