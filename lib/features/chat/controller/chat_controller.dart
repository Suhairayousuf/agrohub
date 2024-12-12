import 'package:agrohub/features/chat/repository/chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Model/bookModel.dart';
final chatControllerProvider =
    StateNotifierProvider((ref) {return ChatController(chatRepository: ref.watch(chatRepositoryProvider), ref: ref);});

final getchatStreamProvider= StreamProvider.autoDispose<List<dynamic>>((ref) {
  final getRepchat=ref.watch(chatControllerProvider.notifier);
  return getRepchat.getAllMembers();
} );

class ChatController extends StateNotifier<bool>{
  final ChatRepository _chatRepository;
  final Ref _ref;
  ChatController({required ChatRepository chatRepository,required Ref ref}):
        _chatRepository=chatRepository,_ref=ref, super(false);

 Future<int> getUnreadChat(String userId) async {
    return _chatRepository.getUnreadChat(userId);

    // FirebaseFirestore
    //     .instance
    //     .collection('users')
    //     .doc(userId)
    //     .collection('chat').where('isRead',isEqualTo: false).
    //      where('receiverId',isEqualTo: currentshopId)
    //     .snapshots().listen((event) {
    //      msgCount=event.docs.length;
    //
    //
    //      if(mounted){
    //        setState(() {
    //
    //        });
    //      }
    // });
  }

  Stream<List<dynamic>>getAllMembers(){
      // ref.watch(productRepositoryProvider).getProducts();
    return _chatRepository.getAllMembers();

  }
  sendMessage(userId,message,imgUrl) {
         return _chatRepository.sendMessage(userId, message, imgUrl)   ;
  }

}