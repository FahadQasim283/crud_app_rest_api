// import 'package:flutter/material.dart';

// import '../../Utils/Routes/routenames.dart';
// import 'constants.dart';

// class MyCard extends StatelessWidget {
//   final int index;
//   final String title;
//   final String description;
//   final Future deleteById;

//   const MyCard({
//     super.key,
//     required this.index,
//     required this.title,
//     required this.description,
//     required this.deleteById,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         leading: CircleAvatar(
//           child: Text(
//             "${index + 1}",
//           ),
//         ),
//         title: Text(title),
//         subtitle: Text(description),
//         trailing: PopupMenuButton(
//           onSelected: (value) {
//             if (value == 'edit') {
//               Constants.objectIndex = index;
//               Constants.objectId = Constants.items[index]['_id'];
//               Constants.isEdited = true;
//               Constants.mapEdit.addAll({
//                 "title": Constants.items[index]['title'],
//                 "description": Constants.items[index]['description']
//               });

//               Navigator.pushNamed(context, RouteName.addPageRoute);
//             } else if (value == 'delete') {
//               deleteById;
//             }
//           },
//           itemBuilder: (context) {
//             return [
//               const PopupMenuItem(
//                 value: 'edit',
//                 child: Text("Edit"),
//               ),
//               const PopupMenuItem(
//                 value: 'delete',
//                 child: Text("Delete"),
//               ),
//             ];
//           },
//         ),
//       ),
//     );
//   }
// }
