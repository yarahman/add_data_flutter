import 'package:basic_flutter_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactions = [];
  final Function deletTransaction;

  TransactionList(this.transactions, this.deletTransaction);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundColor: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: FittedBox(
                child: Text(
                  '\$${transactions[index].amount}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
          title: Text(
            '${transactions[index].title}',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          subtitle: Text(
            DateFormat.yMMMMEEEEd()
                .format(transactions[index].date as DateTime),
          ),
          trailing: IconButton(
            onPressed: () {
              deletTransaction(transactions[index].id);
            },
            icon: Icon(
              Icons.delete_forever,
              color: Theme.of(context).errorColor,
            ),
          ),
        );
      },
      itemCount: transactions.length,
    );
  }
}
