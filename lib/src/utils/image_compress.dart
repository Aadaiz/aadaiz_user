import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class Images {


  File compressedFiled =File('');
  Future<dynamic> compressImage({
    required XFile imageFile,
    int quality = 50,
    CompressFormat format = CompressFormat.jpeg,
  }) async {
    print('Compression started');
    File compressedFiled =File('');
    DateTime now = DateTime.now();
    final String targetPath =  p.join(Directory.systemTemp.path, '$now.${format.name}');

    // Get the original file size
    final File originalFile = File(imageFile.path);
    final int originalSize = await originalFile.length(); // Size in bytes

    final XFile? compressedImage = await FlutterImageCompress.compressAndGetFile( imageFile.path,
      targetPath,
      quality: quality,
      format: format,);

    if (compressedImage == null) {
      print('Compression failed');
    } else {
      final File compressedFile = File(compressedImage.path);
      final int compressedSize = await compressedFile.length();
      compressedFiled= File(compressedImage.path);
      print('Original size: ${(originalSize / 1024).toStringAsFixed(2)} KB');
      print('Compressed size: ${(compressedSize / 1024).toStringAsFixed(2)} KB');
      return compressedFile;
      // final int compressedSize = await compressedFile.length(); // Size in bytes


    }
  }
}