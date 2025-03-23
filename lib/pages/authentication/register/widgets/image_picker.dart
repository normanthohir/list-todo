// part of '../register_page.dart';

// class _ImagePicker extends StatelessWidget {
//   final Function(ImageSource source) pickImage;

//   const _ImagePicker({super.key, required this.pickImage});

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: 0,
//       right: 0,
//       child: Container(
//         padding: EdgeInsets.all(5),
//         decoration: BoxDecoration(
//           color: Colors.blue,
//           shape: BoxShape.circle,
//         ),
//         child: GestureDetector(
//           onTap: () {
//             showBottomSheet(
//               context: context,
//               builder: (context) {
//                 return Wrap(
//                   children: [
//                     ListTile(
//                       leading: Icon(Icons.camera),
//                       title: Text('Camera'),
//                       onTap: () {
//                         Navigator.pop(context);
//                         pickImage(ImageSource.camera);
//                       },
//                     ),
//                     ListTile(
//                       leading: Icon(Icons.photo),
//                       title: Text('Galery'),
//                       onTap: () {
//                         Navigator.pop(context);
//                         pickImage(ImageSource.gallery);
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//           },
//           child: Icon(
//             Icons.camera_alt,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }
