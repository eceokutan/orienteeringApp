import 'dart:io' as io;

import 'package:flutter/foundation.dart';

class FileModel {
  FileModel(
      {this.fileBytes,
      this.fileName = "",
      this.fileTypeExtension = "",
      this.file});
  io.File? file;
  Uint8List? fileBytes;
  String fileName = "";
  String fileTypeExtension = "";

  String get contentType {
    return "image/$fileTypeExtension";
  }
}
