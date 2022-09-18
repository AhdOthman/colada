import 'package:coladaapp/models/transaction/user_transaction_model.dart';
import 'package:coladaapp/services/api/transaction/get_user_transaction.dart';
import 'package:coladaapp/utils/failure.dart';
import 'package:coladaapp/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionProvider =
    ChangeNotifierProvider<TransactionProvider>((ref) => TransactionProvider());

class TransactionProvider with ChangeNotifier {
  List<UserTransaction>? _userTransaction;

  List<UserTransaction>? get getUserTransactionList => _userTransaction;
  setUserTransaction(List<UserTransaction> getUserTransaction) {
    _userTransaction = getUserTransaction;
    notifyListeners();
  }

  Future getUserTransaction(String customerId) async {
    try {
      final response = await GetUserTransaction(customerId: customerId).fetch();
      List<UserTransaction> transactionList = [];
      print("transaction $response");

      for (var transaction in response['dataResponse']['transaction']['data']) {
        transactionList.add(UserTransaction.fromJson(transaction));
      }
      setUserTransaction(transactionList);
      print("transaction ${transactionList.length}");

      return _userTransaction;
    } on Failure catch (f) {
      // UIHelper.showNotification(f.message);
      return f;
    }
  }
}
