import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/home/video_for_sharing.dart';
import 'package:paran_girin/layout/base_appbar.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:paran_girin/models/schema.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paran_girin/layout/splash.dart';
import 'dart:io';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:paran_girin/gallery/myVideoLayout.dart';
import 'package:intl/intl.dart';

class SharingMyAnswers extends StatefulWidget {
  int sum;
  @override
  _SharingMyAnswersState createState() => _SharingMyAnswersState();
}

class _SharingMyAnswersState extends State<SharingMyAnswers> {
  bool searched = false;
  String query;
  FirebaseProvider fp;
  ScrollController scrollController = ScrollController();
  Map<String, Answer> selectedAnswers = Map<String, Answer>();

  @override
  void initState() {
    super.initState();
    widget.sum = 3;
  }

  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    bool haveAnswers = fp.getStaticInfo().answers.isNotEmpty;
    // if (widget.sum > 0) haveAnswers = true;
    var baseAppBar = BaseAppBar(
      title: "우리 아이 뽐내기",
      showSend: selectedAnswers.isNotEmpty ? true : false,
      isSend: selectedAnswers.isNotEmpty ? true : false,
      onSend: uploadPosts,
    );
    return Scaffold(
        appBar: baseAppBar,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(16),
            ),
            child: haveAnswers
                ? ShowAnswers(
                    selectedAnswers: selectedAnswers,
                    refresh: () {
                      setState(() {});
                    })
                : NoAnswers(),
          ),
        ));
  }

  void uploadPosts() {
    selectedAnswers.entries.forEach((element) async {
      String key = element.key;
      Answer answer = element.value;
      String path = await fp.getUploadManager().uploadVideo(answer.videoURL);
      // String thumbnail = await fp.getUploadManager().upload
      String thumbURL =
          await fp.getUploadManager().uploadImage(answer.thumbnail);
      fp.addPost(key, path, thumbURL, null);
    });
  }
}

class ShowAnswers extends StatefulWidget {
  final Map<String, Answer> selectedAnswers;
  final refresh;
  const ShowAnswers({Key key, this.selectedAnswers, this.refresh})
      : super(key: key);

  @override
  _ShowAnswersState createState() => _ShowAnswersState();
}

class _ShowAnswersState extends State<ShowAnswers> {
  // FirebaseProvider fp;
  bool searched = false;
  String query = "";
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
        // TextField(
        //   // onSubmitted: (_) => _searchPosts(),
        //   textInputAction: TextInputAction.search,
        //   onSubmitted: (value) {
        //     setState(() {
        //       query = value;
        //       // searched = (query.length > 0);
        //     });
        //   },
        //   controller: textCon,
        //   decoration: InputDecoration(
        //     prefixIcon: GestureDetector(
        //       onTap: () {},
        //       child: Icon(Icons.search, color: AppTheme.colors.base2),
        //     ),
        //     hintText: "질문을 검색해보세요 :)",
        //     hintStyle: TextStyle(fontSize: ScreenUtil().setSp(16)),
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(25),
        //       borderSide: BorderSide.none,
        //     ),
        //     fillColor: Color.fromRGBO(235, 235, 235, 1),
        //     filled: true,
        //     contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
        //   ),
        // ),
        TextField(
          // onSubmitted: (_) => _searchPosts()
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            setState(() {
              query = value;
              // searched = (query.length > 0);
            });
          },
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
            hintText: "키워드로 검색하기",
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
        // SizedBox(
        //   height: ScreenUtil().setHeight(8),
        // ),
        // answers list
        YesVideo.query(query, widget.selectedAnswers, widget.refresh)
        // for (var i = 0; i < widget.sum; i++) VideoForSharing(),
        // SizedBox(height: ScreenUtil().setHeight(100)),
      ],
    );
  }
}

class YesVideo extends StatelessWidget {
  FirebaseProvider fp;
  String query = "";
  final Map<String, Answer> selectedAnswers;
  final refresh;
  YesVideo.query(this.query, this.selectedAnswers, this.refresh);
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    Map<String, Answer> answers = fp.getStaticInfo().answers;
    List<MapEntry<String, Answer>> entries = List<MapEntry<String, Answer>>();
    for (var entry in answers.entries) {
      if (query != "" && query != null) {
        logger.d(query);
        if (fp.getStaticInfo().questions[entry.key].containsKeyWord(query)) {
          entries.add(entry);
        }
      } else {
        entries.add(entry);
      }
    }
    entries.sort((a, b) => a.value.date.compareTo(b.value.date));
    answers = Map.fromEntries(entries);
    logger.d("num of ansewrs: ${answers.keys.length}");
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: ScreenUtil().setHeight(15),
        ),
        // for (var i = 0; i < sum; i++)
        for (var key in answers.keys)
          FutureBuilder(
            future: () async {
              logger.d("loading answers...");
              Answer answer = Answer.fromJson(answers[key].toJson());
              if (answer == null) {
                return null;
              }
              logger.d("answers loaded");
              logger.d("answer url: ${answer.videoURL}");
              String thumbURL = (await getTemporaryDirectory()).path;

              // answer.thumbnail = null;
              // (await getApplicationDocumentsDirectory()).path;
              // logger.d("path identified: " + answer.thumbnail);
              logger.d("thumb url: ${thumbURL}");
              try {
                logger.d(answer.videoURL);
                // File(answer.videoURL);
                final thumb = await VideoThumbnail.thumbnailFile(
                  video: answer.videoURL,
                  thumbnailPath: thumbURL,
                  imageFormat: ImageFormat.PNG,
                  maxHeight:
                      100, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
                  quality: 25,
                );
                logger.d("thumbnail extracted");
                logger.d(thumb);
                answer.thumbnail = File(thumb);
              } catch (e) {
                logger.d(e);
                return null;
              }

              // answer.thumbnail = thumb.pat
              return answer;
            }(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                logger.d(snapshot.data);
                Answer answer = snapshot.data;
                if (answer == null) {
                  return SizedBox.shrink();
                }
                return VideoForSharing(
                    fp.getStaticInfo().questions[key].title,
                    answer.thumbnail,
                    DateFormat("yyyy/MM/dd").format(
                        DateTime.fromMillisecondsSinceEpoch(answer.date)),
                    "assets/background/${fp.getUserInfo().currentChild.background}",
                    "assets/avatars/${fp.getUserInfo().currentChild.avatar}",
                    () {
                  selectedAnswers[key] = answer;
                  refresh();
                }, () {
                  selectedAnswers.remove(key);
                  refresh();
                }, selectedAnswers.containsKey(key));
              } else {
                return SizedBox.shrink();
              }
            },
          ),
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
          SizedBox(width: double.infinity, height: ScreenUtil().setHeight(212)),
          Container(
            width: ScreenUtil().setWidth(132),
            height: ScreenUtil().setHeight(132),
            child: Image.asset("assets/images/embarassed_sweat 1.png",
                fit: BoxFit.cover),
          ),
          SizedBox(width: double.infinity, height: ScreenUtil().setHeight(34)),
          Text(
            "아직 생성된 대화가 없어요\n파란기린과 첫 번째 대화를 시작해보세요.",
            style: TextStyle(
              color: AppTheme.colors.base2,
              fontSize: ScreenUtil().setSp(16),
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ]);
  }
}
