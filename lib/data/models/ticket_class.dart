enum TicketClass {
  economy,
  business,
  executive,
}

extension TicketClassExtension on TicketClass {

  String classToString() {
    switch(this){
      case TicketClass.economy: return "Ekonomi";
      case TicketClass.business: return "Bisnis";
      case TicketClass.executive: return "Eksekutif";
    }
  }

  TicketClass fromString(String str){
    switch(str){
      case "Ekonomi" : return TicketClass.economy;
      case "Bisnis" : return TicketClass.business;
      case "Eksekutif" : return TicketClass.executive;
      default : return TicketClass.economy;
    }
  }
}

class TicketClassDescription {
  final String title;
  final String description;

  TicketClassDescription(this.title, this.description);
  factory TicketClassDescription.fromEnum(TicketClass kelas){
    switch(kelas){
      case TicketClass.economy:
        return TicketClassDescription(
          "Economy", "Fly at the lowest cost, with all your basic needs covered.");
      case TicketClass.business:
        return TicketClassDescription("Business",
        "Fly in style, with exclusive check-in counters and seating..");
      case TicketClass.executive:
        return TicketClassDescription("Executive",
            "The most luxurious class, with personalized five-star services..");
    }
  }
}
