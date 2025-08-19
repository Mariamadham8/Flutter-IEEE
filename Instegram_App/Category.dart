import 'package:flutter/material.dart';

class catgoryinfo extends StatelessWidget {
   catgoryinfo({super.key,required this.img,required this.category});
  final List<String> img;
  final String category;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$category",style: TextStyle(color: Colors.white),),
        SizedBox(width: 2,),
         Row(
           children: [
             Transform.rotate(angle:-10,child:  Icon(Icons.link),),
             Text("https://jednvender.com",style: TextStyle(fontWeight: FontWeight.bold),),
           ],
         ),
        SizedBox(width: 9,),
        //image widget
        Row(
          children: [
            SizedBox(
              height: 40,
              width:(img.length *27.0)+10,
              child: Stack(
                children: [
                  for(int i=0;i<img.length;i++)
                    Positioned(
                      left: i*22.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 20,
                        child: CircleAvatar(
                          radius: 19,
                          backgroundImage: NetworkImage(img[i]),
                        ),
                      ),
                    )
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "Followed by vot1223 , a_gff, frnaml and others",
                style: TextStyle(fontWeight: FontWeight.bold),
                softWrap: true,
                overflow: TextOverflow.visible,
                maxLines: 3,
              ),
            ),
          ],
        ),



      ],
    );
  }
}
