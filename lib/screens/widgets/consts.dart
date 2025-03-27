import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

String apiLinkConstant = 'https://the-todo-list.onrender.com/api';

String currentUserID = '', token = '', jwtSecret = 'todolist-project', newUsername = '', newEmail = '', newPassword = '', newProfilePic = '', currentTodoID = '', profileUpdateError = '';

bool automaticLogin = false;

bool isRememberMeDisabled = false;

bool isLoggedIn = false;

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

const kRegularText = TextStyle(
  fontWeight: FontWeight.normal,
  fontSize: 15,
);

const kRegularBoldSize15Text = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 15,
);

const kRegularSemiBoldSize15Text = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 15,
);

const kRegularSize18Text = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

const kRegularSize15TextStrike = TextStyle(
  fontWeight: FontWeight.normal,
  decoration: TextDecoration.lineThrough,
  fontSize: 15,
);

const kSemiBoldSize16Text = TextStyle(
  fontSize: 16,
  fontWeight:FontWeight.w500
);

//coloured text details

const kHomePageTitle = TextStyle(fontSize: 30, color: kThemeBlueColor, fontWeight: FontWeight.w500);

const kWhiteBoldSize15Text = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 15,
  color: Colors.white
);

const kRegularRedSize15Text = TextStyle(
  fontWeight: FontWeight.normal,
  color: kContinueWithGoogleButton,
  fontSize: 15,
);

const kRedBoldSize15Text = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 15,
  color: kRedColor
);

const kSideMenuBlueSize16Text = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: kThemeBlueColor,
);

const kGreenBoldSize16Text = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: Colors.green
);

const kSideMenuWhiteSize16Text = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: kWhiteColor,
);

const kDarkSemiBoldSize16Text = TextStyle(
  color: kDarkTitleColor,
  fontSize: 16,
  fontWeight:FontWeight.w500
);

const kUnderlineDarkSemiBoldSize16Text = TextStyle(
  color: kDarkTitleColor,
  decoration: TextDecoration.underline,
  fontSize: 16,
  fontWeight:FontWeight.w500
);

const kListingInputDecorationSize16Text = TextStyle(
  color: kThemeBlueColor,
  fontSize: 17,
  fontWeight:FontWeight.w500
);

const kLightSize18Text = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 18,
  color: kLightTitleColor,
);

const kBlueSize18Text = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 18,
  color: kThemeBlueColor,
);

const kLightBoldSize18Text = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
  color: kLightTitleColor,
);

const kWhiteBoldSize18Text = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
  color: kWhiteColor,
);

const kDarkBoldSize18Text = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
  color: kDarkTitleColor,
);

const kBlueBoldSize20Text = TextStyle(
  color: kThemeBlueColor,
  fontSize: 20,
  fontWeight:FontWeight.bold
);

const kLightSemiBoldSize20Text = TextStyle(
  color: kLightTitleColor,
  fontSize: 20,
  fontWeight:FontWeight.w500
);

const kBlueSemiBoldSize20Text = TextStyle(
  color: kThemeBlueColor,
  fontSize: 20,
  fontWeight:FontWeight.w500
);

const kRedSemiBoldSize20Text = TextStyle(
  color: kRedColor,
  fontSize: 20,
  fontWeight:FontWeight.w500
);

const kSideMenuLightSize20Text = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: kLightTitleColor,
);

const kWhiteSize20Text = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: kWhiteColor,
);

const kSideMenuWhiteSize20Text = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: kWhiteColor,
);

const kSideMenuBlueSize20Text = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: kThemeBlueColor,
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
    labelStyle: kListingInputDecorationSize16Text,
  );
}

InputDecoration passwordInputDecoration(String labelText, bool passwordVisible, void Function() toggle){
  return InputDecoration(
    labelText: labelText,
    labelStyle: kListingInputDecorationSize16Text,
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
    labelStyle: kListingInputDecorationSize16Text,
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
        title: Text(title, style: kSideMenuBlueSize20Text),
        content: Text(message, style: kLightSemiBoldSize20Text),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: const Text('OK', style: kLightSemiBoldSize20Text),
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