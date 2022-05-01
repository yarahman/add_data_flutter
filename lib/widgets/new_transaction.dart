import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _seletedDate;

  void _onSubmited() {
    final enterTitle = titleController.text;
    final enterAmount = double.parse(amountController.text);

    if (enterTitle.isEmpty || enterAmount <= 0 || _seletedDate == null) {
      return;
    }

    widget.addTx(enterTitle, enterAmount, _seletedDate);

    Navigator.pop(context);
  }

  void _presentDatePiccker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018, 1, 1),
      lastDate: DateTime.now(),
    ).then(
      (pickedData) {
        if (pickedData == null) {
          return;
        }
        setState(() {
          _seletedDate = pickedData;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'title'),
              controller: titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'amount'),
              controller: amountController,
              onSubmitted: (_) {
                _onSubmited();
              },
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _seletedDate == null
                        ? 'No Date Chosen!'
                        : 'Picked Date : ${DateFormat.yMMMMEEEEd().format(_seletedDate!)}',
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _presentDatePiccker();
                  },
                  icon: const Icon(Icons.date_range_rounded),
                  color: Theme.of(context).primaryColor,
                  iconSize: 35.0,
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                _onSubmited();
              },
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
