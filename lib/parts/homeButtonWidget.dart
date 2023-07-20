import 'package:flutter/material.dart';

class HomeButtonWidget extends StatelessWidget {
  const HomeButtonWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)
  => const SizedBox(
        child: Center(
          child: Text('button'),
        )
    );
}