// -------------------------------- Dine In Tables Screen ------------------------------- ///
// ------------------------------------ First Attempt ----------------------------------- ///

// import 'dart:math' as math;

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:soft_sales/constants/my_colour.dart';
// import 'package:soft_sales/utils/sizeConfig.dart';

// class DineInTables extends StatefulWidget {
//   const DineInTables({super.key});

//   @override
//   State<DineInTables> createState() => _DineInTablesState();
// }

// class _DineInTablesState extends State<DineInTables> {
//   final List<String> diningAreasList = ['All', 'Ground Floor', 'Family', 'Garden', 'Roof Top'];
//   int selectedDiningAreasIndex = 0;

//   final List<TableChairStatusModel> tableChairStatusList = [
//     TableChairStatusModel(
//       statusName: 'All',
//       unSelectedStatusColor: const Color(0xFF8A8A8A),
//       unSelectedStatusBackgroundColor: null,
//       selectedStatusColor: MyColors.selectedForegroundColor,
//       selectedStatusBackgroundColor: MyColors.selectedBackgroundColor,
//     ),
//     TableChairStatusModel(
//       statusName: 'Available',
//       unSelectedStatusColor: Color(0XFF28A745),
//       unSelectedStatusBackgroundColor: null,
//       selectedStatusColor: Colors.white,
//       selectedStatusBackgroundColor: Color(0XFF28A745),
//     ),
//     TableChairStatusModel(
//       statusName: 'On Going',
//       unSelectedStatusColor: Color(0XFFFD7E14),
//       unSelectedStatusBackgroundColor: null,
//       selectedStatusColor: Colors.white,
//       selectedStatusBackgroundColor: Color(0XFFFD7E14),
//     ),
//     TableChairStatusModel(
//       statusName: 'Billed',
//       unSelectedStatusColor: Color(0XFF007BFF),
//       unSelectedStatusBackgroundColor: null,
//       selectedStatusColor: Colors.white,
//       selectedStatusBackgroundColor: Color(0XFF007BFF),
//     ),
//     TableChairStatusModel(
//       statusName: 'Reserved',
//       unSelectedStatusColor: Color(0XFFFFC107),
//       unSelectedStatusBackgroundColor: null,
//       selectedStatusColor: Colors.white,
//       selectedStatusBackgroundColor: Color(0XFFFFC107),
//     ),
//   ];

//   int selectedTableChairStatusIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: EdgeInsets.all(getProportionateScreenWidth(4)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               color: Colors.white,
//               child: Column(
//                 children: [
//                   // Titles
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Dining Areas',
//                         style: GoogleFonts.openSans(
//                           fontWeight: FontWeight.w600,
//                           fontSize: getProportionateScreenWidth(4.2),
//                         ),
//                       ),
//                       Text(
//                         'Table & Chair Status',
//                         style: GoogleFonts.openSans(
//                           fontWeight: FontWeight.w600,
//                           fontSize: getProportionateScreenWidth(4.2),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: getProportionateScreenHeight(8)),

//                   // Lists
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Dining Areas
//                       Expanded(
//                         child: SizedBox(
//                           height: getProportionateScreenHeight(50),
//                           child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: diningAreasList.length,
//                             itemBuilder: (context, index) {
//                               bool isSelected = selectedDiningAreasIndex == index;
//                               return GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedDiningAreasIndex = index;
//                                     debugPrint('Dining Area Selected: $index');
//                                   });
//                                 },
//                                 child: Container(
//                                   margin: const EdgeInsets.only(right: 4),
//                                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                                   decoration: BoxDecoration(
//                                     color: isSelected
//                                         ? MyColors.selectedBackgroundColor
//                                         : Colors.transparent,
//                                     borderRadius: BorderRadius.circular(4),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       diningAreasList[index],
//                                       style: GoogleFonts.openSans(
//                                         color: isSelected
//                                             ? MyColors.selectedForegroundColor
//                                             : MyColors.unSelectedForegroundColor,
//                                         fontSize: getProportionateScreenWidth(4),
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),

//                       // Table & Chair Status
//                       Expanded(
//                         child: SizedBox(
//                           height: getProportionateScreenHeight(50),
//                           child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             reverse: true,
//                             itemCount: tableChairStatusList.length,
//                             itemBuilder: (context, index) {
//                               int reverseIndex = tableChairStatusList.length - 1 - index;
//                               bool isSelected = selectedTableChairStatusIndex == reverseIndex;

//                               return GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedTableChairStatusIndex = reverseIndex;
//                                     debugPrint('Status Selected: $reverseIndex');
//                                   });
//                                 },
//                                 child: Container(
//                                   margin: const EdgeInsets.only(right: 4),
//                                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                                   decoration: BoxDecoration(
//                                     color: isSelected
//                                         ? tableChairStatusList[reverseIndex]
//                                               .selectedStatusBackgroundColor
//                                         : tableChairStatusList[reverseIndex]
//                                               .unSelectedStatusBackgroundColor,
//                                     borderRadius: BorderRadius.circular(4),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       tableChairStatusList[reverseIndex].statusName,
//                                       style: GoogleFonts.openSans(
//                                         color: isSelected
//                                             ? tableChairStatusList[reverseIndex].selectedStatusColor
//                                             : tableChairStatusList[reverseIndex]
//                                                   .unSelectedStatusColor,
//                                         fontSize: getProportionateScreenWidth(4),
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             Container(
//               margin: EdgeInsets.symmetric(vertical: 12),
//               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//               color: Color(0XFFF6F6F6),
//               child: Row(
//                 children: [
//                   Text(
//                     'Ground Floor',
//                     style: GoogleFonts.openSans(
//                       fontWeight: FontWeight.w600,
//                       fontSize: getProportionateScreenWidth(4),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             TableSelectionScreen(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TableChairStatusModel {
//   final String statusName;
//   final Color? unSelectedStatusColor;
//   final Color? unSelectedStatusBackgroundColor;
//   final Color? selectedStatusColor;
//   final Color? selectedStatusBackgroundColor;

//   const TableChairStatusModel({
//     required this.statusName,
//     this.unSelectedStatusColor,
//     this.unSelectedStatusBackgroundColor,
//     this.selectedStatusColor,
//     this.selectedStatusBackgroundColor,
//   });
// }

// ////////////////////////////////////////////////////////////////////////////////////

// enum TableShape { rectangle, round }

// class TableModel {
//   final String id;
//   final TableShape shape;
//   final int seats;
//   bool isSelected;

//   TableModel({required this.id, required this.shape, required this.seats, this.isSelected = false});
// }

// class TableSelectionScreen extends StatefulWidget {
//   const TableSelectionScreen({super.key});

//   @override
//   State<TableSelectionScreen> createState() => _TableSelectionScreenState();
// }

// class _TableSelectionScreenState extends State<TableSelectionScreen> {
//   List<TableModel> tables = [
//     TableModel(id: 'T-01', shape: TableShape.rectangle, seats: 6),
//     TableModel(id: 'T-02', shape: TableShape.round, seats: 5),
//     TableModel(id: 'T-03', shape: TableShape.rectangle, seats: 4),
//     TableModel(id: 'T-04', shape: TableShape.round, seats: 6),
//     TableModel(id: 'T-05', shape: TableShape.rectangle, seats: 3),
//     TableModel(id: 'T-06', shape: TableShape.rectangle, seats: 6),
//     TableModel(id: 'T-07', shape: TableShape.round, seats: 5),
//     TableModel(id: 'T-08', shape: TableShape.rectangle, seats: 4),
//     TableModel(id: 'T-09', shape: TableShape.round, seats: 6),
//     TableModel(id: 'T-10', shape: TableShape.rectangle, seats: 3),
//     TableModel(id: 'T-11', shape: TableShape.rectangle, seats: 4),
//     TableModel(id: 'T-12', shape: TableShape.rectangle, seats: 4),
//     TableModel(id: 'T-13', shape: TableShape.rectangle, seats: 4),
//     TableModel(id: 'T-14', shape: TableShape.rectangle, seats: 4),
//     TableModel(id: 'T-15', shape: TableShape.rectangle, seats: 6),
//     TableModel(id: 'T-16', shape: TableShape.round, seats: 5),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         padding: EdgeInsets.only(right: 16), // Added right padding
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             // Calculate how many tables can fit per row based on screen width
//             final tableWidth = 120.0; // Approximate width including spacing
//             final crossAxisCount = math.max(4, (constraints.maxWidth / tableWidth).floor());

//             return GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: crossAxisCount,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 8, // Reduced from 16 to 8 for less vertical space
//                 childAspectRatio: 0.85,
//               ),
//               itemCount: tables.length,
//               itemBuilder: (context, index) {
//                 final table = tables[index];
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       table.isSelected = !table.isSelected;
//                     });
//                   },
//                   child: CustomTableWidget(table: table),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class CustomTableWidget extends StatelessWidget {
//   final TableModel table;

//   const CustomTableWidget({super.key, required this.table});

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return SizedBox(
//           width: constraints.maxWidth,
//           height: constraints.maxHeight,
//           child: Stack(
//             clipBehavior: Clip.none,
//             children: [
//               // Draw table in center
//               Center(
//                 child: Container(
//                   width: table.shape == TableShape.rectangle ? 100 : 85,
//                   height: table.shape == TableShape.rectangle ? 65 : 85,
//                   decoration: BoxDecoration(
//                     color: table.isSelected ? Color(0XFF28A745) : Colors.white,
//                     border: Border.all(color: Color(0XFF28A745), width: 2),
//                     borderRadius: table.shape == TableShape.rectangle
//                         ? BorderRadius.circular(10)
//                         : BorderRadius.circular(42.5),
//                   ),
//                   child: Center(
//                     child: Text(
//                       table.id,
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: table.isSelected ? Colors.white : Colors.black87,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               // Draw chairs
//               ...table.shape == TableShape.rectangle
//                   ? _buildRectangleChairs(constraints)
//                   : _buildRoundChairs(constraints),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   List<Widget> _buildRectangleChairs(BoxConstraints constraints) {
//     List<Widget> chairs = [];
//     final seatsPerSide = (table.seats / 2).ceil();
//     final tableWidth = 100.0;
//     final tableHeight = 65.0;
//     final centerX = constraints.maxWidth / 2;
//     final centerY = constraints.maxHeight / 2;
//     final spacing = tableWidth / (seatsPerSide + 1);

//     // Top chairs
//     for (int i = 0; i < seatsPerSide; i++) {
//       chairs.add(
//         Positioned(
//           left: centerX - tableWidth / 2 + spacing * (i + 1) - 11,
//           top: centerY - tableHeight / 2 - 22,
//           child: Transform.rotate(angle: 0, child: ChairWidget(isSelected: table.isSelected)),
//         ),
//       );
//     }

//     // Bottom chairs
//     final bottomSeats = table.seats - seatsPerSide;
//     final bottomSpacing = tableWidth / (bottomSeats + 1);
//     for (int i = 0; i < bottomSeats; i++) {
//       chairs.add(
//         Positioned(
//           left: centerX - tableWidth / 2 + bottomSpacing * (i + 1) - 11,
//           top: centerY + tableHeight / 2 + 2,
//           child: Transform.rotate(
//             angle: math.pi,
//             child: ChairWidget(isSelected: table.isSelected),
//           ),
//         ),
//       );
//     }

//     return chairs;
//   }

//   List<Widget> _buildRoundChairs(BoxConstraints constraints) {
//     List<Widget> chairs = [];
//     final centerX = constraints.maxWidth / 2;
//     final centerY = constraints.maxHeight / 2;
//     const radius = 52.0;
//     const chairSize = 22.0;

//     for (int i = 0; i < table.seats; i++) {
//       final angle = (2 * math.pi / table.seats) * i - math.pi / 2;
//       final x = centerX + radius * math.cos(angle) - chairSize / 2;
//       final y = centerY + radius * math.sin(angle) - chairSize / 2;

//       chairs.add(
//         Positioned(
//           left: x,
//           top: y,
//           child: Transform.rotate(
//             angle: angle + math.pi / 2,
//             child: ChairWidget(isSelected: table.isSelected),
//           ),
//         ),
//       );
//     }

//     return chairs;
//   }
// }

// class ChairWidget extends StatelessWidget {
//   final bool isSelected;

//   const ChairWidget({super.key, required this.isSelected});

//   @override
//   Widget build(BuildContext context) {
//     return SvgPicture.asset('assets/chair.svg', width: 22, height: 22);
//   }
// }
