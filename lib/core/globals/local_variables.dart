
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../Model/usermodel/user_model.dart';

var editTransaction = StateProvider<bool>((ref){
  return false;
});

Box? userDataBox;


UserModel? customerData;