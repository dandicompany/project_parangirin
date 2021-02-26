import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/theme/app_theme.dart';

import 'Calender.dart';
import 'galleryVideos.dart';

class GalleryPage extends StatelessWidget implements PreferredSizeWidget{

  @override
  Size get preferredSize => Size.fromHeight(ScreenUtil().setHeight(46.34));


  @override
  Widget build(BuildContext context) {
    return Container(
        height: 46.34,
        width: double.infinity,
        child : MaterialApp(
          debugShowCheckedModeBanner:false,
          home : DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar : AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  bottom: TabBar(
                    tabs: [
                      Text("CALENDAR",
                        style:
                        TextStyle(
                          fontSize: ScreenUtil().setSp(14),color: AppTheme.colors.base1,
                        ),textAlign: TextAlign.center,
                      ),
                      Text("VIDEOS", style: TextStyle(fontSize: ScreenUtil().setSp(14),color: AppTheme.colors.base1,),textAlign: TextAlign.center)
                    ],
                  )
              ),
              body: TabBarView(
                children: <Widget>[Calender(), galleryVideo()],
              ),
            ),
          ),
        )
    );
  }

}
