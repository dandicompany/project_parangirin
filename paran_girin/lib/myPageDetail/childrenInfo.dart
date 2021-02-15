import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/layout/base_appbar.dart';
import 'package:paran_girin/models/avatar.dart';
import 'package:paran_girin/my/profile_menu.dart';
import 'package:paran_girin/myPageDetail/childrenInfoLayout.dart';
import 'package:paran_girin/theme/app_theme.dart';


class childrenInfo extends StatefulWidget {
  @override
  _ChildInfoState createState() => _ChildInfoState();
}

class _ChildInfoState extends State<childrenInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding : EdgeInsets.only(bottom: 150),
        child: Container(
          width: double.infinity,
          color: AppTheme.colors.background,
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(0),
            left: ScreenUtil().setWidth(16),
            right: ScreenUtil().setWidth(16),
          ),
          child : Column(
            children: [
              BaseAppBar(title : "자녀관리",),
              SizedBox(height: ScreenUtil().setHeight(30)),
              childrenInfoLayout(
                image: "assets/images/onboard_1.png",
                text: "샐리",
                text2 : "(으)로 접속중",
                press: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => childrenInfo()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}




//
// class BaseAppBar extends StatelessWidget implements PreferredSizeWidget{
//   final String title;
//
//   BaseAppBar({
//     this.title,
//   });
//
//   @override
//   Size get preferredSize => Size.fromHeight(ScreenUtil().setHeight(56));
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       leading: Navigator.of(context).canPop()
//           ? IconButton(
//         icon: Icon(
//           Icons.arrow_back_ios,
//           color: AppTheme.colors.base1,
//         ),
//         onPressed: () {
//           Navigator.of(context).pop();
//         },
//         iconSize: ScreenUtil().radius(20),
//       )
//           : null,
//       backgroundColor: Colors.transparent,
//       elevation: 0.0,
//       title: Text(
//         title,
//         style: TextStyle(
//             color: AppTheme.colors.base1,
//             fontSize: ScreenUtil().setSp(16)
//         ),
//       ),
//     );
//   }
// }
//
//
// class childrenInfo extends StatefulWidget {
//   @override
//   _childrenInfoState createState() => _childrenInfoState();
// }
//
// class _childrenInfoState extends State<childrenInfo> {
//
//   @override
//   Size get preferredSize => Size.fromHeight(ScreenUtil().setHeight(56));
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       leading: Navigator.of(context).canPop()
//           ? IconButton(
//         icon: Icon(
//           Icons.arrow_back_ios,
//           color: AppTheme.colors.base1,
//         ),
//         onPressed: () {
//           Navigator.of(context).pop();
//         },
//         iconSize: ScreenUtil().radius(20),
//       )
//           : null,
//       backgroundColor: Colors.transparent,
//       elevation: 0.0,
//       title: Text(
//         "자녀 관리",
//         style: TextStyle(
//             color: AppTheme.colors.base1,
//             fontSize: ScreenUtil().setSp(16)
//         ),
//       ),
//     );
//   }
//
//
// }
//
