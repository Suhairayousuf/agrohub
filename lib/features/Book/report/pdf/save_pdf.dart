import 'dart:io';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async{
  final path = (await getExternalStorageDirectory())?.path;
  final file =  File('$path/$fileName');
  await file.writeAsBytes(bytes,flush: true);
  OpenFilex.open('$path/$fileName');
}