class FormatNumber {
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
      } else if (i == loopTurn - 4 && indicatorTotalValue == 'K') {
        valueMessage += arrayValue[i];
      } else if (i == loopTurn - 4 && indicatorTotalValue == 'M') {
        valueMessage += '.' + arrayValue[i];
      } else if (i == loopTurn - 3 && indicatorTotalValue == 'K') {
        valueMessage += arrayValue[i];
      } else if (i == loopTurn - 3 && indicatorTotalValue == 'M') {
        valueMessage += arrayValue[i] + ' $indicatorTotalValue';
        break;
      } else {
        valueMessage += arrayValue[i];
      }
    }
    return valueMessage;
  }
}
