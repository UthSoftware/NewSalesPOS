import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class SalesHeader extends StatelessWidget {
  final String selectedItem;
  final Map<String, String> imageMap;
  final VoidCallback? onMenuPressed;

  const SalesHeader({
    super.key,
    required this.selectedItem,
    required this.imageMap,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width <= 1000;

    final appBarFontSize = isMobile ? 14.0 : 16.0;
    final iconSize = isMobile ? 20.0 : 24.0;

    return Column(
      children: [
        selectedItem != 'Sales'
            ? Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Container(
                    height: isMobile
                        ? getProportionateScreenHeight(50)
                        : getProportionateScreenHeight(50),
                    decoration: BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(5),
                        right: getProportionateScreenWidth(7),
                      ),
                      child: Row(
                        children: [
                          // ✅ Show only on mobile & tablet with tap functionality
                          if (isMobile || isTablet)
                            InkWell(
                              onTap: onMenuPressed,
                              child: Padding(
                                padding: EdgeInsets.only(left: getProportionateScreenWidth(10)),
                                child: SvgPicture.asset(
                                  'assets/sales_images/uthpos.svg',
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),

                          // ✅ Show only on desktop AND when selectedItem is NOT 'Dashboard'
                          if (!isMobile && !isTablet && selectedItem != 'Sales') ...[
                            if (imageMap[selectedItem] != null)
                              SvgPicture.asset(
                                imageMap[selectedItem]!,
                                width: iconSize,
                                height: iconSize,
                                color: const Color(0xff5A5A5A),
                              )
                            else
                              Icon(Icons.circle, color: const Color(0xff5A5A5A), size: iconSize),
                            SizedBox(width: getProportionateScreenWidth(4)),
                            Expanded(
                              child: Text(
                                selectedItem,
                                style: GoogleFonts.openSans(
                                  fontSize: appBarFontSize,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff5A5A5A),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],

                          Spacer(),

                          // User Avatar (always visible)
                          Icon(Icons.person, color: Colors.pink, size: isMobile ? 20 : 24),
                        ],
                      ),
                    ),
                  ),

                  Divider(color: Color(0xff000000).withOpacity(.1)),
                ],
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
