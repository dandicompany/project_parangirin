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
  String id;
  String avatar;
  String currentChild;
  List<String> children = List<String>();
  UserInDB.sharedID(this.sharedID);
  Map<String, dynamic> toJson() => {
        'sharedID': sharedID,
        'id': id,
        'avatar': avatar,
        'currentChild': currentChild,
        'children': children,
      };
}

class Child {
  int ageInMonth;
  String name;
  String profileURL;
  Map<String, String> answers;
  Map<String, dynamic> toJson() => {
        'name': name,
        'profileURL': profileURL,
        'ageInMonth': ageInMonth,
        'answers': answers
      };
}

class Avatar {
  List<String> costume;
  Map<String, dynamic> toJson() => {'costume': costume};
}

class Question {
  int qid;
  int date;
  String intro;
  String question;
  String guide;
  String videoURL;
  Map<String, dynamic> toJson() => {
        'intro': intro,
        'question': question,
        'guide': guide,
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
