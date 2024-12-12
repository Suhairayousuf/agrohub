import 'package:agrohub/features/Home/repository/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Model/OfferModel/offerModel.dart';
import '../../../Model/bookModel.dart';
import '../../../model/shop_model/shop_model.dart';
final homeControllerProvider = StateNotifierProvider((ref) {
  return HomeController(homeRepository: ref.watch(homeRepositoryProvider), ref: ref);
});


final getSettingsController=FutureProvider((ref){
  return ref.watch(homeControllerProvider.notifier).getsettings();
});

final getHomeStreamProvider= StreamProvider.autoDispose.family<List<StoreDetailsModel>,String>((ref,email) {
  final getRepShop=ref.watch(homeControllerProvider.notifier);
  return getRepShop.getShop(email);
} );

final getShopOffersProvider= StreamProvider.autoDispose.family<List<OfferModel>,String>((ref,shopId) {
  final getRepShop=ref.watch(homeControllerProvider.notifier);
  return getRepShop.getShopOffers(shopId);
} );
final getShopBooksProvider= StreamProvider.autoDispose.family<List<BookModel>,String>((ref,shopId) {
  final getRepShopBook=ref.watch(homeControllerProvider.notifier);
  return getRepShopBook.getShopBooks(shopId);
} );

class HomeController extends StateNotifier<bool>{
  HomeRepository _homeRepository;
  Ref _ref;
  HomeController({required HomeRepository homeRepository,required Ref ref }): _homeRepository=homeRepository,_ref=ref,super(false);

  Stream<List<StoreDetailsModel>>getShop( String email){
    return
      // ref.watch(productRepositoryProvider).getProducts();
      _homeRepository.getShop(email);
  }
  Stream<List<OfferModel>>getShopOffers( String shopId){
    return
      // ref.watch(productRepositoryProvider).getProducts();
      _homeRepository.getShopOffers(shopId);
  }
  Stream<List<BookModel>>getShopBooks( String shopId){

    return
      // ref.watch(productRepositoryProvider).getProducts();
      _homeRepository.getShopBooks(shopId);
  }




  Future<bool> getsettings()async{
    final setting=  _ref.watch(homeRepositoryProvider);
    final data=await setting.getsettings();
    return data;
    // final trans=setting.docs.forEach((element) {
    // });
    //
  }
}