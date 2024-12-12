import 'package:agrohub/Model/bookModel.dart';
import 'package:agrohub/Model/purchase/purchaseModel.dart';
import 'package:agrohub/features/Home/screen/selectShop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Model/TransactionModel/transactionModel.dart';
import '../repository/book_repository.dart';


final bookControllerProvider = StateNotifierProvider((ref) {return BookController(bookRepository: ref.watch(bookRepositoryProvider), ref: ref);
});
final getBooksProvider= StreamProvider.autoDispose((ref) {
  final getRepBook=ref.watch(bookControllerProvider.notifier);
  return getRepBook.getBooks();
} );
final getAllTransactionPurchaseProvider= StreamProvider.autoDispose((ref) {
  final getReptra=ref.watch(bookControllerProvider.notifier);
  return getReptra.getAllTransactionPurchase();
} );

final getAllTransactionPurchasein30daysProvider= StreamProvider.autoDispose((ref) {
  final getReptra=ref.watch(bookControllerProvider.notifier);
  return getReptra.getAllTransactionPurchaseIn30Days();
} );
// final creditControllerProvider=StreamProvider.family<double,String>((ref,data){
//   return ref.watch(bookControllerProvider.notifier).getCredit(data);
// });
class BookController  extends StateNotifier<bool>{

  final BookRepository _bookRepository;
  final Ref _ref;

  BookController({required BookRepository bookRepository,required Ref ref}):
        _bookRepository=bookRepository,_ref=ref, super(false);

  addBook({required BuildContext context,required BookModel bookModel, }){
    // final repositoryData=ref.watch(productRepositoryProvider);
    _bookRepository.addBook(bookModel: bookModel, context: context);

    // final data= repositoryData.addProduct(productmodel: productmodel);


  }
  updateBook({required BuildContext context,required BookModel bookModel, }){
    // final repositoryData=ref.watch(productRepositoryProvider);
    _bookRepository.updateBook(bookModel: bookModel, context: context);

    // final data= repositoryData.addProduct(productmodel: productmodel);
  }
  deleteBook({required BuildContext context,required BookModel bookModel, }){
    // final repositoryData=ref.watch(productRepositoryProvider);
    _bookRepository.deleteBook(bookModel: bookModel, context: context);

    // final data= repositoryData.addProduct(productmodel: productmodel);
  }
  Stream<List<BookModel>>getBooks(){
    final shopId=currentshopId;
    return
      // ref.watch(productRepositoryProvider).getProducts();
      _bookRepository.getBooks(shopId!);
  }

  Stream<List>getAllTransactionPurchase(){

    DateTime today = DateTime.now();
    DateTime startOfToday = DateTime(today.year, today.month, today.day,0,0,0,0,0);
    return _bookRepository.getAllTransactionPurchase( startOfToday: startOfToday);


  }
  Future<double> getCredit(String bookId)async{
   //   final a= await _bookRepository.getCredit(bookId);
   //  // return  _ref.read(bookRepositoryProvider).getCredit(bookId);
   //   print('controller');
   //   print(bookId);
   //  print(a);
   // return a;

    return _bookRepository.getCredit(bookId);

  }

  Future getUsers(List members)async{
    return _bookRepository.getUsers(members);

  }


  Stream<List>getAllTransactionPurchaseIn30Days(){

    DateTime today = DateTime.now();
    DateTime startOfToday = DateTime(today.year, today.month, today.day,0,0,0,0,0);
    return _bookRepository. getAllTransactionPurchaseIn30Days( startOfToday: startOfToday);


  }

  createPurchase({required BuildContext context,required PurchaseModel purchaseData, }){
    // final repositoryData=ref.watch(productRepositoryProvider);
    _bookRepository.createPurchase(purchaseData ,context);

    // final data= repositoryData.addProduct(productmodel: productmodel);


  }
}