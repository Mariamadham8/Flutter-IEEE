import 'package:flutter/material.dart';

class CostunText extends StatelessWidget{
  const CostunText({
   super.key,
   required this.txt,
    this.maxLine,
   this.fontsize,
   this.fintw,
   this.col,

  });

  final String txt;
  final  int ?maxLine;
  final double? fontsize;
  final FontWeight? fintw;
  final Color? col;



  @override
  Widget build(BuildContext context) {
     return Text(
         txt,
       maxLines: maxLine,
       style: TextStyle(
         fontWeight:fintw ,
         fontSize: fontsize,
        color:col ,

       ),
     );
  }


}