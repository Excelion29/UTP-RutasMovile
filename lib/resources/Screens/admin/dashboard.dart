import 'package:iipvm/resources/widgets/app.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AppLayoutWidget(
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Card(child: _SampleCard(cardName:"Elevated Card")),
          Card.filled(child: _SampleCard(cardName:"Filled Card")),
          Card.outlined(child: _SampleCard(cardName:"Outline Card"))
        ],
      )
    );
  }
}

class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.cardName});
  final String cardName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 100,
      child: Center(child: Text(cardName)),
    );
  }
}