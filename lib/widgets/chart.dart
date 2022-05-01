import 'package:basic_flutter_app/models/transaction.dart';
import 'package:basic_flutter_app/widgets/chart_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  Chart(this.recentTransaction);

  List<Transaction> recentTransaction = [];

  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date?.day == weekDay.day &&
            recentTransaction[i].date?.month == weekDay.month &&
            recentTransaction[i].date?.year == weekDay.year) {
          totalSum += recentTransaction[i].amount!;
        }
      }
      print(
        DateFormat.E().format(weekDay).substring(0, 1),
      );
      print(totalSum);

      return {
        'date': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpanding {
    return groupTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupTransactionValues);
    return Card(
      elevation: 6.0,
      margin: EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['date'] as String,
                  data['amount'] as double,
                  totalSpanding == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpanding),
            );
          }).toList(),
        ),
      ),
    );
  }
}
