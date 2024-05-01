import 'package:flutter/material.dart';
import 'package:sell_4_u/Features/Home-feature/models/category_model.dart';
import 'package:sell_4_u/core/constant.dart';

import '../../../../../core/responsive_screen.dart';

class AllCategory extends StatelessWidget {
  const AllCategory({super.key, required this.model});

  final CategoryModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: ResponsiveScreen.setColorTheme(
            ColorStyle.gray,
            Colors.black26,
            context,
          ),
          child: CircleAvatar(
            backgroundColor: ResponsiveScreen.setColorTheme(
              Colors.white,
              Colors.black38,
              context,
            ),
            radius: 35,
            backgroundImage: NetworkImage(
              model.image!,
              scale: 1,
            ),
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Text(
          model.categoryName!,
          style: FontStyleThame.textStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
