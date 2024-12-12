import 'dart:developer';
import 'dart:io';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File?> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getExternalStorageDirectory();
    final file = File('${dir?.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    log('pdf open start *******************');
    final url = file.path;
    log(url);
    log('URLLLL LLL LLLLLL');
    await OpenFilex.open(url);
    log('pdf open *******************');
  }

}