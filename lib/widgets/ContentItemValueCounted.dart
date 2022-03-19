import 'package:flutter/material.dart';

class ContentItemValueCounted extends StatelessWidget {
  const ContentItemValueCounted(
      {Key? key, required this.nbValue, required this.icon})
      : super(key: key);
  final int nbValue;
  final IconData icon;

  String displayNbValue(nb) {
    var arrayValue = nb.toString().split('');

    if (nb >= 10000 && nb < 100000) {
      return createdValueMessage(3, arrayValue);
    }
    if (nb >= 100000 && nb < 1000000) {
      return createdValueMessage(4, arrayValue);
    }
    if (nb >= 1000000 && nb < 10000000) {
      return createdValueMessage(5, arrayValue);
    }
    if (nb >= 10000000 && nb < 100000000) {
      return createdValueMessage(6, arrayValue);
    }
    if (nb >= 100000000 && nb < 1000000000) {
      return createdValueMessage(7, arrayValue);
    }

    return '$nb';
  }

  String createdValueMessage(int loopTurn, List<String> arrayValue) {
    var valueMessage = '';
    var indicatorTotalValue = 'K';

    if (loopTurn >= 5 && loopTurn < 8) indicatorTotalValue = 'M';

    for (var i = 0; i < loopTurn; i++) {
      if (i == loopTurn - 1 && indicatorTotalValue == 'K') {
        valueMessage += '.' + arrayValue[i] + ' $indicatorTotalValue';
      } else if (i == loopTurn - 4) {
        valueMessage += '.' + arrayValue[i];
      } else if (i == loopTurn - 3) {
        valueMessage += arrayValue[i] + ' $indicatorTotalValue';
        break;
      } else {
        valueMessage += arrayValue[i];
      }
    }
    return valueMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            icon,
            size: 36.0,
            color: Colors.white,
          ),
        ),
        Text(
          displayNbValue(nbValue),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
