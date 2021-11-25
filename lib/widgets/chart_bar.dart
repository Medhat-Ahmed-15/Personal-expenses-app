import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
              // i wrapped the fitted box with a container so that when the amount becomes very big it doesn't effect the height  of the bar ragrding the other bars
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                  child: Text('\$${spendingAmount.toStringAsFixed(0)}')),
            ), //i wrapped my text with FittedBox to force its child which is the text to fit into it's available space try entering a large amount like this 123455540.88 before using FittedBox and after using FittedBox to understand what's happening
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight *
                  0.6, //giving it  only 70% of the maximum height it can take and this will give me error spacing if i kept the rest of the values of the text amount and labels staic values not dynamic since the bar cant fit 70% with all these static values it's too big
              width: 10,
              child: Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  )),
                  FractionallySizedBox(
                    //this allows me to create a box that is sized as a fraction of another value an i need to add a height factor and that height factor should be a value between 0 and 1 where 1 is 100% of the surrounding container which is 60 and since I can't add a decoration for FractionallySizedBox i will add a container then I will remove container and put padding
                    heightFactor: spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              child: FittedBox(child: Text(label)),
              height: constraints.maxHeight * 0.15,
            ),
          ],
        );
      },
    );
  }
}
