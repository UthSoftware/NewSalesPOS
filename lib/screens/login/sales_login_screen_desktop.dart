// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:soft_sales/components/constent_textfield.dart';
import 'package:soft_sales/components/custom_dropdown.dart';
import 'package:soft_sales/constants/my_colour.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class SalesLoginScreenDesktop extends StatefulWidget {
  const SalesLoginScreenDesktop({super.key});

  @override
  State<SalesLoginScreenDesktop> createState() => _LoginScreenDesktopState();
}

class _LoginScreenDesktopState extends State<SalesLoginScreenDesktop> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  bool _obscureText = true;
  bool isChecked = false;
  String selectedShift = 'Shift 1 (9am - 7pm)';

  final List<String> shiftList = [
    'Shift 1 (9am - 7pm)',
    'Shift 2 (10am - 6pm)',
    'Shift 3 (8am - 4pm)',
  ];

  // State variable in your widget's State class:
  String selectedBranch = 'Branch'; // Initial placeholder

  List<String> branchItems = ['Branch', 'English', 'Tamil', 'Arabic', 'Hindi'];
  String selectedCompany = 'Adhambakkam';
  List<String> companyItems = ['Adhambakkam', 'Adhambakkam', 'Super Market'];
  // Initial placeholder

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        FocusScope.of(context).requestFocus(usernameFocusNode);
      }
    });
  }

  @override
  void dispose() {
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    SizeConfig().init(context);

    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,

        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side - Image
            if (mediaQuery.width >= 650) ...[
              Expanded(
                flex: mediaQuery.width >= 1000
                    ? 3
                    : mediaQuery.width >= 700
                    ? 2
                    : 3,
                child: Image.asset(
                  "assets/login_images/maskgroup.png",
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ],

            // Right side - Form
            Expanded(
              flex: mediaQuery.width >= 700 ? 2 : 5,
              child: Stack(
                children: [
                  // Corner cloud decoration at TOP RIGHT
                  Positioned(
                    top: 0,
                    right: 0,
                    child: SvgPicture.asset(
                      "assets/login_images/cornercloud.svg",
                      height: mediaQuery.height * .18,
                      width: mediaQuery.width * .15,
                    ),
                  ),

                  // Logo at TOP LEFT
                  Positioned(
                    top: getProportionateScreenHeight(80),
                    left: mediaQuery.width >= 1200
                        ? mediaQuery.width * 0.14
                        : mediaQuery.width >= 900
                        ? getProportionateScreenHeight(100)
                        : getProportionateScreenHeight(40),
                    child: SvgPicture.asset(
                      "assets/login_images/log.svg",
                      height: getProportionateScreenHeight(100),
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Language dropdown at TOP RIGHT
                  Positioned(
                    top: getProportionateScreenHeight(35),
                    right: getProportionateScreenWidth(0),
                    child: Custom3Dropdown(),
                  ),

                  // Main scrollable content - FIXED
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: mediaQuery.height),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(mediaQuery.width >= 1250 ? 6 : 4),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Title section
                            SizedBox(height: getProportionateScreenHeight(150)),

                            Text(
                              'LOGIN',
                              style: GoogleFonts.openSans(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: getProportionateScreenHeight(8)),
                            Text(
                              'Enter your credentials to login',
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0XFF666666),
                              ),
                            ),
                            SizedBox(height: getProportionateScreenHeight(20)),

                            CustomDropdown(
                              selectedValue: selectedCompany,
                              imagePath: "assets/login_images/company.svg",
                              dropdownItems: const [], // you are not using this → pass empty list
                              branchList: companyItems,
                              onSelected: (value) {
                                setState(() {
                                  selectedCompany = value!;
                                });
                              },
                              fontSize: 14,
                              height: 55,
                              width: double.infinity,
                            ),
                            SizedBox(height: getProportionateScreenHeight(8)),

                            CustomDropdown(
                              selectedValue: selectedBranch,
                              imagePath: "assets/login_images/branch.svg",
                              dropdownItems: const [], // you are not using this → pass empty list
                              branchList: branchItems,
                              onSelected: (value) {
                                setState(() {
                                  selectedBranch = value!;
                                });
                              },
                              fontSize: 14,
                              height: 55,
                              width: double.infinity,
                            ),

                            SizedBox(height: getProportionateScreenHeight(8)),

                            // Username field
                            TextField(
                              cursorColor: const Color(0XFF1E1E1E),
                              controller: usernameController,
                              focusNode: usernameFocusNode,
                              onChanged: (value) {
                                // loginController.formUsernameFilled.value = value.isNotEmpty;
                              },
                              onSubmitted: (String value) {
                                // if (mounted) {
                                //   passwordFocusNode.requestFocus();
                                // }
                              },
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 10, 12, 10),
                                  child: SvgPicture.asset(
                                    'assets/login_images/username.svg',
                                    color: MyColors.selectedForegroundColor,

                                    height: getProportionateScreenHeight(24),
                                    width: getProportionateScreenWidth(24),
                                  ),
                                ),
                                hintText: 'Username',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(color: const Color(0XFFDDDDDD), width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(color: const Color(0XFFDDDDDD), width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(color: const Color(0XFFDDDDDD), width: 1),
                                ),
                              ),
                            ),

                            SizedBox(height: getProportionateScreenHeight(10)),

                            // Password field
                            TextField(
                              cursorColor: const Color(0XFF1E1E1E),
                              focusNode: passwordFocusNode,
                              controller: passwordController,
                              obscureText: _obscureText,
                              obscuringCharacter: '*',
                              onChanged: (value) {
                                //loginController.formPasswordFilled.value = value.isNotEmpty;
                              },
                              onSubmitted: (String? value) {
                                // loginController.onSubmit(usernameController, passwordController);
                              },
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 10, 12, 10),
                                  child: SvgPicture.asset(
                                    'assets/login_images/password.svg',
                                    color: MyColors.selectedForegroundColor,
                                    height: getProportionateScreenHeight(24),
                                    width: getProportionateScreenWidth(24),
                                  ),
                                ),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: IconButton(
                                    icon: Icon(
                                      _obscureText ? Icons.visibility_off : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                ),
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(color: const Color(0XFFDDDDDD), width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(color: const Color(0XFFDDDDDD), width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(color: const Color(0XFFDDDDDD), width: 1),
                                ),
                              ),
                            ),

                            SizedBox(height: getProportionateScreenHeight(10)),

                            // Shift and Date row
                            Row(
                              children: [
                                Container(
                                  height: getProportionateScreenHeight(67),
                                  width: getProportionateScreenWidth(70),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF2F2F2),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: PopupMenuButton<String>(
                                    onSelected: (value) {
                                      setState(() {
                                        selectedShift = value;
                                      });
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return shiftList.map((String value) {
                                        return PopupMenuItem<String>(
                                          value: value,
                                          child: Text(value, style: const TextStyle(fontSize: 13)),
                                        );
                                      }).toList();
                                    },
                                    offset: const Offset(0, 46), // show below the field
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.people, color: Colors.red, size: 20),
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: Text(
                                              selectedShift,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: Colors.black54,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: getProportionateScreenWidth(1)),
                                Expanded(
                                  child: ConstantTextFields(
                                    title: '(${DateFormat('dd/MM/yyyy').format(DateTime.now())})',
                                    imagePath: 'assets/login_images/date.svg',
                                    fontSize: 12,
                                    imageheight: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: getProportionateScreenHeight(10)),

                            // Last closing date
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                  text: 'Last closing : ',
                                  style: GoogleFonts.inter(color: Color(0XFF666666), fontSize: 12),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '21/08/2025 ',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        color: MyColors.selectedForegroundColor,
                                      ),
                                    ),

                                    TextSpan(
                                      text: '(3:40 PM)',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        color: MyColors.selectedForegroundColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: getProportionateScreenHeight(40)),

                            // Login button
                            SizedBox(
                              width: double.infinity,
                              height: getProportionateScreenHeight(45),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0XFF9A9A9A),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                onPressed: () {
                                  // loginController.onSubmit(
                                  //   usernameController,
                                  //   passwordController,
                                  // );
                                },
                                child: Text(
                                  'Login',
                                  style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: getProportionateScreenHeight(10)),

                            // Copyright footer
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '2025 Copyright @ Uth software',
                                style: GoogleFonts.openSans(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0XFF666666),
                                ),
                              ),
                            ),

                            SizedBox(height: getProportionateScreenHeight(20)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
