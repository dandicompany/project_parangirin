import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paran_girin/layout/base_appbar.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:paran_girin/models/schema.dart';

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  bool _faqVisible = false;
  FirebaseProvider fp;
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    return Scaffold(
      appBar: BaseAppBar(
        title: 'FAQ',
      ),
      body: Column(
        children: [
          SizedBox(width: double.infinity, height: ScreenUtil().setHeight(32)),
          SizedBox(
              height: 600,
              child: FutureBuilder(
                  future: fp.getFirestore().collection("faqs").get(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.done) {
                      List<QueryDocumentSnapshot> faqs = snap.data.docs;
                      List<FaqItem> faqItems = List<FaqItem>();
                      faqs.forEach((element) {
                        faqItems.add(FaqItem.fromJson(element.data()));
                      });
                      faqItems.sort((a, b) => a.order.compareTo(b.order));
                      return ListView.builder(
                          itemBuilder: (context, index) {
                            FaqItem faq = faqItems[index];
                            return FAQElem(
                                faqTitle: faq.title,
                                faqText: faq.content);
                          },
                          itemCount: faqs.length);
                    } else {
                      return SizedBox.shrink();
                    }
                  }))
        ],
      ),
    );
  }
}

class FAQElem extends StatefulWidget {
  final String faqTitle;
  final String faqText;

  const FAQElem(
      {Key key, this.faqTitle, this.faqText})
      : super(key: key);

  @override
  _FAQElemState createState() => _FAQElemState();
}

class _FAQElemState extends State<FAQElem> {
  bool _faqVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _faqVisible = !_faqVisible;
              });
            },
            child: Container(
              height: ScreenUtil().setHeight(48),
              color: Colors.white,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        SizedBox(
                          width: ScreenUtil().setWidth(23),
                        ),
                        Text(
                          widget.faqTitle,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(14),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          _faqVisible
                              ? "assets/icons/arrow-up.svg"
                              : "assets/icons/arrow-down.svg",
                          width: ScreenUtil().setWidth(20),
                          height: ScreenUtil().setHeight(20),
                          color: AppTheme.colors.base3,
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(11),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
          Visibility(
            visible: _faqVisible,
            child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(10),
                    horizontal: ScreenUtil().setWidth(23)),
                color: Colors.white,
                child: Row(children: [
                  Text(
                    widget.faqText,
                    style: TextStyle(
                        color: AppTheme.colors.base1,
                        fontSize: ScreenUtil().setSp(14)),
                  )
                ])),
          )
        ],
      ),
    );
  }
}
