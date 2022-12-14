import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/widgets/adaptive_text_button.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction(this.addNewTx, {super.key});
  final Function addNewTx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _amountController = TextEditingController();
  final _titleController = TextEditingController();
  DateTime? _selectedDate;
  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return; //means stop the function and return it
    }

    widget.addNewTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _percentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickDate) {
      if (pickDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                onSubmitted: ((value) => _submitData()),
                // onChanged: ((value) => titleInput = value),
              ),
              TextField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount '),
                keyboardType: TextInputType.number,
                onSubmitted: (value) => _submitData(),
                // onChanged: (value) => amountInput = value,
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? "No Date Chosen!"
                          : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate!)}'),
                    ),
                    AdaptiveTextButton('Choose Date', _percentDatePicker)
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // print(titleInput);
                  // print(amountInput);
                  // print(_titleController.text);
                  // print(_amountController.text);
                  _submitData();
                },
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                child: const Text("Add Transaction"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
