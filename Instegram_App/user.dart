import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'home.dart';
import 'wedgit.dart';
import 'userinfo.dart';
import 'Category.dart';
import 'button_Card.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'video.dart';

class user extends StatefulWidget {
  final Map info;
 const user({super.key, required this.info});

  @override
  State<StatefulWidget> createState() => _user();
}

class _user extends   State<user> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List imgs=[
    "https://i.pinimg.com/736x/e3/03/21/e30321c8046ef6ada610af9b65489302.jpg",
    "https://i.pinimg.com/736x/39/58/55/395855ed372441408f4e5048b2cb251b.jpg",
    "https://picsum.photos/200/300",
  ];
  List followers =[];
  List posts =[];
  List reels=[];

  Future<void>getFollower()async{
    String? name;
    name=(widget.info['username']);
    final uri ="https://instagram-social-api.p.rapidapi.com/v1/followers?username_or_id_or_url=$name";
    final url=Uri.parse(uri);
    final res=await http.get(url,headers: {
      'x-rapidapi-key': 'e9bfaba6f6msh3ac98cc5b1701f4p1bbbc3jsn61edfebcf16b',
      'x-rapidapi-host': 'instagram-social-api.p.rapidapi.com'
    });
    print(res.body);
    final json=jsonDecode(res.body) as Map;
    final resutl=json['data']['items']as List;
    setState(() {
      followers =resutl;
    });

  }

  Future<void>getPosts()async{
    String? name;
    name=(widget.info['username']);
    final uri ="https://instagram-social-api.p.rapidapi.com/v1/posts?username_or_id_or_url=$name";
    final url=Uri.parse(uri);
    final res=await http.get(url,headers: {
      'x-rapidapi-key': 'e9bfaba6f6msh3ac98cc5b1701f4p1bbbc3jsn61edfebcf16b',
      'x-rapidapi-host': 'instagram-social-api.p.rapidapi.com'
    });
    print(res.body);
    final json=jsonDecode(res.body) as Map;
    final resutl=json['data']['items']as List;
    setState(() {
      posts =resutl;
    });

  }

  Future<void>getreels()async{
    String? name;
    name=(widget.info['username']);
    final uri ="https://instagram-social-api.p.rapidapi.com/v1/reels?username_or_id_or_url=$name";
    final url=Uri.parse(uri);
    final res=await http.get(url,headers: {
      'x-rapidapi-key': 'e9bfaba6f6msh3ac98cc5b1701f4p1bbbc3jsn61edfebcf16b',
      'x-rapidapi-host': 'instagram-social-api.p.rapidapi.com'
    });
    print(res.body);
    final json=jsonDecode(res.body) as Map;
    final resutl=json['data']['items']as List;
    setState(() {
      reels =resutl;
    });

  }

  void initState(){
    getreels();
    getFollower();
    getPosts();
    _tabController=TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final info = widget.info ?? {};
    final Category=info['category'];
    final name=info['username'];
    final Imag=info['profile_pic_url_hd'];
    return Scaffold(
      appBar: AppBar(
        title:Text("$name"),
        actions: [
          SizedBox(width: 20,),
          Icon(Icons.notifications_none),
          SizedBox(width: 20,),
          Icon(Icons.more_horiz)
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                userinfo(
                    uerImage:Imag,
                  FollowersNo:followers.length.toString(),
                ),
                SizedBox(height: 20,),
                catgoryinfo(
                  category: Category,
                  img:[
                    followers[1]['profile_pic_url_hd']?? "https://picsum.photos/200/300",
                    followers[40]['profile_pic_url_hd']?? "https://picsum.photos/200/300",
                    followers[6]['profile_pic_url_hd']?? "https://picsum.photos/200/300",
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 30,vertical:5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                            children:[
                              Text("Following",style:TextStyle(fontWeight: FontWeight.bold,) ,),
                              Icon(Icons.keyboard_arrow_down_sharp),
                            ]

                        )

                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 38,vertical:7),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                            children:[
                              Text("Message",style:TextStyle(fontWeight: FontWeight.bold,) ,),
                            ]

                        )
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical:3),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                            children:[
                              Icon(Icons.person),
                            ]

                        )
                    ),

                  ],
                ),




              ]



            ),
          ),
           SizedBox(width: 40,),
          TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.white,
             labelPadding: EdgeInsets.all(10),
            indicatorWeight: 1.0,
            indicatorSize:TabBarIndicatorSize.tab,
            dragStartBehavior: DragStartBehavior.down,
            indicator:BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(100)
            ),
            controller:_tabController ,
              tabs: [
              Icon(Icons.grid_on),
              Icon(Icons.video_library_rounded),
              Icon(Icons.person_add_alt),
          ]

          ),
          Expanded(
            child: TabBarView(
                controller:_tabController ,
                children:[
                  //posts
                GridView.builder(
                  gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                      childAspectRatio: 0.9/1.1
                  ),
                  itemCount: posts.length,
                  itemBuilder:(context, index) {
                    final post=posts[index];
                      return Image.network(
                       post['thumbnail_url'],
                      );

                    },),
                 //reels
                GridView.builder(
                    gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        childAspectRatio: 0.9/1.1
                    ),
                    itemCount: reels.length,
                    itemBuilder:(context, index) {
                      final reel =reels[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => VideoScreen(videoUrl: reel['video_url'],),)),
                        child:Image.network(
                          reel['thumbnail_url'],
                        ) ,
                      );


                    },),

                //mentions
                Icon(Icons.add_circle),

            ]),
          ),
        ],
      ),

    );
  }

}