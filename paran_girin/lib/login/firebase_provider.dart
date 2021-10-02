import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paran_girin/models/schema.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import "package:http/http.dart" as http;
import "package:googleapis_auth/auth_io.dart" as gauth;
import 'dart:convert';
import 'package:paran_girin/gallery/video_uploader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Logger logger = Logger();

class FirebaseProvider with ChangeNotifier {
  final List<String> confirmedProvider = ["facebook.com", "google.com"];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage firestorage = FirebaseStorage.instance;
  final FirebaseAuth fAuth = FirebaseAuth.instance; // Firebase 인증 플러그인의 인스턴스
  final FirebaseAnalytics fanalytics = FirebaseAnalytics();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  final UploadManager _uploadManager = UploadManager();
  User _user; // Firebase에 로그인 된 사용자
  UserModel _info;
  StaticInfo _static;
  bool _static_loaded = false;
  bool _user_loaded = false;
  String _lastFirebaseResponse = ""; // Firebase로부터 받은 최신 메시지(에러 처리용)
  String _lastFirebaseExceptionCode = "";

  FirebaseProvider() {
    logger.d("init FirebaseProvider");
    _user = fAuth.currentUser;
    _info = UserModel();
    _static = StaticInfo();
    // loadStaticInfo();
  }

  FirebaseFirestore getFirestore() {
    return firestore;
  }

  FirebaseStorage getFirestorage() {
    return firestorage;
  }

  User getUser() {
    return _user;
  }

  UserModel getUserInfo() {
    return _info;
  }

  StaticInfo getStaticInfo() {
    return _static;
  }

  UploadManager getUploadManager() {
    return _uploadManager;
  }

  FirebaseAnalytics getFAnalytics(){
    return fanalytics;
  }

  void setUser(User value) {
    _user = value;
    notifyListeners();
  }

  // 최근 Firebase에 로그인한 사용자의 정보 획득
  Future<void> reloadUser() async {
    User user = fAuth.currentUser;
    if (user != null) {
      try {
        // await user.reload();
        // user = fAuth.currentUser;
        // logger.d("reloaded!");
        // logger.d(user);
        // setUser(user);
        _user_loaded = false;
        setUser(user);
      } on Exception {
        logger.d("deleted user");
        setUser(null);
      }
    }
  }

  void resetStaticInfoOnNextLoad() {
    _static_loaded = false;
  }

  Future<void> reloadAll() async {
    User user = fAuth.currentUser;
    if (user != null) {
      try {
        // await user.reload();
        // user = fAuth.currentUser;
        // logger.d("reloaded!");
        // logger.d(user);
        // setUser(user);
        _user_loaded = false;
        _static_loaded = false;
        setUser(user);
      } on Exception {
        logger.d("deleted user");
        setUser(null);
      }
    }
  }

  Future<bool> loadStaticInfo() async {
    // _static_loaded = false;
    if (_static_loaded) {
      logger.d("static info already loaded");
      return true;
    }
    logger.d("loadgign Static Infos...");
    _static.posts.clear();
    QuerySnapshot snapshot = await firestore.collection('posts').get();
    List<QueryDocumentSnapshot> posts = snapshot.docs.toList();
    logger.d("total posts: ${posts.length}");
    posts.sort((a, b) => b.data()['date'].compareTo(a.data()['date']));
    posts = posts.sublist(0, 3);
    // for (var element in posts) {
    //   Post poSst = Post.fromJson(element.data());
    //   _static.post_videos[post.videoURL] = null;
    //   Reference ref = firestorage.ref(post.videoURL);
    //   File file =
    //       File(join((await getTemporaryDirectory()).path, post.videoURL));
    //   try {
    //     ref.writeToFile(file).whenComplete(() {
    //       _static.post_videos[post.videoURL] = post.videoURL;
    //       notifyListeners();
    //     });
    //   } on FirebaseException catch (e) {
    //     logger.d(e);
    //   }
    // }

    posts.forEach((element) async {
      Post post = Post.fromJson(element.data());
      _static.posts.add(post);
      logger.d("post added");
      Child child = Child.fromJson(await getFromFB("children", post.child));
      _static.post_children[post.child] = child;
      logger.d("profileURL in child: ${child.profileURL}");
      logger.d("thumbURL in post: ${post.thumbURL}");
      Reference refProfile = firestorage.ref(child.profileURL);
      Reference refThumb = firestorage.ref(post.thumbURL);
      String profilePath =
          join((await getTemporaryDirectory()).path, child.profileURL);
      String thumbPath =
          join((await getTemporaryDirectory()).path, post.thumbURL);
      File profile = File(profilePath);
      File thumb = File(thumbPath);
      assert (profile != null);
      assert (thumb != null);
      if (child.profileURL != null) {
        _static.post_profiles[child.profileURL] = null;
        refProfile.writeToFile(profile).then((element) async {
          if (element.state == TaskState.success) {
            _static.post_profiles[child.profileURL] = await profile.create();
            logger.d("${child.profileURL} profile loaded");
            logger.d(element.bytesTransferred);
            logger.d(await profile.length());
            notifyListeners();
          } else if (element.state == TaskState.error) {
            logger.d("error while downloading profiles");
          }
        });
      } else {
        logger.d("not profile url");
      }

      _static.post_thumbnails[post.thumbURL] = null;
      logger.d("trying to load thumbnail");
      logger.d("post thumb url: ${post.thumbURL}");
      refThumb.writeToFile(thumb).then((element) async {
        if (element.state == TaskState.success) {
          _static.post_thumbnails[post.thumbURL] = await thumb.create();
          logger.d("${post.thumbURL} thumbail loaded");
          logger.d(element.bytesTransferred);
          logger.d(await thumb.length());
          notifyListeners();
        } else if (element.state == TaskState.error) {
          logger.d("error while downloading thumbnails");
        } else {
          logger.d("unexpected result in loading thumbnails");
          logger.d(element.state);
        }
      });
    });

    snapshot = await firestore.collection('questions').get();
    List<QueryDocumentSnapshot> questions = snapshot.docs.toList();
    questions.forEach((element) {
      // if (element.id.length > 4) {
      //   firestore.collection('questions').doc(element.id).delete();
      // }
      Question q = Question.fromJson(element.data());
      _static.questions[element.id] = q;
      // firestore
      //     .collection('questions')
      //     .doc(q.qid.toString())
      //     .set(element.data());
    });
    // logger.d(_static.questions);
    _static_loaded = true;
  }

  Future<bool> loadInfoFromUser() async {
    if (_user_loaded) {

      return true;
    }
    if (_user != null) {
      logger.d("loading user info...");
      // _isVerified =
      //     confirmedProvider.contains(_user.providerData[0].providerId) ||
      //         _user.emailVerified;
      // _info = UserModel();
      _info.id = _user.uid;
      _info.email = _user.email;
      _info.displayName = _user.displayName;
      DocumentReference userRef = firestore.collection('users').doc(_user.uid);
      DocumentSnapshot snap = await userRef.get();
      if (snap.exists) {
        logger.d('Loading Document...');
        _info.userInDB = UserInDB.fromJson(snap.data());
        String currentChild = _info.userInDB.currentChild;
        logger.d(currentChild);
        if (currentChild != null) {
          DocumentReference childRef =
              firestore.collection('children').doc(currentChild);
          DocumentSnapshot snap = await childRef.get();
          if (snap.exists) {
            _info.currentChild = Child.fromJson(snap.data());
          } else {
            _info.currentChild = null;
          }
        }
        if (_info.currentChild == null) {
          while (_info.userInDB.children.length > 0) {
            logger.d("setting first child");
            currentChild = _info.userInDB.children.first;
            DocumentReference childRef =
                firestore.collection('children').doc(currentChild);
            DocumentSnapshot snap = await childRef.get();
            if (snap.exists) {
              _info.currentChild = Child.fromJson(snap.data());
              _info.userInDB.currentChild = currentChild;
              logger.d("got children");
              break;
            } else {
              _info.userInDB.children.removeAt(0);
            }
          }
        }
      } else {
        logger.d('Document does not exist on the database');
        UserInDB temp = UserInDB.sharedID(_user.uid);
        await userRef.set(temp.toJson());
        _info.userInDB = temp;
      }
      logger.d(_info.userInDB.children);
    } else {
      logger.d("null user, so pass loading user info");
    }
    Map<String, String> answers = _info.currentChild.answers;
    _static.answers.clear();
    for (var key in answers.keys) {
      var value = answers[key];
      getFromFB("answers", value).then((value) {
        Answer ans = Answer.fromJson(value);
        print(ans);
        if (ans == null) {
          logger.d("no ans");
        }
        _static.answers[key] = ans;
        notifyListeners();
      });
    }
    String profileURL = _info.currentChild.profileURL;
    _static.profile = null;
    if (profileURL != null) {
      Reference ref = firestorage.ref(profileURL);
      File file =
          File(join((await getTemporaryDirectory()).path, "profile.png"));
      ref.writeToFile(file).then((value) {
        if (value.state == TaskState.success) {
          _static.profile = file;
        }
      }).catchError((error) {
        logger.d(error);
      });
    }
    _user_loaded = true;
    logger.d("finished");
    return true;
  }

  Future<void> addOpinionQuestion(String content) async {
    logger.d("adding opinion-question");
    OpinionQuestion oq = OpinionQuestion(
        DateTime.now().millisecondsSinceEpoch, "-1", _info.id, content);
    DocumentReference oqRef =
        await firestore.collection('opinion_questions').add(oq.toJson());
  }

  Future<void> addOpinionWish(String content) async {
    logger.d("adding opinion-question");
    OpinionWish ow = OpinionWish(
        DateTime.now().millisecondsSinceEpoch, "-1", _info.id, content);
    DocumentReference owRef =
        await firestore.collection('opinion_wishes').add(ow.toJson());
  }

  Future<void> addPost(
      String qid, String path, String thumbnail, String comment) async {
    logger.d("adding post");
    Post post = Post(DateTime.now().millisecondsSinceEpoch, qid, title,
        _info.userInDB.currentChild, path, thumbnail, comment);
    DocumentReference postRef =
        await firestore.collection('posts').add(post.toJson());
  }

  Future<void> addAnswer(String question, String path) async {
    logger.d("adding answer");
    Answer answer = Answer(DateTime.now().millisecondsSinceEpoch, path, false);
    DocumentReference ansRef =
        await firestore.collection('answers').add(answer.toJson());
    _info.currentChild.answers[question] = ansRef.id;
    DocumentReference childRef =
        firestore.collection('children').doc(_info.userInDB.currentChild);
    childRef.set(_info.currentChild.toJson());
    logger.d("answer added");
  }

  Future<void> deleteAnswer(String question, String path) async {
    logger.d("deleting answer");
    Answer answer = Answer(DateTime.now().millisecondsSinceEpoch, path, false);
    DocumentReference ansRef =
        await firestore.collection('answers').add(answer.toJson());
    _info.currentChild.answers[question] = ansRef.id;
    DocumentReference childRef =
        firestore.collection('children').doc(_info.userInDB.currentChild);
    childRef.set(_info.currentChild.toJson());
    // firestore.collection('answers').document(docID).delete();
    // firestore.collection('children').document(docID).delete();
    logger.d("answer deleted");
  }

  Future<void> addChild(String name, String nickName, int birthday) async {
    logger.d("adding child");
    Child child = Child(name, null, nickName, birthday, null);
    DocumentReference childRef =
        await firestore.collection('children').add(child.toJson());
    _info.userInDB.children.add(childRef.id);
    _info.userInDB.currentChild = childRef.id;
    DocumentReference userRef = firestore.collection('users').doc(_user.uid);
    await userRef.set(_info.userInDB.toJson());
    _info.currentChild = child;
    logger.d("added child");
  }

  void switchChild(String child) async {
    logger.d("switching child to $child");
    _info.userInDB.currentChild = child;
    DocumentReference userRef = firestore.collection('users').doc(_user.uid);
    await userRef.set(_info.userInDB.toJson());
    reloadUser();
    // DocumentReference docRef = firestore.collection('children').doc(child);
    // _info.currentChild = Child.fromJson((await docRef.get()).data());
  }

  Future<Map<String, dynamic>> getFromFB(String colName, String docName) async {
    DocumentReference userRef = firestore.collection(colName).doc(docName);
    DocumentSnapshot snap = await userRef.get();
    if (snap.exists) {
      logger.d(snap.data());
      return snap.data();
    } else {
      return null;
    }
  }

  Future<bool> initializeUserState() async {
    // _user = fAuth.currentUser;
    if (_user == null) {
      return false;
    }
    try {
      logger.d("!initializing...");
      await _user.reload();
      _user = fAuth.currentUser;
      logger.d("reloaded");
      await loadInfoFromUser();
      logger.d("initialized");
      return false;
    } on Exception {
      logger.d("deleted user");
      setUser(null);
      return false;
    }
  }

  bool checkVerifiedUser() {
    if (_user == null) {
      logger.d("null user");
      return false;
    } else {
      if (! _user.emailVerified){
        logger.d("user email not verified");
      }
      if (! confirmedProvider.contains(_user.providerData[0].providerId)){
        logger.d("provider mail not verified");
      }
      return confirmedProvider.contains(_user.providerData[0].providerId) ||
          _user.emailVerified;
    }
  }

  // 이메일/비밀번호로 Firebase에 회원가입
  Future<bool> signUpWithEmail(String email, String password) async {
    await fAuth.setLanguageCode("ko");

    try {
      UserCredential result = await fAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (result.user != null) {
        // 인증 메일 발송
        result.user.sendEmailVerification();
        // 새로운 계정 생성이 성공하였으므로 기존 계정이 있을 경우 로그아웃 시킴
        // await loadInfoFromUser();
        reloadUser();
        return true;
      }
    } on FirebaseAuthException catch (e) {
      logger.e(e.code);
      setLastFBMessage(e.toString());
      setLastFBExceptionCode(e.code);
      return false;
    } on Exception catch (e) {
      logger.e(e.toString());
      List<String> result = e.toString().split(", ");
      // setLastFBMessage(interpretFBMessage(e.code));
      return false;
    }
  }

  // 이메일/비밀번호로 Firebase에 로그인
  Future<bool> signInWithEmail(String email, String password) async {
    try {
      logger.d(email + password);
      var result = await fAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (result != null) {
        // await loadInfoFromUser();
        setUser(result.user);
        logger.d(getUser());
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      logger.e(e.code);
      setLastFBMessage(interpretFBMessage(e.code));
      setLastFBExceptionCode(e.code);
      return false;
    } on FirebaseException catch (e) {
      logger.e(e.code);
      List<String> result = e.toString().split(", ");
      setLastFBMessage(interpretFBMessage(e.code));
      setLastFBExceptionCode(e.code);

      logger.e(e.code);
      return false;
    }
  }

  Future<bool> signInWithGoogleAccount() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      User user = (await fAuth.signInWithCredential(credential)).user;
      logger.d(user);
      // await loadInfoFromUser();
      setUser(user);
      return true;
    } on Exception catch (e) {
      logger.e(e.toString());
      List<String> result = e.toString().split(", ");
      // setLastFBMessage(interpretFBMessage(e.code));
      return false;
    }
  }

  Future<bool> signInWithFacebookAccount() async {
    try {
      AccessToken accessToken = await _facebookAuth.login();
      AuthCredential credential =
          FacebookAuthProvider.credential(accessToken.token);
      UserCredential authResult = await fAuth.signInWithCredential(credential);
      User user = authResult.user;
      logger.d(user);
      // await loadInfoFromUser();
      setUser(user);
      return true;
    } on Exception catch (e) {
      logger.e(e.toString());
      List<String> result = e.toString().split(", ");
      // setLastFBMessage(interpretFBMessage(e.code));
      return false;
    }
  }

  // Firebase로부터 로그아웃
  signOut() async {
    await fAuth.signOut();
    setUser(null);
  }

  // 사용자에게 비밀번호 재설정 메일을 영어로 전송 시도
  sendPasswordResetEmailByEnglish() async {
    await fAuth.setLanguageCode("en");
    sendPasswordResetEmail();
  }

  // 사용자에게 비밀번호 재설정 메일을 한글로 전송 시도
  sendPasswordResetEmailByKorean() async {
    await fAuth.setLanguageCode("ko");
    sendPasswordResetEmail();
  }

  // 사용자에게 비밀번호 재설정 메일을 전송
  sendPasswordResetEmail() async {
    fAuth.sendPasswordResetEmail(email: getUser().email);
  }

  // Firebase로부터 회원 탈퇴
  withdrawalAccount() async {
    await getUser().delete();
    setUser(null);
  }

  // Firebase로부터 수신한 메시지 설정
  setLastFBMessage(String msg) {
    _lastFirebaseResponse = msg;
  }

  setLastFBExceptionCode(String code) {
    _lastFirebaseExceptionCode = code;
  }

  // Firebase로부터 수신한 메시지를 반환하고 삭제
  getLastFBMessage() {
    var code = _lastFirebaseExceptionCode;
    return interpretFBMessage(code);
    String returnValue = _lastFirebaseResponse;
    _lastFirebaseResponse = "";
    return returnValue;
  }

  interpretFBMessage(String code) {
    switch (code) {
      case "too-many-requests":
        return "로그인 시도 횟수가 많습니다. 잠시 후 다시 시도해주세요.";
      case "invalid-email":
        return "잘못된 이메일 형식입니다.";
      case "wrong-password":
        return "잘못된 비밀번호입니다.";
      case "weak-password":
        return "6자리 이상의 비밀번호를 입력해주세요.";
      default:
        return "알 수 없는 에러";
        break;
    }
  }

  getLastFBExceptionCode() {
    String returnValue = _lastFirebaseExceptionCode;
    _lastFirebaseExceptionCode = "";
    return returnValue;
  }

  logScreenView(int pid_prev, int pid) async {
    await fanalytics.logEvent(name: "screen_view", parameters: <String, int>{"firebase_previous_screen": pid_prev, "firebase_screen": pid});
  }

  logScreenViewString(String  screenClass, String screenName) async {
    await fanalytics.logEvent(name: "screen_view", parameters: <String, String>{"screen_class": screenClass, "screen_name": screenName});
  }

  logOnboardingStart() async {
    await fanalytics.logEvent(name: "onboarding_start");
  }

  logHomeToday() async {
    await fanalytics.logEvent(name: "home_today");
  }

  logHomeRecommendationStart() async {
    await fanalytics.logEvent(name: "home_recommendation_start");
  }

  logHomeBbom() async {
    await fanalytics.logEvent(name: "home_bbom");
  }

  logGalleryPlay(int question_num, int video_duration, int play_duration) async {
    await fanalytics.logEvent(name: "gallery_play", parameters: <String, int>{"question_num": question_num, "video_duration": video_duration, "play_duration": play_duration});
  }

  logGalleryShare(String gallery_share) async {
    await fanalytics.logEvent(name: "gallery_share", parameters: <String, String>{"gallery_share": gallery_share});
  }

  logGalleryDelete() async {
    await fanalytics.logEvent(name: "gallery_delete");
  }
  
  logTab2Cetegory(String tab2_category) async {
    await fanalytics.logEvent(name: "tab2_category", parameters: <String, String>{"tab2_category": tab2_category});
  } 

  logTab2CetegoryQuestion(int qid) async {
    await fanalytics.logEvent(name: "tab2_category_question", parameters: <String, int>{"tab2_category_question": qid});
  } 

  logTab2SearchQuestion(int qid) async {
    await fanalytics.logEvent(name: "tab2_search_question", parameters: <String, int>{"tab2_search_question": qid});
  } 

  logTab2StartQuestion(int qid) async {
    await fanalytics.logEvent(name: "tab2_start_question", parameters: <String, int>{"tab2_start_question": qid});
  } 


}