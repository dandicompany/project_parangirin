import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:provider/provider.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  _ProfilePic createState() => _ProfilePic();
}

class _ProfilePic extends State<ProfilePic> {
  File galleryFile;
  FirebaseProvider fp;
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    galleryFile = fp.getStaticInfo().profile;
    String profile = fp.getUserInfo().currentChild.profileURL;
    // File profile = fp.getStaticInfo().profile[profileURL];
    logger.d(profile);
    getPhoto(profile);

    return SizedBox(
        width: ScreenUtil().setWidth(120),
        height: ScreenUtil().setHeight(120),
        child: Stack(
          fit: StackFit.expand,
          overflow: Overflow.visible,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: fp.getStaticInfo().profileURL == null
                    ? Image.asset("assets/images/default_profile.png")
                    :Image.network(fp.getStaticInfo().profileURL),
            ),
            // CircleAvatar(
            //     // backgroundImage: profile == null
            //     backgroundImage: galleryFile == null
            //         ? AssetImage("assets/images/default_profile.png")
            //         : FileImage(File(galleryFile.path))),
            //         // : FileImage(File(profile))),
            Positioned(
              right: 0,
              bottom: 0,
              child: SizedBox(
                width: ScreenUtil().setWidth(28),
                height: ScreenUtil().setHeight(28),
                child: FlatButton(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(
                          color: AppTheme.colors.base1,
                        )),
                    color: Colors.white,
                    onPressed: () {
                      // takePhoto(ImageSource.gallery);
                      pickPhoto(ImageSource.gallery);
                    },
                    child: SvgPicture.asset(
                      "assets/icons/camera.svg",
                      color: AppTheme.colors.base1,
                    )),
              ),
            )
          ],
        ));
  }

  void takePhoto(ImageSource source) async {
    final pickerFile = await ImagePicker().getImage(source: source, imageQuality: 5);
    final pickedFile = File(pickerFile.path);
    // final pickedFile =
    //     await ImagePicker.pickImage(source: source, imageQuality: 5);
    if (pickedFile == null){
      return;
    }
    fp.getUploadManager().uploadImage(pickedFile).then((value) {
      fp.getUserInfo().currentChild.profileURL = value;
      fp
          .getFirestore()
          .collection('children')
          .doc(fp.getUserInfo().userInDB.currentChild)
          .set(fp.getUserInfo().currentChild.toJson());
    });
    setState(() {
      fp.getStaticInfo().profile = pickedFile;
    });
  }

  // 2021.10.07 Jiyun
  void pickPhoto(ImageSource source) async {
    String downloadURL;
    final pickedFile = await ImagePicker().getImage(source: source, imageQuality: 5);
    if (pickedFile == null){
      return;
    }

    String profileURL = '${DateTime.now().millisecondsSinceEpoch}.png';
    try {
      final firebaseStorageRef = FirebaseStorage.instance
                                  .ref()
                                  .child('profile')
                                  .child(profileURL);
      final uploadTask = firebaseStorageRef.putFile(
        File(pickedFile.path), SettableMetadata(contentType: 'image/png')
      );

      await uploadTask.whenComplete(() => null);

      
      downloadURL = await firebaseStorageRef.getDownloadURL();

      logger.d(pickedFile.path);
      fp.getUserInfo().currentChild.profileURL = profileURL;
      // fp.getUserInfo().currentChild.profileURL = downloadURL;
      // fp.getUserInfo().currentChild.profileURL = pickedFile.path;
      // fp.getUserInfo().currentChild.profileURL = "hey";
      Fluttertoast.showToast(
        msg: "프로필 사진이 성공적으로 업로드되었습니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

    } catch (e) {
      logger.d(e);
    }
    setState(() {
      // fp.getStaticInfo().profile = Image.network(downloadURL);
      // fp.getStaticInfo().profile = File(downloadURL);
      // fp.getStaticInfo().profile = File(pickedFile.path);
    });
  }

  void getPhoto(String profileURL) async {
    final firebaseStorageRef = FirebaseStorage.instance
                                  .ref()
                                  .child('profile')
                                  .child(profileURL);
    
    final downloadURL = await firebaseStorageRef.getDownloadURL();

    setState(() {
      fp.getStaticInfo().profileURL = downloadURL;
    });
  }
}
