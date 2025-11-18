import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class TablesSelection extends StatefulWidget {
  const TablesSelection({super.key});

  @override
  State<TablesSelection> createState() => _TablesSelectionState();
}

class _TablesSelectionState extends State<TablesSelection> {
  final List<DiningSection> diningSections = [
    DiningSection(
      sectionName: 'Ground Floor',
      tables: [
        TableModel(id: 'T-01', shape: TableShape.rectangle, seatCount: 4),
        TableModel(id: 'T-02', shape: TableShape.rectangle, seatCount: 4),
        TableModel(id: 'T-03', shape: TableShape.rectangle, seatCount: 4),
        TableModel(id: 'T-04', shape: TableShape.rectangle, seatCount: 4),
        TableModel(id: 'T-05', shape: TableShape.rectangle, seatCount: 4),
        TableModel(id: 'T-06', shape: TableShape.round, seatCount: 6),
        TableModel(id: 'T-07', shape: TableShape.round, seatCount: 6),
        TableModel(id: 'T-08', shape: TableShape.rectangle, seatCount: 6),
        TableModel(id: 'T-10', shape: TableShape.rectangle, seatCount: 4),
        TableModel(id: 'T-11', shape: TableShape.rectangle, seatCount: 4),
        TableModel(id: 'T-12', shape: TableShape.rectangle, seatCount: 4),
        TableModel(id: 'T-13', shape: TableShape.rectangle, seatCount: 4),
        TableModel(id: 'T-14', shape: TableShape.round, seatCount: 4),
      ],
    ),
    DiningSection(
      sectionName: 'First Floor',
      tables: [
        TableModel(id: 'T-01', shape: TableShape.rectangle, seatCount: 4),
        TableModel(id: 'T-02', shape: TableShape.rectangle, seatCount: 4),
        TableModel(id: 'T-03', shape: TableShape.rectangle, seatCount: 4),
        TableModel(id: 'T-04', shape: TableShape.rectangle, seatCount: 4),
        TableModel(id: 'T-05', shape: TableShape.rectangle, seatCount: 4),
        TableModel(id: 'T-06', shape: TableShape.round, seatCount: 6),
        TableModel(id: 'T-07', shape: TableShape.round, seatCount: 6),
      ],
    ),
    DiningSection(
      sectionName: 'Garden',
      tables: [
        TableModel(id: 'T-01', shape: TableShape.rectangle, seatCount: 4),
        TableModel(id: 'T-02', shape: TableShape.rectangle, seatCount: 4),
        TableModel(id: 'T-03', shape: TableShape.rectangle, seatCount: 4),
        TableModel(id: 'T-04', shape: TableShape.rectangle, seatCount: 4),
        TableModel(id: 'T-05', shape: TableShape.rectangle, seatCount: 4),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: diningSections.length,
        itemBuilder: (context, index) {
          return _buildSectionWithTables(
            sectionName: diningSections[index].sectionName,
            tables: diningSections[index].tables,
          );
        },
      ),
    );
  }

  Widget _buildSectionWithTables({required String sectionName, required List<TableModel> tables}) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          color: const Color(0XFFF6F6F6),
          child: Row(
            children: [
              Text(
                sectionName,
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w600,
                  fontSize: getProportionateScreenWidth(4),
                ),
              ),
            ],
          ),
        ),
        TablesGrid(tables: tables),
      ],
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////

enum TableShape { rectangle, round }

class TableModel {
  final String id;
  final TableShape shape;
  final int seatCount;
  bool isSelected;

  TableModel({
    required this.id,
    required this.shape,
    required this.seatCount,
    this.isSelected = false,
  });
}

class DiningSection {
  final String sectionName;
  final List<TableModel> tables;

  DiningSection({required this.sectionName, required this.tables});
}

class TablesGrid extends StatefulWidget {
  final List<TableModel> tables;
  const TablesGrid({super.key, required this.tables});

  @override
  State<TablesGrid> createState() => _TablesGridState();
}

class _TablesGridState extends State<TablesGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tableWidth = 120.0;
          final crossAxisCount = math.max(4, (constraints.maxWidth / tableWidth).floor());

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 15,
              childAspectRatio: 0.85,
            ),
            itemCount: widget.tables.length,
            itemBuilder: (context, index) {
              final table = widget.tables[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    table.isSelected = !table.isSelected;
                  });
                },
                child: TableWithChairs(table: table),
              );
            },
          );
        },
      ),
    );
  }
}

class TableWithChairs extends StatelessWidget {
  final TableModel table;

  const TableWithChairs({super.key, required this.table});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Draw table in center
              Center(
                child: Container(
                  width: table.shape == TableShape.rectangle ? 100 : 85,
                  height: table.shape == TableShape.rectangle ? 65 : 85,
                  decoration: BoxDecoration(
                    color: table.isSelected ? const Color(0XFF00961B) : Colors.white,
                    border: Border.all(color: const Color(0XFF00961B), width: 1),
                    borderRadius: table.shape == TableShape.rectangle
                        ? BorderRadius.circular(10)
                        : BorderRadius.circular(42.5),
                  ),
                  child: Center(
                    child: Text(
                      table.id,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: table.isSelected ? Colors.white : const Color(0XFF5A5A5A),
                      ),
                    ),
                  ),
                ),
              ),
              // Draw chairs around table
              ...table.shape == TableShape.rectangle
                  ? _buildRectangularTableChairs(constraints)
                  : _buildRoundTableChairs(constraints),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildRectangularTableChairs(BoxConstraints constraints) {
    List<Widget> chairs = [];
    final seatsPerSide = (table.seatCount / 2).ceil();
    final tableWidth = 100.0;
    final tableHeight = 65.0;
    final centerX = constraints.maxWidth / 2;
    final centerY = constraints.maxHeight / 2;
    final spacing = tableWidth / (seatsPerSide + 1);

    // Top side chairs
    for (int i = 0; i < seatsPerSide; i++) {
      chairs.add(
        Positioned(
          left: centerX - tableWidth / 2 + spacing * (i + 1) - 11,
          top: centerY - tableHeight / 2 - 22,
          child: Transform.rotate(angle: 0, child: ChairIcon(isSelected: table.isSelected)),
        ),
      );
    }

    // Bottom side chairs
    final bottomSeats = table.seatCount - seatsPerSide;
    final bottomSpacing = tableWidth / (bottomSeats + 1);
    for (int i = 0; i < bottomSeats; i++) {
      chairs.add(
        Positioned(
          left: centerX - tableWidth / 2 + bottomSpacing * (i + 1) - 11,
          top: centerY + tableHeight / 2 + 2,
          child: Transform.rotate(
            angle: math.pi,
            child: ChairIcon(isSelected: table.isSelected),
          ),
        ),
      );
    }
    return chairs;
  }

  List<Widget> _buildRoundTableChairs(BoxConstraints constraints) {
    List<Widget> chairs = [];
    final centerX = constraints.maxWidth / 2;
    final centerY = constraints.maxHeight / 2;
    const radius = 52.0;
    const chairSize = 22.0;

    for (int i = 0; i < table.seatCount; i++) {
      final angle = (2 * math.pi / table.seatCount) * i - math.pi / 2;
      final x = centerX + radius * math.cos(angle) - chairSize / 2;
      final y = centerY + radius * math.sin(angle) - chairSize / 2;

      chairs.add(
        Positioned(
          left: x,
          top: y,
          child: Transform.rotate(
            angle: angle + math.pi / 2,
            child: ChairIcon(isSelected: table.isSelected),
          ),
        ),
      );
    }
    return chairs;
  }
}

class ChairIcon extends StatelessWidget {
  final bool isSelected;

  const ChairIcon({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/chair.svg', width: 22, height: 22);
  }
}
