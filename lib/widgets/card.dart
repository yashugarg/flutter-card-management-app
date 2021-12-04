import 'package:credit_card_project/models/card.dart';
import 'package:flutter/material.dart';

class FullCard extends StatelessWidget {
  final CardModel card;
  final Color color;
  const FullCard({required this.card, required this.color, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 200,
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset(
                    "assets/images/contact_less.png",
                    height: 20,
                    width: 18,
                  ),
                  Image.asset(
                    "assets/images/mastercard.png",
                    height: 50,
                    width: 50,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  card.cardNumber,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontFamily: 'CourrierPrime'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CardDetailsBlock(
                    label: 'CARDHOLDER',
                    value: card.cardHolder,
                  ),
                  CardDetailsBlock(
                    label: 'VALID THRU',
                    value: card.cardExpiration,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardDetailsBlock extends StatelessWidget {
  final String label;
  final String value;
  CardDetailsBlock({required this.label, required this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label',
          style: TextStyle(
              color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        Text(
          '$value',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
