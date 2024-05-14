import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todotask_hive/UI/utils/colors.dart';
import 'package:todotask_hive/extensions/space_exs.dart';

class CustomDrawer extends StatefulWidget {
   CustomDrawer({super.key});
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  final List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.person_fill,
    CupertinoIcons.settings,
    CupertinoIcons.info_circle_fill,
  ];

  List<String> texts = [
    "Home",
    "Profile",
    "Settings",
    "Details",
  ];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(

      padding: EdgeInsets.symmetric(vertical: 90),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: MyColors.primaryGradientColor,
          begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        )
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            radius: 50,
            backgroundImage: NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
          ),
          8.h,
          Text("SOFIA", style: textTheme.displayMedium,),
          Text("Flutter developer", style: textTheme.displaySmall,),
          Container(
            width: double.infinity,
            height: 300,
            child: ListView.builder(
            itemCount: icons.length,
                itemBuilder: (BuildContext context, int index){
              return InkWell(
                onTap: (){
                  debugPrint('Data');
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: ListTile(
                    leading: Icon(icons[index],color: Colors.white,size: 30,),
                    title: Text(texts[index],style: TextStyle(color: Colors.white),),
                  ),
                ),
              );
                },
            ),
          )
        ],
      ),
    );
  }
}
