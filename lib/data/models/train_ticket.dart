class TrainTicket {
  TrainTicket({
    this.id,
    this.statusType,
    this.statusName,
    this.routeName,
    this.routeFrom,
    this.routeDestination,
    this.trainName,
    this.date,
    this.orderId,
  });

  final int? id;
  final String? statusType;
  final String? statusName;
  final String? routeName;
  final String? routeFrom;
  final String? routeDestination;
  final String? trainName;
  final String? date;
  final String? orderId;
}
