// import 'package:Pam_App/utils/libraries/app_libraries.dart';
//
// class CommonCard extends StatelessWidget {
//   final Function() onPressed;
//   final double height;
//   final String? imgUrl;
//   final String? errorImage;
//   final String? id;
//   final String? title;
//   final String? des;
//   final List? anchor;
//   final String? segments;
//   final String? publisher;
//   final String? guests;
//   final String? source;
//   final String? channelName;
//   final String? channelLogo;
//   final String? programType;
//   final String? date;
//   final String? time;
//
//   const CommonCard({
//     Key? key,
//     required this.onPressed,
//     required this.height,
//     this.imgUrl,
//     this.errorImage,
//     this.id,
//     this.title,
//     this.des,
//     this.anchor,
//     this.segments,
//     this.publisher,
//     this.guests,
//     this.source,
//     this.channelName,
//     this.channelLogo,
//     this.programType,
//     this.date,
//     this.time,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         height: Get.height / 2.9,
//         width: Get.width,
//         decoration: BoxDecoration(
//           color: AppColors.alertCardColor,
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         child: Column(
//           children: [
//             SizedBox(
//               height: Get.height / 5.9,
//               width: Get.width,
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(0),
//                 ),
//                 child: CachedNetworkImage(
//                   imageUrl: imgUrl!,
//                   placeholder: (c, e) => Lottie.asset(
//                       AppAssets.imagePlaceHolder,
//                       fit: BoxFit.scaleDown),
//                   errorWidget: (c, e, r) => Container(
//                     width: 130,
//                     height: MediaQuery.of(context).size.height,
//                     color: Colors.white,
//                     // child: Image.network("$channelLogo", fit: BoxFit.contain).marginOnly(left: 5.0, right: 5.0),
//                   ),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: SizedBox(
//                 width: Get.width,
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       //width: Get.width / 1.35,  //This width is for when we enable sharing icons.
//                       width: Get.width /
//                           1.2, //-----------This width is for when we did not need icons----
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: source == "Video"
//                                       ? AppColors.alertVideoContainer
//                                       : AppColors.selectedBottomColor24A4),
//                             ),
//                             height: 15,
//                             width: 40,
//                             child: Center(
//                               child: Text(
//                                 "$source",
//                                 style: source == "Video"
//                                     ? CommonTextStyle.font8weight500FD8894
//                                     : CommonTextStyle.font8weight500242A,
//                               ),
//                             ),
//                           ),
//                           Text(
//                             title!,
//                             style: CommonTextStyle.font11weight500White,
//                           ).marginOnly(top: 5, bottom: 3),
//                           Text(
//                             des!,
//                             style: CommonTextStyle.font10weight400White70,
//                           ),
//                           Row(
//                             children: [
//                               const Icon(
//                                 Icons.access_time,
//                                 size: 8,
//                                 color: Colors.white,
//                               ).marginOnly(bottom: 2),
//                               Text(
//                                 "$date ",
//                                 style: CommonTextStyle.font9weight400White,
//                               ),
//                               Image.asset(AppAssets.dot),
//                               Text(" $time ",
//                                   style: CommonTextStyle.font9weight400White),
//                             ],
//                           ).marginSymmetric(vertical: 7)
//                         ],
//                       ).marginOnly(left: 8, top: 8),
//                     ),
//                     // Expanded(
//                     //   child: Container(
//                     //     child: Column(
//                     //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //       children: [
//                     //         SizedBox(
//                     //           height: 12,
//                     //           width: 14,
//                     //           child: Image.asset(
//                     //             AppAssets.twitter,
//                     //             fit: BoxFit.fill,
//                     //           ),
//                     //         ),
//                     //         SizedBox(
//                     //           height: 12,
//                     //           width: 14,
//                     //           child: Image.asset(
//                     //             AppAssets.whatsapp,
//                     //             fit: BoxFit.fill,
//                     //           ),
//                     //         ),
//                     //         SizedBox(
//                     //           height: 12,
//                     //           width: 14,
//                     //           child: Image.asset(
//                     //             AppAssets.facebook,
//                     //             fit: BoxFit.fill,
//                     //           ),
//                     //         ),
//                     //         SizedBox(
//                     //           height: 12,
//                     //           width: 14,
//                     //           child: Image.asset(
//                     //             AppAssets.youtube,
//                     //             fit: BoxFit.fill,
//                     //           ),
//                     //         ),
//                     //         SizedBox(
//                     //           height: 15,
//                     //           width: 16,
//                     //           child: Image.asset(
//                     //             AppAssets.share,
//                     //             fit: BoxFit.fill,
//                     //           ),
//                     //         ),
//                     //       ],
//                     //     ).marginOnly(top: 24, bottom: 8),
//                     //   ),
//                     // )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
