import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  // dee kant stateless widget bs  ana hawaltha la statefull widget 3ashan lama 2ktb haga fa textfield mayat3amalahash clear lama 2arroh la textfield tany
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountContrller = TextEditingController();
  DateTime
      _selectedDate; //this is not final because this will change it has no value initially and it will receive a value once the user choose date

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountContrller.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return; // writing a return like this stops the execution of any function means the code after return is not reached
    }

    widget.addNewTransaction(
      // (widget.) dee 2at3mlha generate automaticaaly lama hawlt mn stateless la statefull w haya bat call el function el fa class Newtransaction bs el id howa widget
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime
          .now(), //el first w el last date arguments dol 3ashan a limit  el calender ta view dates mn emta la emta
    ).then((pickedDate) {
      //this function will be called once the user choose the date

      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                /*   onChanged: (inputValue) {
                        titleInput = inputValue;
                      }, */

                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountContrller,
                keyboardType: TextInputType.number,
                onSubmitted: (_) =>
                    _submitData(), //onSubmitted lazm ta5od function that in the end reacts to onSubmitted howa keda lazm hata lw msh hasta5dmha w howa f3ln ana msh hast5dmha (_) underscore is a convention to signal: i get an argument but I don't care about it here i have to accept it but I don't plan on using it
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      //I wrapped my text here with expanded so i can make the text take as much space as it needs and leaves the flat button at the most right which what i need
                      child: Text(_selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked date: ${DateFormat.yMd().format(_selectedDate)}'),
                    ),
                    FlatButton(
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _presentDatePicker,
                    )
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                onPressed: _submitData,
                textColor: Theme.of(context).textTheme.button.color,
              )
            ],
          ),
        ),
      ),
    );
  }
}
