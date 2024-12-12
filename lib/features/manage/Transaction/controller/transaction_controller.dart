import 'dart:convert';

import 'package:agrohub/Model/TransactionModel/transactionModel.dart';
import 'package:agrohub/model/purchase/purchaseModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Model/bookModel.dart';
import '../repository/transaction_repository.dart';

final transactionControllerProvider = StateNotifierProvider((ref) {return TransactionController(transactionRepository: ref.watch(transactionRepositoryProvider), ref: ref);
});

final getTransactionProvider= StreamProvider.autoDispose((ref) {
      final getRepTra=ref.watch(transactionControllerProvider.notifier);
      return getRepTra.getTransaction();
    } );
final getPurchaseProvider= StreamProvider.autoDispose((ref) {
  final getRepPur=ref.watch(transactionControllerProvider.notifier);
  return getRepPur.getPurchases();
} );
final getTotalCreditProvider= StreamProvider.autoDispose((ref) {
  final getRepCredit=ref.watch(transactionControllerProvider.notifier);
  return getRepCredit.getTotalCredit();
} );
final getCustomerProvider=StreamProvider.autoDispose((ref){
  final getRepCust=ref.watch(transactionControllerProvider.notifier);
  return getRepCust.getCustomers();

});

class TransactionController extends StateNotifier<bool>{



  final TransactionRepository _transactionRepository;
  final Ref _ref;
  TransactionController({required TransactionRepository transactionRepository,required Ref ref}):
        _transactionRepository=transactionRepository,_ref=ref, super(false);

  Stream<List<TransactionModel>>getTransaction(){

    DateTime fromdate= DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,0,0,0);
    DateTime todate =DateTime.now();
    return _transactionRepository.getTransaction(fromdate:  fromdate, todate:todate);


  }
  Stream<List<PurchaseModel>>getPurchases(){

    DateTime fromdate= DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,0,0,0);
    DateTime todate =DateTime.now();
    return _transactionRepository.getPurchases(fromdate:  fromdate, todate:todate);


  }
  Stream<List<BookModel>>getTotalCredit(){

    return _transactionRepository.getTotalCredit();


  }
  Stream<List<BookModel>>getCustomers(){
    return _transactionRepository.getCustomers();
  }
}