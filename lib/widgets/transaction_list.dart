import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                elevation: 6,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('\$${userTransaction[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    userTransaction[index].title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(userTransaction[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 380
                      ? TextButton.icon(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Theme.of(context).errorColor,
                          ),
                          onPressed: (() {
                            deleteTx(userTransaction[index].id);
                          }),
                          icon: Icon(Icons.delete),
                          label: Text("Delete"),
                        )
                      : IconButton(
                          onPressed: (() {
                            deleteTx(userTransaction[index].id);
                          }),
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
            });
  }
}
