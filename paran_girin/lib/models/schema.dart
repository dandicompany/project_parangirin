class UserModel {
  String id;
  String displayName;
  String email;
  UserInDB userInDB;
  Child currentChild;
}

class UserInDB {
  String sharedID;
  String currentChild;
  List<String> children = List<String>();
  UserInDB.sharedID(String sharedID);
  UserInDB.fromJson(Map<String, dynamic> json)
      : this.sharedID = json['sharedID'],
        this.currentChild = json['currentChild'],
        this.children = json['children'].cast<String>();
  Map<String, dynamic> toJson() => {
        'sharedID': sharedID,
        'currentChild': currentChild,
        'children': children,
      };
}

class Child {
  String name;
  String nickName;
  String profileURL;
  int birthday;
  String avatar;
  Map<String, String> answers = Map<String, String>();
  Child(this.name, this.profileURL, this.nickName, this.birthday, this.avatar);
  Child.fromJson(Map<String, dynamic> json)
      : this.name = json['name'],
        this.nickName = json['nickName'],
        this.profileURL = json['profileURL'],
        this.birthday = json['birthday'],
        this.avatar = json['avatar'],
        this.answers = json['answers'].cast<String, String>();
  Map<String, dynamic> toJson() => {
        'name': name,
        'nickName': nickName,
        'profileURL': profileURL,
        'birthday': birthday,
        'avatar': avatar,
        'answers': answers
      };
}

class Avatar {
  List<String> costume = List<String>();
  Avatar.fromJson(Map<String, dynamic> json)
      : this.costume = json['costume'].cast<String>();
  Map<String, dynamic> toJson() => {'costume': costume};
}

class Question {
  int qid;
  String title;
  String category;
  String story;
  String question;
  String narration1;
  String narration2;
  String guide;
  String tag;
  String videoURL;

  Question.fromJson(Map<String, dynamic> json)
      : this.qid = json['qid'],
        this.title = json['title'],
        this.category = json['category'],
        this.story = json['story'],
        this.question = json['question'],
        this.narration1 = json['narration1'],
        this.narration2 = json['narration2'],
        this.guide = json['guide'],
        this.tag = json['tag'],
        this.videoURL = json['videoURL'];
  Map<String, dynamic> toJson() => {
        'qid': qid,
        'title': title,
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
  Answer(this.date, this.videoURL, this.posted);
  Answer.fromJson(Map<String, dynamic> json)
      : this.date = json['date'],
        this.videoURL = json['videoURL'],
        this.posted = json['posted'];
  Map<String, dynamic> toJson() => {'videoURL': videoURL, 'posted': posted};
}

class Post {
  int date;
  int likes = 0;
  String child;
  String videoURL;
  String comment = "";
  List<String> likedPPL = List<String>();
  Post(this.date, this.child, this.videoURL, this.comment);
  Post.fromJson(Map<String, dynamic> json)
      : this.date = json['date'],
        this.likes = json['likes'],
        this.child = json['child'],
        this.videoURL = json['videoURL'],
        this.comment = json['comment'],
        this.likedPPL = json['likedPPL'].cast<String>();
  Map<String, dynamic> toJson() => {
        'date': date,
        'likes': likes,
        'child': child,
        'videoURL': videoURL,
        'comment': comment,
        'likedPPL': likedPPL
      };
}
