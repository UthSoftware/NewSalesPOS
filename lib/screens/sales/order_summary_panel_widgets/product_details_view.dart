// Main Product Edit Screen
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class ResponsiveProductEditScreen extends StatefulWidget {
  const ResponsiveProductEditScreen({super.key});

  @override
  State<ResponsiveProductEditScreen> createState() => _ResponsiveProductEditScreenState();
}

class _ResponsiveProductEditScreenState extends State<ResponsiveProductEditScreen> {
  int quantity = 3;
  String? selectedStaff = 'Dhina';
  String? selectedPrinterStation = 'Grill Station';

  // Available note options
  List<String> availableNotes = [
    'Custom note',
    'Make it extra spicy',
    'Less oil',
    'No food color',
    'Deep fry',
    'add more lemon',
    'deep cook',
    'half cook',
    'well done',
    'light on salt',
    'no onion',
    'less spicy',
    'extra gravy',
    'no garlic',
    'no ginger',
    'no chili',
  ];

  // Selected note options
  List<String> selectedOptions = ['Make it extra spicy', 'Less oil', 'Custom note'];

  // Custom note text
  String customNoteText = '';

  // Search controller
  TextEditingController searchController = TextEditingController();
  TextEditingController customNoteController = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Check if mobile (width < 600) or tablet/desktop
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return isMobile ? _buildMobileView() : _buildTabletView();
  }

  // Mobile View - Full Screen
  Widget _buildMobileView() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(color: Color(0xffDC4A58)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
                    ),
                    Text(
                      'Chicken Tandoori (Full)',
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_buildMobileContent()],
              ),
            ),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Tablet/Desktop View - Dialog
  Widget _buildTabletView() {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        width: 520,
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffDC4A58),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Text(
                        'Chicken Tandoori (Full)',
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xffffffff),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close, color: Colors.white, size: 20),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(children: [_buildTabletContent()]),
              ),

              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // Mobile Content Layout
  Widget _buildMobileContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name Field
        Text('Name :'),
        SizedBox(height: 5),
        Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            'Chicken Tandoori (Full)',
            style: GoogleFonts.openSans(fontSize: 15, color: Color(0xff5A5A5A)),
          ),
        ),

        SizedBox(height: 20),
        // Price
        Text('Price :'),
        SizedBox(height: 5),
        Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.centerLeft,
          child: Text('₹ 350', style: GoogleFonts.openSans(fontSize: 13, color: Color(0xff5A5A5A))),
        ),
        SizedBox(height: 10),

        // Quantity
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Quantity :',
              style: GoogleFonts.openSans(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            Spacer(),
            _buildQuantityButton(
              svgAsset: "assets/minus_qty.svg",
              onPressed: () {
                setState(() {
                  if (quantity > 1) quantity--;
                });
              },
            ),
            SizedBox(width: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                quantity.toString().padLeft(2, '0'),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(width: 10),
            _buildQuantityButton(
              svgAsset: "assets/add_qty.svg",
              onPressed: () {
                setState(() {
                  quantity++;
                });
              },
            ),
          ],
        ),
        SizedBox(height: 20),

        // Staff Dropdown
        Text('Staff :'),
        SizedBox(height: 5),
        Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedStaff,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
              style: GoogleFonts.openSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xff000000),
              ),
              items: [
                'Dhina',
                'Staff 2',
                'Staff 3',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (value) {
                setState(() {
                  selectedStaff = value;
                });
              },
            ),
          ),
        ),

        SizedBox(height: 20),
        // Printer Station
        Text('Printer Station :'),
        SizedBox(height: 5),
        Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedPrinterStation,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
              style: GoogleFonts.openSans(fontSize: 14, color: Colors.black87),
              selectedItemBuilder: (BuildContext context) {
                return ['Grill Station', 'Kitchen', 'Bar'].map((String value) {
                  return Row(
                    children: [
                      Icon(Icons.circle, color: Color(0xff008A05), size: 8),
                      SizedBox(width: 8),
                      Text(
                        value,
                        style: GoogleFonts.openSans(
                          color: Color(0xff008A05),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  );
                }).toList();
              },
              items: ['Grill Station', 'Kitchen', 'Bar']
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: GoogleFonts.openSans(fontSize: 14, color: Colors.black87),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedPrinterStation = value;
                });
              },
            ),
          ),
        ),

        SizedBox(height: 20),
        // Note Section
        _buildNoteSection(),

        SizedBox(height: 20),

        // Action Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel', style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
            ),
            SizedBox(width: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffDC4A58),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              child: Text(
                'Save',
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Tablet Content Layout
  Widget _buildTabletContent() {
    return Column(
      children: [
        // Name Field
        _buildRow(
          label: 'Name :',
          child: Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              'Chicken Tandoori (Full)',
              style: GoogleFonts.openSans(fontSize: 15, color: Color(0xff5A5A5A)),
            ),
          ),
        ),
        SizedBox(height: 12),

        // Price and Quantity Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: _buildRow(
                label: 'Price :',
                child: Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '₹ 350',
                    style: GoogleFonts.openSans(fontSize: 13, color: Color(0xff5A5A5A)),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Quantity :',
                    style: GoogleFonts.openSans(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 8),
                  _buildQuantityButton(
                    svgAsset: "assets/minus_qty.svg",
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) quantity--;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      quantity.toString().padLeft(2, '0'),
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                  _buildQuantityButton(
                    svgAsset: "assets/add_qty.svg",
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),

        // Staff Dropdown
        _buildRow(
          label: 'Staff :',
          child: Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedStaff,
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff000000),
                ),
                items: [
                  'Dhina',
                  'Staff 2',
                  'Staff 3',
                ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedStaff = value;
                  });
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 12),

        // Printer Station Dropdown
        _buildRow(
          label: 'Printer Station :',
          child: Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedPrinterStation,
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
                style: GoogleFonts.openSans(fontSize: 14, color: Colors.black87),
                selectedItemBuilder: (BuildContext context) {
                  return ['Grill Station', 'Kitchen', 'Bar'].map((String value) {
                    return Row(
                      children: [
                        Icon(Icons.circle, color: Color(0xff008A05), size: 8),
                        SizedBox(width: 8),
                        Text(
                          value,
                          style: GoogleFonts.openSans(
                            color: Color(0xff008A05),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    );
                  }).toList();
                },
                items: ['Grill Station', 'Kitchen', 'Bar']
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
                          style: GoogleFonts.openSans(fontSize: 14, color: Colors.black87),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPrinterStation = value;
                  });
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 12),

        // Note Section
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              child: Text(
                'Note :',
                style: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(8)),
            Expanded(child: _buildNoteSection()),
          ],
        ),
        SizedBox(height: 20),

        // Action Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel', style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
            ),
            SizedBox(width: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffDC4A58),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              child: Text(
                'Save',
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Note Section (shared by both layouts)
  Widget _buildNoteSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dropdown Button
        GestureDetector(
          onTap: () {
            _showNoteSelectionDialog(context);
          },
          child: Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedOptions.isEmpty
                      ? 'Select options'
                      : '${selectedOptions.length} option${selectedOptions.length > 1 ? 's' : ''} Selected',
                  style: GoogleFonts.openSans(fontSize: 14, color: Colors.black87),
                ),
                Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
              ],
            ),
          ),
        ),
        SizedBox(height: 12),

        // Selected Options Container
        Container(
          height: 125,
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (selectedOptions.isEmpty)
                  Text(
                    'No options selected',
                    style: GoogleFonts.openSans(fontSize: 12, color: Colors.grey.shade600),
                  )
                else
                  Wrap(
                    spacing: 3,
                    runSpacing: 5,
                    children: selectedOptions.map((option) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              option,
                              style: GoogleFonts.openSans(fontSize: 12, color: Colors.black87),
                            ),
                            SizedBox(width: 4),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedOptions.remove(option);
                                  if (option == 'Custom note') {
                                    customNoteText = '';
                                    customNoteController.clear();
                                  }
                                });
                              },
                              child: Icon(Icons.close, size: 13, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                if (selectedOptions.contains('Custom note'))
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      height: 38,
                      child: TextField(
                        controller: customNoteController,
                        onChanged: (value) {
                          setState(() {
                            customNoteText = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter custom note...',
                          hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        ),
                        style: GoogleFonts.openSans(fontSize: 12),
                        maxLines: 1,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Show Note Selection Dialog
  void _showNoteSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            List<String> filteredNotes = availableNotes
                .where((note) => note.toLowerCase().contains(searchQuery.toLowerCase()))
                .toList();

            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Container(
                width: 400,
                constraints: BoxConstraints(maxHeight: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setDialogState(() {
                            searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                          prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Color(0xffDC4A58)),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        ),
                      ),
                    ),
                    Divider(height: 1),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredNotes.length,
                        itemBuilder: (context, index) {
                          final note = filteredNotes[index];
                          final isSelected = selectedOptions.contains(note);

                          return InkWell(
                            onTap: () {
                              setDialogState(() {
                                if (isSelected) {
                                  selectedOptions.remove(note);
                                } else {
                                  selectedOptions.add(note);
                                }
                              });
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: isSelected,
                                    onChanged: (bool? value) {
                                      setDialogState(() {
                                        if (value == true) {
                                          selectedOptions.add(note);
                                        } else {
                                          selectedOptions.remove(note);
                                        }
                                      });
                                      setState(() {});
                                    },
                                    activeColor: Color(0xffDC4A58),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      note,
                                      style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        color: isSelected ? Color(0xffDC4A58) : Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then((_) {
      searchController.clear();
      setState(() {
        searchQuery = '';
      });
    });
  }

  Widget _buildRow({String? label, required Widget child}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label.toString(),
            style: GoogleFonts.openSans(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xff5A5A5A),
            ),
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(8)),
        Expanded(child: child),
      ],
    );
  }

  Widget _buildQuantityButton({
    required String svgAsset, // <-- SVG path
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Center(child: SvgPicture.asset(svgAsset, height: 24, width: 24)),
    );
  }
}
