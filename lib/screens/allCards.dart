import 'package:credit_card_project/models/card.dart';
import 'package:credit_card_project/services/auth.dart';
import 'package:credit_card_project/services/cardServices.dart';
import 'package:credit_card_project/utils/RoutingUtils.dart';
import 'package:credit_card_project/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final List<Color> colors = [
    Color(0xff57608b),
    Color(0xffd28f98),
    Color(0xff90719a),
    Color(0xffe1aead),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.read<AuthService>().logout();
            Navigator.popUntil(context, (route) => false);
            Navigator.pushNamed(context, Routes.login);
          },
          icon: Icon(Icons.logout),
        ),
        centerTitle: true,
        title: Text("All Cards"),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.newCard),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<List<CardModel>>(
                stream: CardServices()
                    .getCards(jwt: context.watch<AuthService>().jwt)
                    .asStream(),
                builder: (context, snapshot) {
                  List<CardModel> data = snapshot.data ?? [];
                  return Container(
                    height: 200 + (data.length * 45),
                    child: Stack(
                      children: List.generate(
                        data.length,
                        (index) => Positioned(
                          top: index * 45.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 16,
                            child: FullCard(
                              card: data[index],
                              color: colors[index % 4],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, Routes.newCard),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text("+ Add New Account")),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
