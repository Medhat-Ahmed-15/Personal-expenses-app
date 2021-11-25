import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactionvalues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalSum += recentTransaction[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      }; // the substring is used get every first letter for every week day as a shortcut
    }).reversed.toList();
  }

  double get maxSpendingOfWeek {
    return groupedTransactionvalues.fold(
        0.0, (prevTotal, item) => prevTotal + item['amount']);
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionvalues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        //i wrapped the row with a container to add some padding around the bars and if I found myself creating a container only to add padding then there is a replacement ,I can then just use the padding widget and they're basically simpler containerss which can only be used to add padding
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceAround, //this is used to make spaces between bars
          children: groupedTransactionvalues.map((data) {
            return Flexible(
              fit: FlexFit
                  .tight, //now i wrapped the ChartBar that  contain the bars with flexible widget to make sure that whenever the size of price above the single bar increases it doesn't take space from the whole card try enterin a large amount like this 123455540.88 before using Flexible and after using Flexible to understand what's happening
              child: ChartBar(
                  data['day'],
                  data['amount'],
                  maxSpendingOfWeek == 0
                      ? 0.0
                      : (data['amount'] as double) / maxSpendingOfWeek),
            ); //i made it as double so i can divide it since the operator '\' couldn't see that the returning from data['amount'] is double
          }).toList(), //((maxSpendingOfWeek==0 ? 0.0 :))) i made this condition because it shows up an error if maxspending =0 since i can't divide anything by zero
        ),
      ),
    );
  }
}
