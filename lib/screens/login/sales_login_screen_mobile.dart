import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:soft_sales/components/constent_textfield.dart';
import 'package:soft_sales/components/custom_dropdown.dart';
import 'package:soft_sales/constants/my_colour.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class SalesLoginScreenMobile extends StatefulWidget {
  const SalesLoginScreenMobile({super.key});

  @override
  State<SalesLoginScreenMobile> createState() => _LoginScreenMobileState();
}

class _LoginScreenMobileState extends State<SalesLoginScreenMobile> {
  bool isChecked = false;
  bool _obscureText = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  // Standardized sizes for consistency
  static const double _standardFontSize = 14.0;
  static const double _standardIconSize = 20.0;
  // State variable in your widget's State class:
  String selectedBranch = 'Branch'; // Initial placeholder

  List<String> branchItems = ['Branch', 'English', 'Tamil', 'Arabic', 'Hindi'];
  String selectedCompany = 'Adhambakkam';
  List<String> companyItems = ['Adhambakkam', 'Adhambakkam', 'Super Market'];
  // Initial placeholder

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  mediaQuery.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: Stack(
              children: [
                // Logo at top center
                Positioned(
                  top: getProportionateScreenHeight(10),
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/login_images/log.svg",
                      width: getProportionateScreenWidth(80),
                    ),
                  ),
                ),

                // Language dropdown at top right
                Positioned(
                  top: getProportionateScreenHeight(10),
                  right: getProportionateScreenWidth(2),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(16),
                      left: getProportionateScreenWidth(8),
                    ),
                    child: Custom2Dropdown(),
                  ),
                ),

                // Background image
                Positioned(
                  top: getProportionateScreenHeight(70),
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    "assets/login_images/maskgroups.png",
                    height: getProportionateScreenHeight(250),
                    width: getProportionateScreenWidth(600),
                  ),
                ),

                // Main content
                Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(330)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Title section
                          Text(
                            'LOGIN',
                            style: GoogleFonts.openSans(fontSize: 24, fontWeight: FontWeight.bold),
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
                          SizedBox(height: getProportionateScreenHeight(15)),

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

                          SizedBox(height: getProportionateScreenHeight(10)),
                          TextField(
                            cursorColor: const Color(0XFF1E1E1E),
                            controller: usernameController,
                            focusNode: usernameFocusNode,
                            style: GoogleFonts.openSans(fontSize: _standardFontSize),
                            onChanged: (value) {
                              // loginController.formUsernameFilled.value = value.isNotEmpty;
                            },
                            onSubmitted: (String value) {
                              if (mounted) {
                                passwordFocusNode.requestFocus();
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 10, 12, 10),
                                child: SvgPicture.asset(
                                  'assets/login_images/username.svg',
                                  // color:
                                  //     loginController.formUsernameFilled.value
                                  //         ? MyColors.selectedForegroundColor
                                  //         : null,
                                  height: _standardIconSize,
                                  width: _standardIconSize,
                                ),
                              ),
                              hintText: 'Username',
                              hintStyle: GoogleFonts.openSans(fontSize: _standardFontSize),
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
                            style: GoogleFonts.openSans(fontSize: _standardFontSize),
                            onChanged: (value) {
                              //loginController.formPasswordFilled.value = value.isNotEmpty;
                            },
                            onSubmitted: (String? value) {
                              //  loginController.onSubmit(usernameController, passwordController);
                            },
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 10, 12, 10),
                                child: SvgPicture.asset(
                                  'assets/login_images/password.svg',
                                  // color:
                                  //     loginController.formPasswordFilled.value
                                  //         ? MyColors.selectedForegroundColor
                                  //         : null,
                                  height: _standardIconSize,
                                  width: _standardIconSize,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText ? Icons.visibility_off : Icons.visibility,
                                  size: _standardIconSize,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                              hintText: 'Password',
                              hintStyle: GoogleFonts.openSans(fontSize: _standardFontSize),
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
                              Expanded(
                                child: ConstantTextFields(
                                  title: 'Shift (10am - 7pm)',
                                  imagePath: 'assets/login_images/shift.svg',
                                  fontSize: 10,
                                  imageheight: _standardIconSize,
                                  suffixIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 12),
                                ),
                              ),
                              SizedBox(width: getProportionateScreenWidth(1)),
                              Expanded(
                                child: ConstantTextFields(
                                  title: '(${DateFormat('dd/MM/yyyy').format(DateTime.now())})',
                                  imagePath: 'assets/login_images/date.svg',
                                  fontSize: 10,
                                  imageheight: _standardIconSize,
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
                                    text: '21/08/2025',
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
                          SizedBox(height: getProportionateScreenHeight(35)),

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
                                // loginController.onSubmit(usernameController, passwordController);
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

                          SizedBox(height: getProportionateScreenHeight(15)),

                          // Bottom image
                        ],
                      ),
                    ),
                    Image.asset(
                      "assets/login_images/bottom.png",
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
