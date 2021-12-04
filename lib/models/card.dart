class CardModel {
  CardModel({
    required this.id,
    required this.name,
    required this.cardExpiration,
    required this.cardHolder,
    required this.cardNumber,
    required this.category,
  });

  String id;
  String name;
  String cardExpiration;
  String cardHolder;
  String cardNumber;
  String category;

  factory CardModel.fromMap(Map<String, dynamic> json) {
    return CardModel(
      id: json["id"],
      name: json["name"],
      cardExpiration: json["cardExpiration"],
      cardHolder: json["cardHolder"],
      cardNumber: json["cardNumber"],
      category: json["category"],
    );
  }

  Map<String, dynamic> toMap() => {
        "name": name,
        "cardExpiration": cardExpiration,
        "cardHolder": cardHolder,
        "cardNumber": cardNumber,
        "category": category,
      };
}
