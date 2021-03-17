import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/question/category_card.dart';
import 'package:paran_girin/question/question_page.dart';
import 'package:paran_girin/theme/app_theme.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Container(
        color: AppTheme.colors.background,
        padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(55),
          left: ScreenUtil().setWidth(16),
          right: ScreenUtil().setWidth(16),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(5.0)
              ),
              child: TextField(
                // onSubmitted: (_) => _searchPosts(),
                // controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: GestureDetector(
                    // onTap: () => _searchPosts(),
                    child: Icon(
                      Icons.search,
                      color: AppTheme.colors.base2
                    ),
                  ),
                  hintText: "질문을 검색해보세요 :)",
                  hintStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(16)
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Color.fromRGBO(235, 235, 235, 1),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                ),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(5)),
            CategoryCard(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QuestionPage(categoryTitle: "사회관계")));
              },
              title: "사회관계",
              hashtag: "#나 #가족 #또래 #지역사회 #우리나라 \n#세계 #사회적가치",
              color: Color.fromRGBO(237, 245, 255, 1),
              icon: "assets/icons/society.svg",
              iconColor: AppTheme.colors.primary2,
            ),
            SizedBox(height: ScreenUtil().setHeight(12)),
            CategoryCard(
              title: "자연탐구",
              hashtag: "#호기심 #수학적탐구 #과학적탐구",
              color: Color.fromRGBO(127, 177, 65, 0.1),
              icon: "assets/icons/nature.svg",
              iconColor: Color.fromRGBO(127, 177, 65, 1),
              iconWidth: 55,
              iconHeight: 55
            ),
            SizedBox(height: ScreenUtil().setHeight(12)),
            CategoryCard(
              title: "예술",
              hashtag: "#예술감상 #예술표현 #심미적탐색",
              color: Color.fromRGBO(245, 75, 139, 0.1),
              icon: "assets/icons/art.svg",
              iconColor: Color.fromRGBO(245, 75, 139, 1)
            ),
            SizedBox(height: ScreenUtil().setHeight(12)),
            CategoryCard(
              title: "신체",
              hashtag: "#감각기관 #운동하기 #건강한 생활 \n#안전한 생활치",
              color: Color.fromRGBO(250, 184, 95, 0.1),
              icon: "assets/icons/body.svg",
              iconColor: Color.fromRGBO(250, 184, 95, 1)
            ),
            SizedBox(height: ScreenUtil().setHeight(12)),
            CategoryCard(
              title: "의사소통",
              hashtag: "#말하기 #쓰기 #건강한 생활 #안전한 생활",
              color: Color.fromRGBO(110, 97, 213, 0.1),
              icon: "assets/icons/communication.svg",
              iconColor: Color.fromRGBO(110, 97, 213, 1),
              iconWidth: 42,
              iconHeight: 42
            ),
          ],
        ),
      ),
    );
      
  }
}


