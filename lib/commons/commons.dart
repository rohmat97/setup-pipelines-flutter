import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyColors {
  MyColors._();

  static const Color background = Color(0xFFF6F8FB);
  static const Color background1 = Color(0xFFEBEDF0);
  static const Color background2 = Color(0xFFE1E3E6);

  static const Color transparent = Color(0x00FFFFFF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color danger = Color(0xFFFA2340);
  // static const Color semiDanger = Color(0xFFEE4D48);
  static const Color dangerSecondary = Color(0xFFFFDBE0);
  // static const Color buttonPrimary = Color(0xFF1EA6FC);
  static const Color warning = Color(0xFFF0A613);
  static const Color warningSecondary = Color(0xFFFFF3DC);

  static const Color primary = Color(0xFF0071C1);
  static const Color secondary = Color(0xFF1EA6FC);
  static const Color chat = Color(0xFF16B4F3);
  static const Color accent = Color(0xFF9ED3FF);

  static const Color black = Color(0xFF121212);
  static const Color text = Color(0xFF121212);
  static const Color textSecondary = Color(0xFF9D9D9D);
  static const Color textTertiary = Color(0xFF7A7A7A);

  // static const Color buttonOutlinePrimary = Color(0xFF1E9FEB);
  // static const Color label = Color(0xFFDCF2FF);
  // static const Color labelText = buttonPrimary; //Color(0xFF1EA6FC);
  // static const Color labelOrange = Color(0xFFFFF3DC);
  // static const Color labelTextOrange = Color(0xFFF0A613);
  // static const Color labelGreen = Color(0xFFDCFFE1);
  // static const Color labelTextGreen = Color(0xFF15D435);
  // static const Color disabledButton = Color(0xFFDCDEE0);

  // static const Color labelOutline = Color(0xFF73CCFF);
  // static const Color lightBackground = Color(0xFFF7F8FA);
  // static const Color background = Color(0xFFEBEDF0);
  // static const Color shadow = Color(0xFFDCDEE0);
  // static const Color black = Color(0xFF121212);
  // static const Color secondBlack = Color(0xFF9D9D9D);
  // static const Color grey = Color(0xFFC0C5CA);
  // static const Color thirdBlack = Color(0xFF7A7A7A);
  //
  // static const Color bluetoothBlue = Color(0xFF0082FC);
  //
  // static const Color textFieldBorder = Color(0xFFD9D9D9);
  // static const Color textFieldFill = Color(0xFFEFEFEF);
  // static const Color textFieldFillDisabled = Color(0xFFDADADA);
}

// String formatDipesan(DateTime timestamp) {
//   String day = timestamp.day == DateTime.now().day
//       ? 'Hari ini '
//       : timestamp.day == (DateTime.now().day -1)
//       ? 'Kemarin ' : DateFormat('yyyy-MM-dd ').format(timestamp);
//   String time = formatTime(timestamp);
//   return day + time;
// }
//
// String formatDayTime(DateTime timestamp) {
//   String day = timestamp.day.toString().padLeft(2, '0') + '-' + timestamp.month.toString().padLeft(2, '0');
//   String time = formatTime(timestamp);
//   return day + ' ' + time;
// }
//
Future navigateToPage(context, Widget goto) async {
  return await Navigator.push(context,
      // MaterialPageRoute(builder: (context) => (goto))
    CupertinoPageRoute(builder: (context) => goto)
      // PageRouteBuilder(
      //   pageBuilder: (c, a1, a2) => goto,
      //   transitionsBuilder: (c, anim, a2, child) {
      //     const begin = Offset(1.0, 0);
      //     const end = Offset.zero;
      //     const curve = Curves.ease;
      //
      //     var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      //
      //     return SlideTransition(
      //       position: anim.drive(tween),
      //       child: child,
      //     );
      //   },
      //   transitionDuration: const Duration(milliseconds: 5000),
      // ),
  );
}
//
// Widget endToEndPair(Widget left, Widget right) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       left, right
//     ],
//   );
// }
//
// Widget menuItem(BuildContext context, String title, String? subTitle, Widget icon, void Function() onTap) {
//   return AvicennaContainer(
//     margin: const EdgeInsets.only(top: 12),
//     onTap: onTap,
//     padding: const EdgeInsets.only(top: 18, bottom: 18, left: 24, right: 24),
//     boxShadow: AvicennaProps.boxShadowSoft,
//     child: SizedBox(
//       width: MediaQuery.of(context).size.width,
//       child: Row(
//         children: [
//           // SizedBox(
//           //   width: 24,
//           //   child: icon,
//           // ),
//           icon,
//           const SizedBox(width: 24),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//                 if (subTitle != null) ...[
//                   const SizedBox(height: 4),
//                   Text(subTitle, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AvicennaColors.thirdBlack))
//                 ]
//               ],
//             )
//           )
//         ],
//       )
//     ),
//   );
// }
//
// void showInSnackBar(BuildContext context, String value) {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
// }
//
// void showLoadingNotDismissible(BuildContext context) {
//   showAvicennaDialog(
//     context: context,
//     child: const AvicennaLoadingDialog(),
//     barrierDismissible: false,
//   );
// }
//
// // Future<dynamic> showLoadingNotDismissibleAwait(BuildContext context, AsyncCallback function) async {
// //   showAvicennaDialog(
// //     context: context,
// //     child: const AvicennaLoadingDialog(),
// //     barrierDismissible: false,
// //   );
// //   await function;
// //   Navigator.pop(context);
// // }
//
// Future<String?> showImagePickerDialog(BuildContext context) async {
//   var imageSource =  await showAvicennaDialogAsync(
//     context: context,
//     child: AvicennaDialog(
//       title: 'Ambil Gambar',
//       info: 'Ambil gambar dari kamera atau galeri',
//       content: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             MenuBubble(
//               icon: const FaIcon(
//                 FontAwesomeIcons.camera,
//                 color: AvicennaColors.buttonPrimary
//               ), title: 'Kamera',
//               onTap: () => Navigator.pop(context, ImageSource.camera),
//             ),
//             MenuBubble(
//               icon: const FaIcon(
//                 FontAwesomeIcons.solidImages,
//                 color: AvicennaColors.buttonPrimary
//               ), title: 'Galeri',
//               onTap: () => Navigator.pop(context, ImageSource.gallery),
//             ),
//           ],
//         )
//       ),
//     )
//   );
//
//   final picker = ImagePicker();
//   final pickedFile = await picker.pickImage(
//       source: imageSource,
//       imageQuality: 25,
//       maxHeight: 2000,
//       maxWidth: 2000
//   );
//   if (pickedFile != null ) {
//     final cropper = ImageCropper();
//     File? croppedFile = await cropper.cropImage(
//         compressQuality: 50,
//         maxHeight: 1000,
//         maxWidth: 1000,
//         sourcePath: pickedFile.path,
//         aspectRatioPresets: [CropAspectRatioPreset.square],
//         androidUiSettings: const AndroidUiSettings(
//             toolbarTitle: 'Edit Gambar',
//             statusBarColor: AvicennaColors.secondBlack,
//             toolbarColor: Colors.white,
//             backgroundColor: Colors.white,
//             toolbarWidgetColor: Colors.black,
//             activeControlsWidgetColor: Colors.blue,
//             initAspectRatio: CropAspectRatioPreset.ratio4x3,
//             dimmedLayerColor: Color(0x44000000),
//             lockAspectRatio: false),
//         iosUiSettings: const IOSUiSettings(
//           title: 'Edit Gambar',
//         )
//     );
//
//     if (croppedFile != null) {
//       showLoadingNotDismissible(context);
//       var result = await BaseService().uploadImage(croppedFile.path);
//       Navigator.pop(context);
//
//       try {
//         await File(pickedFile.path).delete();
//         log('images deleted');
//       } catch (e) {
//         log(e.toString());
//       }
//
//       return result;
//     }
//   } else {
//     log('No Image selected');
//   }
//   return null;
// }
//
// void showImageViewer(BuildContext context, String url) {
//   showAvicennaDialog(
//     context: context,
//     child: AlertDialog(
//       insetPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
//       content: ClipRRect(
//         borderRadius: BorderRadius.circular(4),
//         child: InteractiveViewer(
//           child: CachedNetworkImage(
//             imageUrl: url,
//             fit: BoxFit.cover,
//             // placeholder: (context, url) => const CircularProgressIndicator(),
//             errorWidget: (context, url, error) => const Icon(Icons.error),
//           )
//         ),
//       ),
//       contentPadding: const EdgeInsets.all(12),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       buttonPadding: const EdgeInsets.all(0),
//     )
//   );
// }

String moneyFormat(double intPrice) {
  var price = intPrice.toStringAsFixed(0);
  if (price.length > 2) {
    var value = price;
    value = value.replaceAll(RegExp(r'\D'), ',');
    value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.');
    return value;
  } else {
    return price;
  }
}

void showAvicennaDialog({
  required BuildContext context,
  bool barrierDismissible = true,
  Color barrierColor = Colors.black12,
  String barrierLabel = 'Dismiss',
  bool useSafeArea = true,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  required Widget child,
  Duration transitionDuration = const Duration(milliseconds: 300),
  Duration reverseTransitionDuration = const Duration(milliseconds: 200),
  FutureOr<void> Function()? whenComplete,
}) {
  showModal(
    context: context,
    configuration: FadeScaleTransitionConfiguration(
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      transitionDuration: transitionDuration,
      reverseTransitionDuration: reverseTransitionDuration
    ),
    builder: (context) {
      return barrierDismissible ? child : WillPopScope(
        onWillPop: () async => false,
        child: child
      );
    }
  ).whenComplete(whenComplete ?? (){});
}

