import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'wedgit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() => _home();
}

class _home extends   State<home> {
  Map info ={} ;
  bool isloading =false;
  Future<void> getinfo(String username) async{
    setState(() {
      isloading=true;
    });
    final url="https://instagram-social-api.p.rapidapi.com/v1/info?username_or_id_or_url=$username";
    final uri=Uri.parse(url);

    final res=await http.get(uri,headers: {
      'x-rapidapi-key': 'e9bfaba6f6msh3ac98cc5b1701f4p1bbbc3jsn61edfebcf16b',
      'x-rapidapi-host': 'instagram-social-api.p.rapidapi.com'
    });
    final json = jsonDecode(res.body) as Map;
    final result = json['data'] as Map;
     setState(() {
        info =result;
        isloading=false;
     });
    if(res.statusCode ==200)
      {
        print(res.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content : Text("Success")));
        NavigateToUserPage(info);
      }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content : Text("wrong")));
    }
  }



  void NavigateToUserPage(Map info){
    final route =MaterialPageRoute(builder: (context) =>user(info:info,) ,);
    Navigator.push(context, route);

  }
  
  TextEditingController controller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Padding(
          padding: const EdgeInsets.symmetric(vertical:  130,horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Center(child: Icon(Ionicons.logo_instagram,color: Colors.pinkAccent,size: 100,),),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerLeft,
                child: CostunText(txt: "Enter Username:",fontsize: 20,col: Colors.white,fintw: FontWeight.bold,maxLine: 2,),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText:"username",
                  border: OutlineInputBorder(borderRadius:BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: (){
                  if(controller.text.isEmpty || controller.text ==""){
                    return;
                  }
                  else{
                    getinfo(controller.text);
                  }
                },
                child:Center(
                    child:isloading? CupertinoActivityIndicator(color: Colors.pinkAccent,): CostunText(txt: "login",col: Colors.black,fintw: FontWeight.bold,)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white)
                ),
              )


            ],
          ),
        )
    );
  }

}