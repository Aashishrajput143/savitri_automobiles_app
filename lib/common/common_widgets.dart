import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:savitri_automobiles_admin/common/no_leading_space.dart';
import 'package:savitri_automobiles_admin/resources/colors.dart';

import '../resources/font.dart';
import '../resources/images.dart';
import '../resources/strings.dart';

Container searchField(
    controller, focusNode, Color color, width, onSubmitted(input),
    {int maxLegth = 30,
    String hint = '',
    bool obscure = false,
    onChange,
    onTap}) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(appColors.colorPrimary2),
          Color(appColors.colorPrimary)
        ], // Define your gradient colors here
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(25),
    ),
    padding: const EdgeInsets.all(1), // Create space for the gradient border
    child: Container(
      width: width,
      decoration: BoxDecoration(
        color: color, // Background color for the inner TextField container
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        maxLength: maxLegth,
        onSubmitted: onSubmitted,
        onChanged: onChange,
        onTap: onTap,
        decoration: InputDecoration(
          prefixIcon: Container(
            padding: const EdgeInsets.all(13),
            child: SvgPicture.asset(
              AppImages.searchIcon,
              height: 14,
              width: 14,
            ),
          ),
          contentPadding: const EdgeInsets.all(15),
          isDense: true,
          hintText: hint,
          hintStyle:
              TextStyle(color: Color(appColors.searchHint), fontSize: 13),
          counterText: "",
          border: InputBorder.none, // Remove the default border
        ),
        maxLines: 1,
        textAlign: TextAlign.start,
        obscureText: obscure,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: appFonts.robotsRegular,
          fontWeight: FontWeight.w300,
        ),
      ),
    ),
  );
}

Widget searchFieldWithoutGradient(
  TextEditingController controller,
  FocusNode focusNode,
  Color color,
  double width,
  void Function(String) onSubmitted, {
  int maxLength = 30,
  String hint = '',
  bool obscure = false,
  void Function()? onTap,
  void Function(String)? onChange,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      bool isHovered = false;

      focusNode.addListener(() {
        setState(() {});
      });

      // Change border color based on hover and focus
      Color borderColor = isHovered || focusNode.hasFocus
          ? Color(appColors.buttonNew)
          : Color(appColors.colorPrimaryNew);

      return MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: borderColor, width: 1.0),
          ),
          padding: const EdgeInsets.all(1.0),
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextField(
              controller: controller,
              onTap: onTap,
              focusNode: focusNode,
              maxLength: maxLength,
              onSubmitted: onSubmitted,
              onChanged: onChange,
              inputFormatters: [NoLeadingSpaceFormatter()],
              decoration: InputDecoration(
                prefixIcon: Container(
                  padding: const EdgeInsets.all(13),
                  child: SvgPicture.asset(
                    AppImages.searchIcon,
                    height: 14,
                    width: 14,
                    color: Color(appColors.colorPrimaryNew),
                  ),
                ),
                contentPadding: const EdgeInsets.all(10),
                isDense: true,
                hintText: hint,
                hintStyle: TextStyle(
                  color: Color(appColors.searchHint),
                  fontSize: 13,
                ),
                counterText: "",
                border: InputBorder.none,
              ),
              maxLines: 1,
              textAlign: TextAlign.start,
              obscureText: obscure,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: appFonts.robotsRegular,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget gradientDivider({double height = 2.0}) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(appColors.colorPrimaryNew), // Starting color of the gradient
          Color(appColors.searchHint), // Ending color of the gradient
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
  );
}

Widget emailField(
  TextEditingController controller,
  FocusNode focusNode,
  Color color,
  double width,
  double height, {
  FormFieldValidator<String>? validator,
  int maxLegth = 30,
  String hint = '',
  bool enabled = true,
  bool obscure = false,
  TextInputType keyboardType = TextInputType.text,
  void Function(String)? onChange,
  List<TextInputFormatter>? inputFormatters,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      bool isHovered = false;

      focusNode.addListener(() {
        setState(() {});
      });

      Color borderColor = isHovered || focusNode.hasFocus
          ? Color(appColors.buttonNew)
          : Color(appColors.colorPrimaryNew);

      double animatedWidth = focusNode.hasFocus ? width * 1.05 : width;
      double animatedHeight = focusNode.hasFocus ? height * 1.1 : height;

      return MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: animatedWidth,
          height: animatedHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor, width: 1.0),
          ),
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              enabled: enabled,
              maxLength: maxLegth,
              validator: validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: onChange,
              inputFormatters: inputFormatters,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                contentPadding: Platform.isIOS
                    ? const EdgeInsets.symmetric(vertical: 10, horizontal: 15)
                    : const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                errorStyle: TextStyle(
                  color: Colors.red[400],
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  height: 0,
                ),
                isDense: true,
                hintText: hint,
                hintStyle: TextStyle(
                  color: Color(appColors.searchHint),
                  fontSize: 16,
                ),
                counterText: "",
                border: InputBorder.none,
              ),
              maxLines: 1,
              textAlign: TextAlign.start,
              obscureText: obscure,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: appFonts.robotsRegular,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget emailFieldForAboutMe(
  TextEditingController controller,
  FocusNode focusNode,
  Color color,
  double width,
  double height, {
  FormFieldValidator<String>? validator,
  int maxLegth = 30,
  String hint = '',
  bool enabled = true,
  bool obscure = false,
  TextInputType keyboardType = TextInputType.text,
  void Function(String)? onChange,
  List<TextInputFormatter>? inputFormatters,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      bool isHovered = false;

      focusNode.addListener(() {
        setState(() {});
      });

      Color borderColor = isHovered || focusNode.hasFocus
          ? Color(appColors.buttonNew)
          : Color(appColors.colorPrimaryNew);

      double animatedWidth = focusNode.hasFocus ? width * 1.05 : width;
      double animatedHeight = focusNode.hasFocus ? height * 1.1 : height;

      return MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: animatedWidth,
          height: animatedHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor, width: 1.0),
          ),
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              enabled: enabled,
              maxLength: maxLegth,
              validator: validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: onChange,
              inputFormatters: inputFormatters,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                contentPadding: Platform.isIOS
                    ? const EdgeInsets.symmetric(vertical: 10, horizontal: 15)
                    : const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                errorStyle: TextStyle(
                  color: Colors.red[400],
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  height: 0,
                ),
                isDense: true,
                hintText: hint,
                hintStyle: TextStyle(
                  color: Color(appColors.searchHint),
                  fontSize: 16,
                ),
                counterText: "",
                border: InputBorder.none,
              ),
              maxLines: 10,
              textAlign: TextAlign.start,
              obscureText: obscure,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: appFonts.robotsRegular,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget emailFieldCheck(
  TextEditingController controller,
  FocusNode focusNode,
  Color color,
  double width,
  double height, {
  FormFieldValidator<String>? validator,
  int maxLength = 320,
  String hint = '',
  bool enabled = true,
  bool obscure = false,
  TextInputType keyboardType = TextInputType.text,
  void Function(String)? onChange,
}) {
  // Variable to hold the error message
  String? errorMessage;

  return StatefulBuilder(
    builder: (context, setState) {
      bool isHovered = false;

      focusNode.addListener(() {
        setState(() {});
      });

      // Perform validation and get the error message
      if (validator != null) {
        errorMessage = validator(controller.text);
      }

      Color borderColor = errorMessage != null
          ? Colors.red // Change border color to red when there's an error
          : (isHovered || focusNode.hasFocus)
              ? Color(appColors.buttonNew)
              : Color(appColors.colorPrimaryNew);

      return MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: Container(
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: borderColor,
                width: 1.0), // Border color based on error state
          ),
          padding: const EdgeInsets.all(1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  enabled: enabled,
                  maxLength: maxLength,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: onChange,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    contentPadding: Platform.isIOS
                        ? const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 15)
                        : const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 15),
                    isDense: true,
                    hintText: hint,
                    counterText: "",
                    border: InputBorder.none, // No border here
                    hintStyle: TextStyle(
                      color: Color(appColors.searchHint),
                      fontSize: 16,
                    ),
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  obscureText: obscure,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: appFonts.robotsRegular,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              // Display the error message directly below the TextFormField
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(
                      top:
                          4.0), // Space between the text field and error message
                  child: Text(
                    errorMessage ?? "",
                    style: TextStyle(
                      color: Colors.red[400],
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}

Widget passwordField(
  TextEditingController controller,
  FocusNode focusNode,
  Color color,
  double width,
  double height,
  VoidCallback onTap,
  void Function(String) onSubmitted, {
  int maxLegth = 320,
  String hint = '',
  bool obscure = false,
  void Function(String)? onChange,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      bool isHovered = false;

      focusNode.addListener(() {
        setState(() {});
      });

      Color borderColor = isHovered || focusNode.hasFocus
          ? Color(appColors.buttonNew)
          : Color(appColors.colorPrimaryNew);

      double animatedWidth = focusNode.hasFocus ? width * 1.05 : width;
      double animatedHeight = focusNode.hasFocus ? height * 1.1 : height;

      return MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: animatedWidth,
          height: animatedHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor, width: 1.0),
          ),
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              maxLength: maxLegth,
              onSubmitted: onSubmitted,
              onChanged: onChange,
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: onTap,
                    child: Icon(
                      obscure
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      size: 24,
                      color: Colors.grey,
                    ),
                  ),
                ),
                contentPadding: Platform.isIOS
                    ? const EdgeInsets.symmetric(vertical: 10, horizontal: 15)
                    : const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                isDense: true,
                hintText: hint,
                hintStyle: TextStyle(
                  color: Color(appColors.searchHint),
                  fontSize: 16,
                ),
                counterText: "",
                border: InputBorder.none,
              ),
              maxLines: 1,
              textAlign: TextAlign.start,
              obscureText: obscure,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: appFonts.robotsRegular,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget otpField(
  TextEditingController controller,
  FocusNode focusNode,
  Color color,
  double width,
  double height,
  void Function(String) onSubmitted, {
  int maxLegth = 320,
  String hint = '',
  bool enabled = true,
  bool obscure = false,
  TextInputType keyboardType = TextInputType.number,
  void Function(String)? onChange,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      bool isHovered = false;
      focusNode.addListener(() {
        setState(() {});
      });
      Color borderColor = isHovered || focusNode.hasFocus
          ? Color(appColors.buttonNew)
          : Color(appColors.colorPrimaryNew);
      double animatedWidth = focusNode.hasFocus ? width * 1.05 : width;
      double animatedHeight = focusNode.hasFocus ? height * 1 : height;
      return MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: animatedWidth,
          height: animatedHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor, width: 1.0),
          ),
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              enabled: enabled,
              maxLength: 4,
              onSubmitted: onSubmitted,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Only digits allowed
                LengthLimitingTextInputFormatter(4), // Limit input to 4 digits
              ],
              onChanged: onChange,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                contentPadding: Platform.isIOS
                    ? const EdgeInsets.symmetric(vertical: 13, horizontal: 15)
                    : const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                isDense: true,
                hintText: hint,
                hintStyle: TextStyle(
                  color: Color(appColors.searchHint),
                  fontSize: 16,
                ),
                counterText: "",
                border: InputBorder.none,
              ),
              maxLines: 1,
              textAlign: TextAlign.start,
              obscureText: obscure,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: appFonts.robotsRegular,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      );
    },
  );
}

Container commonContainerOutlined(double width, double height, child, color) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white, // Set a solid background color if needed
      borderRadius: BorderRadius.circular(25), // Circular border
      border: Border.all(
          color: Color(appColors.colorPrimaryNew), width: 1.0), // Black border
    ),
    padding:
        const EdgeInsets.all(0.0), // Padding to set space for the black border
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color, // Inner background color
        borderRadius: BorderRadius.circular(25),
      ),
      child: child,
    ),
  );
}

Container commonButton(double width, double height, child, color) {
  return Container(
    decoration: BoxDecoration(
      // Set a solid background color if needed
      borderRadius: BorderRadius.circular(10), // Circular border
      // Black border
    ),
    padding:
        const EdgeInsets.all(1.0), // Padding to set space for the black border
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Color(appColors.buttonNew), // Inner background color
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: child),
    ),
  );
}

Text titleText(String text,
    {double fontSize = 20.0,
    fontFamily = 'RobotsRegular',
    var color = Colors.black,
    var fontWeight = FontWeight.w600}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: fontSize,
        fontFamily: fontFamily,
        color: color,
        overflow: TextOverflow.ellipsis,
        fontWeight: fontWeight),
  );
}

Text descriptionText(
  String text, {
  double fontSize = 11.0,
  double height = 0,
  fontFamily = 'RobotsRegular',
  var color = Colors.black,
  textAlign = TextAlign.start,
  var fontWeight = FontWeight.bold,
  underLine = false,
}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      height: height,
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight,
      decoration: underLine ? TextDecoration.underline : TextDecoration.none,
    ),
  );
}

Container dropdownButton(
  List<String> items,
  String? selectedValue,
  double width,
  double height,
  Color color,
  void Function(String?) onChanged, {
  String hint = '',
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      border: Border.all(
          color: Color(appColors.colorPrimaryNew), width: 1.0), // Outer border
    ),
    padding: const EdgeInsets.all(1.0),
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
            value: selectedValue,
            isDense: true,
            hint: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                hint,
                style: TextStyle(
                    color: Color(appColors.searchHint),
                    fontSize: 12,
                    fontFamily: appFonts.robotsRegular),
              ),
            ),
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: appFonts.robotsRegular,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            dropdownColor: color,
            icon: const SizedBox.shrink()),
      ),
    ),
  );
}

EdgeInsets edgeInsetsAll({all = 0.0}) {
  return EdgeInsets.all(all.toDouble());
}

Padding paddingOnly({left = 0.0, right = 0.0, bottom = 0.0, top = 0.0}) {
  return Padding(
    padding: EdgeInsets.only(
        left: left.toDouble(),
        right: right.toDouble(),
        bottom: bottom.toDouble(),
        top: top.toDouble()),
  );
}

Padding paddingAll({all = 0.0}) {
  return Padding(padding: EdgeInsets.all(all.toDouble()));
}

EdgeInsets edgeInsetsOnly({left = 0.0, right = 0.0, top = 0.0, bottom = 0.0}) {
  return EdgeInsets.only(
      left: left.toDouble(),
      right: right.toDouble(),
      top: top.toDouble(),
      bottom: bottom.toDouble());
}

Container phoneNumberField(controller, focusNode, w) {
  return Container(
    width: w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      gradient: LinearGradient(
        colors: [
          Color(appColors.colorPrimary),
          Color(appColors.colorPrimary2)
        ], // Replace with your desired gradient colors
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    padding: const EdgeInsets.all(1.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: IntlPhoneField(
        focusNode: focusNode,
        controller: controller,
        decoration: InputDecoration(
          counterText: "",
          hintText: appStrings.hintPhone,
          hintStyle: const TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide.none,
          ),
          alignLabelWithHint: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 5.0,
          ),
        ),
        style: const TextStyle(color: Colors.black),
        dropdownTextStyle: const TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        languageCode: "en",
        onChanged: (phone) {
          //print(phone.completeNumber);
        },
        onCountryChanged: (country) {
          // print('Country changed to: ${country.dialCode}');
        },
      ),
    ),
  );
}

SizedBox phoneNumberFieldWithoutGradient(controller, focusNode, w) {
  return SizedBox(
    width: w,
    child: IntlPhoneField(
      focusNode: focusNode,
      controller: controller,
      decoration: InputDecoration(
        counterText: "",
        // Set label text color to white
        hintText: appStrings.hintPhone,
        hintStyle: TextStyle(
            color: Color(appColors.searchHint)), // Set hint text color to white
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Color(appColors.colorPrimaryNew),
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Color(appColors.colorPrimaryNew),
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 5.0,
        ),
      ),
      style: const TextStyle(color: Colors.black),
      dropdownTextStyle: const TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      dropdownIcon: Icon(
        Icons.arrow_drop_down,
        color: Color(appColors.colorPrimaryNew),
        size: 24,
      ),
      languageCode: "en",
      onChanged: (phone) {
        if (kDebugMode) {
          print(phone.completeNumber);
        }

        if (phone.number.isNotEmpty) {}
      },
      onCountryChanged: (country) {
        if (kDebugMode) {
          print('Country changed to: ${country.dialCode}');
        }
      },
    ),
  );
}
