import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../theme/app_colors.dart';





import 'login_icons.dart';
class LoginServicesIcons extends StatelessWidget {
  final void onTapFaccebook;
  final void onTapGoogle;
  const LoginServicesIcons(
      {Key? key, required this.onTapFaccebook, required this.onTapGoogle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.only(/*right: screeanwidth * 0.04*/),
            child: LoginIcons.socialButtonCircle(
                AppColors.facebookColor, FontAwesomeIcons.facebookF,
                iconColor: Colors.white, onTap: () {}),
          ),
          Container(
            margin: EdgeInsets.only(/*right: screeanwidth * 0.04*/),
            child: LoginIcons.socialButtonCircle(
                AppColors.googleColor, FontAwesomeIcons.googlePlusG,
                iconColor: Colors.white, onTap: () {}),
          ),
        ],
      ),
    );
  }
}