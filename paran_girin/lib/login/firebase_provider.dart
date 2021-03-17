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

Logger logger = Logger();

class FirebaseProvider with ChangeNotifier {
  final List<String> confirmedProvider = ["facebook.com", "google.com"];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth fAuth = FirebaseAuth.instance; // Firebase 인증 플러그인의 인스턴스
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  User _user; // Firebase에 로그인 된 사용자
  UserModel _info;
  String _lastFirebaseResponse = ""; // Firebase로부터 받은 최신 메시지(에러 처리용)
  String _lastFirebaseExceptionCode = "";

  FirebaseProvider() {
    logger.d("init FirebaseProvider");
    _user = fAuth.currentUser;
    _info = UserModel();
  }

  User getUser() {
    return _user;
  }

  UserModel getUserInfo() {
    return _info;
  }

  void setUser(User value) {
    _user = value;
    notifyListeners();
  }

  Future<String> getServiceAccountToken() async {
    gauth.ServiceAccountCredentials accountCredentials =
        gauth.ServiceAccountCredentials.fromJson({
      "type": "service_account",
      "project_id": "tonal-baton-245112",
      "private_key_id": "8da87a101e5274ce9d75e77975706147dd2a5e5b",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCHdHtbg35h8kcf\n4C7LLu/Cvvn5z9j7KWv1xa8+sPIoFhIeoIl5NY0k9dlun0vlocPLtQ1s5njNFWrw\nFc+vrXhaLIa4QKrfgPxtJBL9K/UC5F+gbfEzi2iRBqKgrP4W8UA3gCIzQ9oMXmru\nFOXsHAQvw7o9/u4MxyJmR+z/tzbJtrbuMc2J4+IWs6CSzB5hMGA/NLLSGUNau83a\nYWLdX/uO4gNrrBML/8+G4mSnGJe1vNQbsBQZKeipKNPIfL+pPpcXal7QVcNe6yqv\nS2diGJkWEHqQC3VCRhRH7Yc6b3ZvuxwsHQKdF/krrI8VGP9iVb4dDDGrQ1PTroZb\nz4GmuLL3AgMBAAECggEAMYft/bo5Eh7SVD0ZT1Hz+V31MZyHxtvQLvhhCwcQHYlo\nicuBSZHD8XJ21iUozyjWXFxxstMZ9EAzMOSA48gGfM7QWnrHIOBdLZml2e7jcnHI\n5/Sb4RHGpFVtTVzEsuX36fOQTfevOZui9TkuFCbwfvjO1xGrwX9lvEnrx1wbDCoc\nP3rjF3idtoTI/tD71ZzNSGdHEg8Kxu4XMvlOkagzq/IWiGDuS+f59MpFOIO+UPea\n1hr7+2y6PUTc4KENLXf4oMowjP0IspqfN8rwkh3eaa8sv3v9nWy4xQiohfnCPm2u\nNFYzddSNlCngATnljLYV/ViZ8BipHSJZj+Do1p28VQKBgQC/i26h2ebGgQPxswy9\nBxRd+or3lHH6lO5TPz/Mr+gfSnR/x13v1a7Q+PRTfdwn9PASluK2xXuajm/inCns\n1qAgnV8Uufk7VGiPcXF3iBnNJRSY1ZIQhqmgcbhtiFCxMXF7CNvewwb6TJvfgnLG\nRzm48Hsk+WDXF23y22csK5+LpQKBgQC1CThyhkAFUM+iW8FWwmEoV/tK1hiuL91t\nLWwUkq0lel8ZNRiFNwIBGswXYW0eTAvwgjlsEHbs6PUCDo6+WX0ov5FKv203JuU6\nlmmiMzikUykCtBgeLRJFzwC7+3677Rtk8RtLUr2hbfLzCs/l1F5jY4r+tD04zWn9\ncUltXdfxawKBgQCk1kpD8PCf3YFWbB7HQaNuaOFUxKP94FLkwyaVcMBSxVFScXDO\np9aEseoZO9PNcwVzCfRbE8IWNQPmQTv3PJCa4LNlc9IfE7nTz+20zyRdHc8G46yK\nmki58YOkh03h30nodqw4nR+RIYJ2q504My1ikVl4bT/AesI84EF+iqAHnQKBgQCI\n5MkHaNb+bgYkOofvaBr529XM2CpfhRhGF4PT5roBThCdShYZnefpF+9eerB9qXmZ\ny49KVQTozpt+i62K6LaI2psuT6RxgPrzm4uTOHJLaArp3W8jWmen3AktHNbPmlMN\nuHgwNAfrCu4ctH9Sxoz9UOdpBLgKvOG54TFp/v1sswKBgHd6mZLLJLzGwp/Zbf/s\nXcq60dtEgeX76F8MBz+/xfwjkDyfH7+BOaI6pCWqtlXZlLxI3F/vqgxmcnfmLezI\nJ12bqHpSzq6QoP044jiLBVXHbVkV5dnRWYfSCnMeDNoPuKiviREdhfkjrFzT4RGz\nQLJkbYX+ra7f3Wj5jbVA7uKt\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-k4hea@tonal-baton-245112.iam.gserviceaccount.com",
      "client_id": "110538781544481540436",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-k4hea%40tonal-baton-245112.iam.gserviceaccount.com"
    });
    List<String> scopes = [
      'https://www.googleapis.com/auth/cloud-platform',
    ];
    var client = new http.Client();
    gauth.AccessCredentials credentials =
        await gauth.obtainAccessCredentialsViaServiceAccount(
            accountCredentials, scopes, client);
    String accessToken = credentials.accessToken.data;
    return accessToken;
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
      _info = UserModel();
      _info.id = _user.uid;
      _info.email = _user.email;
      _info.displayName = _user.displayName;
      DocumentReference userRef = firestore.collection('users').doc(_user.uid);
      DocumentSnapshot snap = await userRef.get();
      if (snap.exists) {
        logger.d('Loading Document...');
        _info.userInDB = UserInDB.fromJson(snap.data());
        String currentChild = _info.userInDB.currentChild;
        if (currentChild != null) {
          DocumentReference childRef =
              firestore.collection('children').doc(currentChild);
          DocumentSnapshot snap = await childRef.get();
          if (snap.exists) {
            _info.currentChild = Child.fromJson(snap.data());
          }
        }
        
        while (true) {

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

  Future<void> addChild(String name, String age) {}

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
