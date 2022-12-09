import 'package:flutter/material.dart';
import 'package:personal_expenses_app/widgets/chart.dart';
import 'package:personal_expenses_app/widgets/new_transaction.dart';
import 'package:personal_expenses_app/widgets/transaction_list.dart';

import 'models/transaction.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      title: "Personal Expenses",
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
            .copyWith(secondary: Colors.orange),
        fontFamily: 'Quicksand',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late String titleInput;
  final List<Transaction> _userTransactions = [
    // Transaction(id: 't1', title: 'New shoes', amount: 69.9, date: DateTime.now()),
    // Transaction(id: 't2', title: 'clothes', amount: 10, date: DateTime.now())
  ];

  Iterable<Transaction> get _recentTransactions {
    return _userTransactions.where(
      (element) => element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      ),
    );
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime selectedTime) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: selectedTime,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: ((context) {
          return NewTransaction(_addNewTransaction);
        }));
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personal Expenses",
        ),
        actions: <Widget>[
          IconButton(
            onPressed: (() => _startAddNewTransaction(context)),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Chart(_recentTransactions.toList()),
            ),
            TransactionList(_userTransactions, _deleteTransaction)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startAddNewTransaction(context);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
