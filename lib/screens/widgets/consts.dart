import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

String apiLinkConstant = 'https://the-todo-list.onrender.com/api';

String currentUserID = '', token = '', jwtSecret = 'todolist-project', newUsername = '', newEmail = '', newPassword = '', newProfilePic = '', currentListingID = '', profileUpdateError = '';

var listingWithDiscount = [], listingForRent = [], listingForSale = [];

const kWhiteColor = Colors.white;

const kBlackColor = Colors.black;

const kThemeBlueColor = Color(0XFF07396A);

const kDarkTextColor = Color(0XFF191D2E);

const kSilverTextColor = Color(0XFF97A2B6);

const kLightTitleColor = Color(0XFF697489);

const kDarkTitleColor = Color(0XFF3A4355);

const kRedColor = Color(0XFF9E2121);

const kContinueWithGoogleButton = Color(0XFF9E2121);

const kBackgroundColor = Color(0XFFE3E6EF);

const kHomePageTitle = TextStyle(fontSize: 30, color: kThemeBlueColor, fontWeight: FontWeight.w500);

const kRegularText = TextStyle(
  fontWeight: FontWeight.normal,
  fontSize: 15,
);

const kRegularRedText = TextStyle(
  fontWeight: FontWeight.normal,
  color: kContinueWithGoogleButton,
  fontSize: 15,
);

const kRegularBoldText = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 15,
);

const kRegularSemiBoldText = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 15,
);

const kSize18RegularText = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

const kWhiteBoldRegularText = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: Colors.white
);

const kRedBoldRegularText = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: kRedColor
);

const kGreenBoldRegularText = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: Colors.green
);

const kRegularTextStrike = TextStyle(
  fontWeight: FontWeight.normal,
  decoration: TextDecoration.lineThrough,
  fontSize: 15,
);

const kSideMenuLightTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: kLightTitleColor,
);

const kWhiteText20Size = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: kWhiteColor,
);

const kSideMenuBlueTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: kThemeBlueColor,
);

const kSideMenuBlueSize16Style = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: kThemeBlueColor,
);

const kLightBoldTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
  color: kLightTitleColor,
);

const kWhiteBoldTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
  color: kWhiteColor,
);

const kDarkBoldTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
  color: kDarkTitleColor,
);

const kLightSemiBoldTextStyle = TextStyle(
    color: kLightTitleColor,
    fontSize: 16,
    fontWeight:FontWeight.w500
);

const kListingInputDecorationStyle = TextStyle(
    color: kThemeBlueColor,
    fontSize: 17,
    fontWeight:FontWeight.w500
);

const kSemiBoldSize16Style = TextStyle(
    fontSize: 16,
    fontWeight:FontWeight.w500
);

const kDarkSemiBoldTextStyle = TextStyle(
    color: kDarkTitleColor,
    fontSize: 16,
    fontWeight:FontWeight.w500
);

const kUnderlineDarkSemiBoldTextStyle = TextStyle(
    color: kDarkTitleColor,
    decoration: TextDecoration.underline,
    fontSize: 16,
    fontWeight:FontWeight.w500
);

const kBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);

var kEnabledBorder = const OutlineInputBorder(
  borderSide: BorderSide(color: kLightTitleColor, width: 1.0),
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);

var kFocusedBorder = const OutlineInputBorder(
  borderSide: BorderSide(color: kDarkTitleColor, width: 2.0),
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);

bool automaticLogin = false;

bool isRememberMeDisabled = false;

bool isLoggedIn = false;

class HeroLogo extends StatelessWidget {
  HeroLogo({required this.height,required this.image, required this.tag});

  final double height;
  final String image, tag;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag:tag,
      child: Container(
        height: height,
        child: Image.asset(image),
      ),
    );
  }
}

InputDecoration textInputDecoration(String labelText) {
  return InputDecoration(
    hintStyle: const TextStyle(color: kThemeBlueColor),
    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: kBorder,
    enabledBorder: kEnabledBorder,
    focusedBorder: kFocusedBorder,
    labelText: labelText,
    labelStyle: kListingInputDecorationStyle,
  );
}

InputDecoration passwordInputDecoration(String labelText, bool passwordVisible, void Function() toggle){
  return InputDecoration(
    labelText: labelText,
    labelStyle: kListingInputDecorationStyle,
    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: kBorder,
    enabledBorder: kEnabledBorder,
    focusedBorder: kFocusedBorder,
    suffixIcon: IconButton(
      icon: Icon(
        passwordVisible ? Icons.visibility : Icons.visibility_off,
        color: kDarkTitleColor,
      ),
      onPressed: toggle,
    ),
  );
}

InputDecoration listingInputDecoration(String labelText) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: kListingInputDecorationStyle,
    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    enabledBorder: kEnabledBorder,
    focusedBorder: kFocusedBorder,
  );
}

Future<void> commonAlertBox(BuildContext context, String title, String message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog.adaptive(
        title: Text(title, style: kSideMenuBlueTextStyle),
        content: Text(message, style: kLightSemiBoldTextStyle),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: const Text('OK', style: kLightSemiBoldTextStyle),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}