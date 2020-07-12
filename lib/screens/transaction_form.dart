import 'dart:async';

import 'package:bytebank_persistencia/components/progress.dart';
import 'package:bytebank_persistencia/components/response_dialog.dart';
import 'package:bytebank_persistencia/components/transaction_auth_dialog.dart';
import 'package:bytebank_persistencia/http/webclients/transactions_webclient.dart';
import 'package:bytebank_persistencia/models/contact.dart';
import 'package:bytebank_persistencia/models/transaction.dart';
import 'package:bytebank_persistencia/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final String transactionId = Uuid().v4();

  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: _sending,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Progress(message: 'Sending...'),
                ),
              ),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      final double value =
                          double.tryParse(_valueController.text);
                      final transactionCreated =
                          Transaction(transactionId, value, widget.contact);
                      showDialog(
                        context: context,
                        builder: (contextDialog) {
                          return TransactionAuthDialog(
                              onConfirm: (String password) {
                            _save(transactionCreated, dependencies.transactionWebClient, password, context);
                          });
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(
    Transaction transactionCreated,
    TransactionWebClient webClient,
    String password,
    BuildContext context,
  ) async {
    Transaction transaction = await _send(webClient, transactionCreated, password, context);
    _showSuccessfullMessage(transaction, context);
  }

  Future _showSuccessfullMessage(Transaction transaction, BuildContext context) async {
    if (transaction != null) {
      await showDialog(context: context, builder: (contextDialog) {
        return SuccessDialog('Successfull Transaction!');
      });
      Navigator.pop(context);
    }
  }

  Future<Transaction> _send(TransactionWebClient webClient, Transaction transactionCreated, String password, BuildContext context) async {
    setState(() => _sending = true);
    final Transaction transaction = await webClient.save(transactionCreated, password).catchError((error) {
      _showFailureMessage(context, message: error.message);
    }, test: (error) => error is HttpException).catchError((e) {
      _showFailureMessage(context, message: 'Timeout on submitting transaction');
    }, test: (error) => error is Exception).whenComplete(() => setState(() => _sending = false));

    return transaction;
  }

  void _showFailureMessage(BuildContext context, {String message = 'Unknown Error'}) {
    showDialog(context: context, builder: (contextDialog) {
      return FailureDialog(message);
    });
  }
}
