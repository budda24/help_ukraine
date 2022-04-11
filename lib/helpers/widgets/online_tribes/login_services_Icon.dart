import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pomoc_ukrainie/helpers/theme/ui_helpers.dart';
import '../../theme/app_colors.dart';

import 'login_icons.dart';

class LoginServicesIcons extends StatelessWidget {

  final VoidCallback onTapGoogle;
  const LoginServicesIcons(
      {Key? key,  required this.onTapGoogle,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          verticalSpaceMedium,


          Container(
            margin: const EdgeInsets.only(/*right: screeanwidth * 0.04*/),
            child: LoginIcons.socialButtonCircle(
                AppColors.googleColor, FontAwesomeIcons.googlePlusG,
                iconColor: Colors.white, onTap: onTapGoogle),
          ),

        ],
      ),
    );
  }
}
