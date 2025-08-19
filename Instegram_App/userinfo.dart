
import 'package:flutter/material.dart';
import 'user.dart';

class userinfo extends StatelessWidget {
  const userinfo({super.key,required this.uerImage, required this.FollowersNo});
  final String uerImage;
  final String FollowersNo;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(

                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors:[
                      Colors.pinkAccent,
                      Colors.orange
                    ]

                )

            ),
            child: CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(uerImage),
            ),
          ),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("2",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              Text("Posts"),
            ],
          ),
          SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("$FollowersNo k",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              Text("Followers"),
            ],
          ),
          SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("300",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              Text("Following"),
            ],
          ),

        ],
      );

  }
}

