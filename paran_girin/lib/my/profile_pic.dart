import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  // File galleryFile;
  FirebaseProvider fp;
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    // galleryFile = fp.getStaticInfo().profile;
    String profile = fp.getUserInfo().currentChild.profileURL;
    String currentChildId = fp.getUserInfo().userInDB.currentChild;
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
                    :Image.network(
                      fp.getStaticInfo().profileURL,
                      fit: BoxFit.cover,
                      ),
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
                      pickPhoto(ImageSource.gallery, currentChildId);
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
    final pickedFile =
        await ImagePicker.pickImage(source: source, imageQuality: 5);
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
  void pickPhoto(ImageSource source, String currentChildId) async {
    final pickedFile = await ImagePicker().getImage(source: source, imageQuality: 5);
    if (pickedFile == null){
      return;
    }

    String profileURL = '$currentChildId.png';
    try {
      final firebaseStorageRef = FirebaseStorage.instance
                                  .ref()
                                  .child('profile')
                                  .child(profileURL);
      final uploadTask = firebaseStorageRef.putFile(
        File(pickedFile.path), SettableMetadata(contentType: 'image/png')
      );

      await uploadTask.whenComplete(() => null);

      Fluttertoast.showToast(
        msg: "프로필 사진이 성공적으로 업로드되었습니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0
      );

    } catch (e) {
      logger.d(e);
    }
    setState(() {
      logger.d(profileURL);
      FirebaseFirestore.instance.collection('children')
                                // .doc(fp.getUserInfo().userInDB.currentChild)
                                .doc(currentChildId)
                                .update({'profileURL': profileURL});
      
      fp.getUserInfo().currentChild.profileURL = profileURL;
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
