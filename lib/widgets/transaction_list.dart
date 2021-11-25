import 'dart:ui';

import 'package:flutter/material.dart';
import '../models/transaction.dart'; //dot dot because we need to go up one level where in the widgets folder, dot dot tells dart to go up one level so out of thewidgets folder and then it looks for a new folder models which then exists in that lib folder in which we then are and there, in the models folder, it gets access to the transaction.dart

import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  Function _removeTransaction;

  TransactionList(this.transactions, this._removeTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'No transactions added yet!!',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: 20,
                    ), //this is used to maked spaces between widgets
                    Container(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.fill,
                        )),
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Text(
                          '\$${transactions[index].amount.toStringAsFixed(2)}', //toStringAsFixed(2) this will make every value has exactly two decimal places
                          style: TextStyle(
                              color: Colors.amber, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      //  DateFormat('yyyy/MM/dd').format(tx.date), i can write my own format like this between brackets in dateFormat or

                      DateFormat.yMMMd().format(transactions[index].date),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    trailing: MediaQuery.of(context).size.width > 450
                        ? FlatButton.icon(
                            onPressed: () => _removeTransaction(index),
                            icon: Icon(Icons.delete),
                            label: Text('Delete'),
                            textColor: Theme.of(context).errorColor,
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context)
                                .errorColor, //i dont have to define it in material app its my by default its color is red
                            onPressed: () => _removeTransaction(index),
                          ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
