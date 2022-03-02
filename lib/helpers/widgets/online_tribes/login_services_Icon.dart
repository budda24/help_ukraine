import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pomoc_ukrainie/helpers/theme/ui_helpers.dart';
import '../../theme/app_colors.dart';

import 'login_icons.dart';

class LoginServicesIcons extends StatelessWidget {
  final VoidCallback onTapApple;
  final VoidCallback onTapFaccebook;
  final VoidCallback onTapGoogle;
  const LoginServicesIcons(
      {Key? key, required this.onTapFaccebook, required this.onTapGoogle,required this.onTapApple})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          verticalSpaceMedium,
          Container(
            margin: EdgeInsets.only(/*right: screeanwidth * 0.04*/),
            child: LoginIcons.socialButtonCircle(
                AppColors.facebookColor, FontAwesomeIcons.facebookF,
                iconColor: Colors.white, onTap: onTapFaccebook),
          ),
          verticalSpaceMedium,
          Container(
            margin: EdgeInsets.only(/*right: screeanwidth * 0.04*/),
            child: LoginIcons.socialButtonCircle(
                AppColors.googleColor, FontAwesomeIcons.googlePlusG,
                iconColor: Colors.white, onTap: onTapGoogle),
          ),
          verticalSpaceMedium,
          Container(
            margin: EdgeInsets.only(/*right: screeanwidth * 0.04*/),
            child: LoginIcons.socialButtonCircle(
                AppColors.greyColor, FontAwesomeIcons.apple,
                iconColor: Colors.white, onTap: onTapApple),
          ),
        ],
      ),
    );
  }
}
