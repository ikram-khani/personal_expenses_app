import 'package:flutter/material.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  Function deleteTx;
  TransactionList(this.userTransaction, this.deleteTx, {super.key});
  final List userTransaction;

  @override
  Widget build(BuildContext context) {
    return userTransaction.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Text(
                  "No Transaction Added Yet!",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: userTransaction.length,
            itemBuilder: (context, index) {
              return TransactionItem(
                  transaction: userTransaction[index], deleteTx: deleteTx);
            });
  }
}
