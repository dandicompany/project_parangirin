class UserModel {
  String sharedID;
  String id;
  String displayName;
  String email;
  String avatar;
  String currentChild;
  bool isVerified;
  List<String> children;
  // Map<String, dynamic> toJson() => {
  //       'shared': sharedID,
  //       'id': id,
  //       'displayName': displayName,
  //       'email': email,
  //       'avatar': avatar,
  //       'isVerified': isVerified,
  //       'children': children
  //     };
}

class UserInDB {
  String sharedID;
  String avatar;
  String currentChild;
  List<String> children = List<String>();
  UserInDB.sharedID(this.sharedID);
  Map<String, dynamic> toJson() => {
        'sharedID': sharedID,
        'avatar': avatar,
        'currentChild': currentChild,
        'children': children,
      };
}

class Child {
  int birthday;
  String name;
  String profileURL;
  Map<String, String> answers;
  Map<String, dynamic> toJson() => {
        'name': name,
        'profileURL': profileURL,
        'birthday': birthday,
        'answers': answers
      };
}

class Avatar {
  List<String> costume;
  Map<String, dynamic> toJson() => {'costume': costume};
}

class Question {
  int qid;
  String category;
  String story;
  String question;
  String narration1;
  String narration2;
  String guide;
  String tag;
  String videoURL;
  Map<String, dynamic> toJson() => {
        'qid': qid,
        'category': category,
        'story': story,
        'question': question,
        'narration1': narration1,
        'narration2': narration2,
        'guide': guide,
        'tag': tag,
        'videoURL': videoURL
      };
}

class Answer {
  int date;
  String videoURL;
  bool posted;
  Map<String, dynamic> toJson() => {'videoURL': videoURL, 'posted': posted};
}

class Post {
  int date;
  int likes;
  String videoURL;
  String comment;
  List<String> likedPPL;
  Map<String, dynamic> toJson() => {
        'videoURL': videoURL,
        'comment': comment,
        'likes': likes,
        'likedPPL': likedPPL
      };
}
