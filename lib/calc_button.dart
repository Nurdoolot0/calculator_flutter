import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class CalcButton extends StatelessWidget {
  final String text;
  final bool isActionColor;
  final int flex;
  final Color? color;
  final Function()? onTap;
  const CalcButton({super.key, required this.text, this.isActionColor = false, this.flex = 1, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
      
        onTap: onTap,
        child: Expanded(
          flex: flex,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: color ?? (isActionColor? AppColors.orange : AppColors.black)
            ),
            height: 87,
            child: Center(
                child: Text(
                    text,
                    style: TextStyle(fontSize: 21, color: Colors.white))),
        
          ),
        ),
      ),
    );
  }
}
