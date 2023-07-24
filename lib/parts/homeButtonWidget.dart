import 'package:flutter/material.dart';

class HomeButtonWidget extends StatelessWidget {
  const HomeButtonWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)
  => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: GestureDetector(
          onTap: (){
            print('tap!');
          },
          onHorizontalDragEnd: (details){
            if (details.primaryVelocity! > 5){
              print('swip right!');
              Navigator.of(context).pushNamed('/dobj');
            }else
            if (details.primaryVelocity! < 5){
              print('swip left!');
              Navigator.of(context).pushNamed('/caption');
            }
          },

          onVerticalDragEnd: (details){
            if (details.primaryVelocity! < 5){
              print('swip upper!');
              Navigator.of(context).pushNamed('/setting');
            }else
            if (details.primaryVelocity! > 5){
              print('swip bottom!');
            }

          },
          child: SizedBox(// 下画面全体でジェスチャーを認識

            child: Image.asset('assets/microphone.png')
          ),
        )
    );
}