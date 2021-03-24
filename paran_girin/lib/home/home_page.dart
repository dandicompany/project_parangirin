import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:paran_girin/home/home_body.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController();

  Timer _timer;
  var _duration = 5;
  var _isSpeaking = true;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_duration > 0) {
          _duration--;
        } else {
          _timer.cancel();
          _isSpeaking = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeBody(),

      // Lottie & Rive test
      // body: Builder(
      //   builder: (context) {
      //     return Column(
      //       children: <Widget>[
      //         _homeAvatarLottie(context),
      //         _homeAvatarRive(context, _isSpeaking),
      //         RaisedButton(onPressed: () => _startTimer()),
      //         Text('$_duration',),

      //         // _homeAvatarRive(user, speak)
      //       ],
      //     );
      //   },
      // ),
    );
  }
}

// ------------ lottie stack ------------
Widget _homeAvatarLottie(context) {
  return Stack(
    children: <Widget>[
      Container(
          width: double.infinity,
          height: ScreenUtil().setHeight(488),
          child: Lottie.network(
              'https://assets9.lottiefiles.com/packages/lf20_utsfwa3k.json')),
      Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(488),
        child: Lottie.asset('assets/avatars/data.json'),
      ),
      Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(488),
        child: Lottie.asset('assets/avatars/lurking-cat.json'),
      ),
      Container(
          width: double.infinity,
          height: ScreenUtil().setHeight(488),
          child: Lottie.network(
              'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json')),
    ],
  );
}

// ------------ Customized Rive version ------------
// Widget _homeAvatarRive(User user, bool speak){
//   return FlareActor(
//       "assets/avatars/${user.curAvatar.name}.flr",
//       animation: _isSpeaking == true ? 'speak':'idle',
//   );
// }
