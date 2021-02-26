import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paran_girin/gallery/gallery_page.dart';
import 'package:paran_girin/home/home_page.dart';
import 'package:paran_girin/layout/tab_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paran_girin/my/mypage.dart';
import 'package:paran_girin/question/question_page.dart';

class DefaultLayout extends StatefulWidget {
  @override
  _DefaultLayoutState createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout>
  with TickerProviderStateMixin {
    // GlobalKey<LoadingWrapperState> _lodingWrapperKey = GlobalKey<LoadingWrapperState>();
  
  PageController _pageController = PageController();
  int _selectedTabIndex = 0;

  // Back 버튼 두 번 누르면 앱 종료
  DateTime currentBackPressTime = DateTime.now();
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (now.difference(currentBackPressTime) > Duration(seconds: 1)) {
          currentBackPressTime = now;
          Fluttertoast.showToast(
            msg: "뒤로 가기 버튼을 한 번 더 누르면 종료됩니다.",
            toastLength: Toast.LENGTH_SHORT,
            fontSize: ScreenUtil().setSp(10), 
          );
          return false;
        }
        return true;
      },
      child: Container(
        // color: Colors.white,
        // child: SafeArea(
        //   top: false,
        //   child: Stack(
        //     alignment: Alignment.bottomCenter,
        //     children: <Widget>[
        //       _buildPageView(context),
        //       _buildBottomTabs(context)
        //     ],
        //   ),
        // ),
        child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              _buildPageView(context),
              _buildBottomTabs(context)
            ],
          ),
      ), 
    );
  }

  Widget _buildPageView(context) {
    return Positioned.fill(
      child: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (idx) {
          setState(() {
            _selectedTabIndex = idx;
          });
        },
        controller: _pageController,
        itemCount: 4,
        itemBuilder: (context, idx) {
          switch (idx) {
            case 0:
              return HomePage(); // HomePage();
            case 1:
              return QuestionPage(); // QuestionPage();
            case 2:
              return GalleryPage(); // ArchivePage();
            case 3:
              return MyPage(); // MyPage();
          }
        },
      )
    );
  }

  Widget _buildBottomTabs(context) {
    return Positioned(
      height: ScreenUtil().setHeight(84),
      left: 0.0,
      right: 0.0,
      child: Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(84),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TabButton(
                svg: "assets/icons/home.svg",
                index: 0,
                controller: _pageController,
                selectedIndex: _selectedTabIndex,
              ),
            ),
            Expanded(
              child: TabButton(
                svg: "assets/icons/question.svg",
                index: 1,
                svgSize: 26,
                controller: _pageController,
                selectedIndex: _selectedTabIndex,
              ),
            ),
            Expanded(
              child: TabButton(
                svg: "assets/icons/gallery.svg",
                index: 2,
                svgSize: 19,
                controller: _pageController,
                selectedIndex: _selectedTabIndex,
              ),
            ),
            Expanded(
              child: TabButton(
                svg: "assets/icons/person.svg",
                index: 3,
                controller: _pageController,
                selectedIndex: _selectedTabIndex,
              ),
            ),
          ],
        ),
      ),
    );
  }


}

