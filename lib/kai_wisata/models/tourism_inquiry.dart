import 'dart:convert';

class TourismInquiry {
  final String schedule;
  final int wagonId;
  final String wagonName;
  final String dataPemesan;
  final String noHpPemesan;

  TourismInquiry(this.schedule, this.wagonId, this.wagonName, this.dataPemesan,
      this.noHpPemesan);
}
