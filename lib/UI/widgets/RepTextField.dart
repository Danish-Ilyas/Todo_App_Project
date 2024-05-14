import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todotask_hive/UI/utils/strings.dart';

class RepoTextField extends StatelessWidget {
  const RepoTextField({super.key,
    required this.controller,
    this.isForDescription = false,
    required this.onFieldSubmitted,
    required this.onChange});

  final TextEditingController? controller;
  final bool isForDescription;

  final Function(String)? onFieldSubmitted;
  final Function(String)? onChange;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: ListTile(
        title: TextFormField(
          controller: controller,
          maxLines: !isForDescription ? 6 : null,
          cursorHeight: !isForDescription ? 40 : null,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
              counter: Container(),
            hintText: isForDescription ? MyString.addNote : null,
            border: isForDescription ? InputBorder.none : null,
            prefixIcon: isForDescription ? Icon(Icons.bookmark_border,color: Colors.grey,):null,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300,),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
              )
          ),
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChange,
        ),
      ),
    );
  }
}
