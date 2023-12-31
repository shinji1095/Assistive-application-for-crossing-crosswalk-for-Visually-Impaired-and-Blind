import 'package:flutter/material.dart';

class HomeBoxWidget extends StatelessWidget {
  const HomeBoxWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) =>
      SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset('assets/icon.png', fit: BoxFit.cover,),
          ),
        )

      );
}