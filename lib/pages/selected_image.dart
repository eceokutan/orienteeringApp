// import 'dart:developer';

// import 'package:cvsair/core/functions.dart';
// import 'package:cvsair/core/general_provider.dart';
// import 'package:cvsair/functions_helper.dart';
// import 'package:cvsair/order_app/service/order_provider.dart';
// import 'package:cvsair/widgets/selected_images.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../core/models/file_model.dart';
// import 'async_button.dart';

// class SelectAndUploadImagesDialog extends StatefulWidget {
//   SelectAndUploadImagesDialog(
//       {Key? key, required this.uploadPhotos, this.childPath = ""})
//       : super(key: key);

//   final Future<void> Function(List<dynamic>)? uploadPhotos;
//   String childPath;

//   @override
//   State<SelectAndUploadImagesDialog> createState() =>
//       _SelectAndUploadImagesDialogState();
// }

// class _SelectAndUploadImagesDialogState
//     extends State<SelectAndUploadImagesDialog> {
//   ValueNotifier<List<FileModel>> fileModels =
//       ValueNotifier<List<FileModel>>([]);
//   @override
//   Widget build(BuildContext context) {
//     log(context.widget.runtimeType.toString() + "  build ran");
//     final orderProvider = Provider.of<OrderProvider>(context);
//     return AlertDialog(
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ValueListenableBuilder<List<FileModel>>(
//               valueListenable: fileModels,
//               builder: (context, fileModels, _) {
//                 return SelectedImagesWidget(fileModels: fileModels);
//               }),
//           Row(
//             children: [
//               ElevatedButton(
//                   onPressed: () async {
//                     fileModels.value = await pickImages();
//                   },
//                   child: const Text("Fotoğraf Seç")),
//               const SizedBox(
//                 width: 20,
//               ),
//               AsyncButton(
//                   onPressed: () async {
//                     try {
//                       List<dynamic> urls = await GeneralProvider()
//                           .uploadMultipleFiles(
//                               fileModels: fileModels.value,
//                               childPath: widget.childPath);

//                       await widget.uploadPhotos!(urls);
//                       Navigator.pop(context);
//                     } on Exception catch (e) {
//                       showErrorDialog(context, e);
//                     }
//                   },
//                   title: "Yükle")
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
