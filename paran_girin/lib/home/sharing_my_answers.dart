import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/home/video_for_sharing.dart';
import 'package:paran_girin/layout/base_appbar.dart';
import 'package:paran_girin/theme/app_theme.dart';

class SharingMyAnswers extends StatefulWidget {
  int sum;
  @override
  _SharingMyAnswersState createState() => _SharingMyAnswersState();
}

class _SharingMyAnswersState extends State<SharingMyAnswers> {
  @override
  void initState() {
    super.initState();
    widget.sum = 3;
  }

  Widget build(BuildContext context) {
    bool haveAnswers = false;
    if (widget.sum > 0)
      haveAnswers = true;

    return Scaffold(
      appBar: BaseAppBar(
        title: "우리 아이 뽐내기",
        showSend: haveAnswers ? true : false,
        isSend: haveAnswers ? true : false
        ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(16),
          ),
          child: haveAnswers ? ShowAnswers(sum: widget.sum, ) : NoAnswers(),
        ),
      )
    );
  }
}



class ShowAnswers extends StatefulWidget {
  final int sum;

  const ShowAnswers({Key key, this.sum}) : super(key: key);
  @override
  _ShowAnswersState createState() => _ShowAnswersState();
}

class _ShowAnswersState extends State<ShowAnswers> {
  // FirebaseProvider fp;
  bool searched = false;
  TextEditingController textCon = TextEditingController(); 
  @override
  Widget build(BuildContext context) {
    // fp = Provider.of<FirebaseProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: ScreenUtil().setHeight(18),
        ),
        TextField(
          // onSubmitted: (_) => _searchPosts(),
          controller: textCon,
          decoration: InputDecoration(
            prefixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  searched = (textCon.text.length > 0);
                });
              },
              child: Icon(Icons.search, color: AppTheme.colors.base2),
            ),
            hintText: "날짜, 키워드 ...",
            hintStyle: TextStyle(fontSize: ScreenUtil().setSp(16)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
            fillColor: Color.fromRGBO(235, 235, 235, 1),
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(8),
        ),
        // answers list
        for (var i = 0; i < widget.sum; i++)
          VideoForSharing(),
        SizedBox(height: ScreenUtil().setHeight(100)),
      ],
    );
  }
}

class NoAnswers extends StatelessWidget {
  const NoAnswers({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: ScreenUtil().setHeight(212)
        ),
        Container(
          width: ScreenUtil().setWidth(132),
          height: ScreenUtil().setHeight(132),
          child: Image.asset(
            "assets/images/embarassed_sweat 1.png",
            fit: BoxFit.cover
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: ScreenUtil().setHeight(34)
        ),    
        Text(
          "아직 생성된 대화가 없어요\n파란기린과 첫 번째 대화를 시작해보세요.",
          style: TextStyle(
            color: AppTheme.colors.base2,
            fontSize: ScreenUtil().setSp(16),
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.center,
        ),
      ]
    );
  }
}


