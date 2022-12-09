import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        var totalSum = 0.0;
        for (var i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].date.day == weekDay.day &&
              recentTransactions[i].date.month == weekDay.month &&
              recentTransactions[i].date.year == weekDay.year) {
            totalSum += recentTransactions[i].amount;
          }
        }

        // print(DateFormat.E().format(weekDay));
        // print(totalSum);

        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': totalSum
        };
      },
    ).reversed.toList();
  }

  double get totalSpending {
    return groupTransactionValues.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element['amount'] as double));
  }

  const Chart(this.recentTransactions, {super.key});

  @override
  Widget build(BuildContext context) {
    // print(groupTransactionValues);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactionValues
              .map(
                (data) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: data['day'].toString(),
                    spendingAmount: (data['amount'] as double),
                    spendingPctOfTotal: totalSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / (totalSpending),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
