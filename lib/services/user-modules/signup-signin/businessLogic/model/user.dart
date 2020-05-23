import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String userImage;
  final String userName;
  final String email;
  final String joinedOn;
  final String Gender;
  final String upvotedPosts, downvotedPosts, commentedPosts;

  User(
      {this.userImage,
      this.userName,
      this.email,
      this.joinedOn,
      this.Gender,
      this.upvotedPosts,
      this.downvotedPosts,
      this.commentedPosts,
      this.uid});


  Map<String, Object> toJson() {
    return {
      'uid':uid,
      'userImage':userImage,
      'userName':userName,
      'email':email,
      'joinedOn':joinedOn,
      'Gender': Gender,

    };

  }

  factory User.fromJson(Map<String, Object> doc) {
    User user = new User(
      uid:doc['uid'],
      joinedOn:doc['joinedOn'],
      userName: doc['userName'],
      email: doc['email'],
      Gender: doc['Gender'],
      upvotedPosts: doc['upvotedPosts'],
      downvotedPosts: doc['downvotedPosts'],
      commentedPosts: doc['commentedPosts'],
    );
    return user;
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    return User.fromJson(doc.data);
  }
}
