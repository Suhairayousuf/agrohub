


import 'package:agrohub/Model/OfferModel/offerModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/offer_repository.dart';

final offerControllerProvider=StateNotifierProvider((ref) {
  return OfferController(offerRepository: ref.watch(offerRepositoryProvider), ref: ref);


});
final getOfferProvider= StreamProvider.autoDispose((ref) {
  final getRepOffer=ref.watch(offerControllerProvider.notifier);
  return getRepOffer.getOffers();
} );
class OfferController extends StateNotifier<bool>{
  final OfferRepository _offerRepository;
  final Ref _ref;

  OfferController({required OfferRepository offerRepository,required Ref ref}):
        _offerRepository=offerRepository,_ref=ref, super(false);

  addOffer({ required BuildContext context,required OfferModel offerModel}){
    _offerRepository.addOffer(context, offerModel);

  }
  Stream<List<OfferModel>>getOffers(){
    return _offerRepository.getOffers();

  }

}