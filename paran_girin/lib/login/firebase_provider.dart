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

Logger logger = Logger();

class FirebaseProvider with ChangeNotifier {
  final List<String> confirmedProvider = ["facebook.com", "google.com"];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage firestorage = FirebaseStorage.instance;
  final FirebaseAuth fAuth = FirebaseAuth.instance; // Firebase 인증 플러그인의 인스턴스
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  final UploadManager _uploadManager = UploadManager();
  User _user; // Firebase에 로그인 된 사용자
  UserModel _info;
  String _lastFirebaseResponse = ""; // Firebase로부터 받은 최신 메시지(에러 처리용)
  String _lastFirebaseExceptionCode = "";

  FirebaseProvider() {
    logger.d("init FirebaseProvider");
    _user = fAuth.currentUser;
    _info = UserModel();
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

  UploadManager getUploadManager() {
    return _uploadManager;
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
        setUser(user);
      } on Exception {
        logger.d("deleted user");
        setUser(null);
      }
    }
  }

  Future<bool> loadInfoFromUser() async {
    if (_user != null) {
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
    }
    return true;
  }

  Future<void> addPost(String path, String comment) async {
    logger.d("adding post");
    Post post = Post(DateTime.now().millisecondsSinceEpoch,
        _info.userInDB.currentChild, path, comment);
    DocumentReference postRef =
        await firestore.collection('posts').add(post.toJson());
    logger.d("added child");
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
    DocumentReference docRef = firestore.collection('children').doc(child);
    _info.currentChild = Child.fromJson((await docRef.get()).data());
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
      return false;
    } else {
      return confirmedProvider.contains(_user.providerData[0].providerId) ||
          _user.emailVerified;
    }
  }

  // 이메일/비밀번호로 Firebase에 회원가입
  Future<bool> signUpWithEmail(String email, String password) async {
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
      logger.e(e.toString());
      setLastFBMessage(e.toString());
      setLastFBExceptionCode(e.code);
      return false;
    } on Exception catch (e) {
      logger.e(e.toString());
      List<String> result = e.toString().split(", ");
      setLastFBMessage(result[1]);
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
      logger.e(e.toString());
      setLastFBMessage(e.toString());
      setLastFBExceptionCode(e.code);
      return false;
    } on FirebaseException catch (e) {
      logger.e(e.toString());
      List<String> result = e.toString().split(", ");
      setLastFBMessage(e.toString());
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
      setLastFBMessage(result[1]);
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
      setLastFBMessage(result[1]);
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
    String returnValue = _lastFirebaseResponse;
    _lastFirebaseResponse = "";
    return returnValue;
  }

  getLastFBExceptionCode() {
    String returnValue = _lastFirebaseExceptionCode;
    _lastFirebaseExceptionCode = "";
    return returnValue;
  }
}
