//follow tuşuna basılınca yapılacaklar:
//1- basan kişinin following collectionuna basılan kişi eklenecek
//2- bsılan kişinin followers collectionuna basan kişi eklenecek
//3- follow tuşu unfollow tuşuna dönecek
//4- basan kişinin following int değeri 1 artacak
//5- basılan kişinin followers int değeri 1 artacak
//ek: collectionda sadece user id ve userName tutulacak
//unfollow tuşuna basılınca:
//aynısının tersi
import 'dart:developer';

import 'package:check_point/models/run_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SocialService {
  SocialService._private();
  static final SocialService _instance = SocialService._private();
  factory SocialService() {
    return _instance;
  }
  final usersRef = FirebaseFirestore.instance.collection("users");
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  var stream = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  void follow(String userId, String userName) async {
    addToFollowings(userId, userName);
    addToFollowers(userId, userName);
    increaseFollowingCount();
    increaseFollowerCount(userId);
  }

  void unfollow(String userId) {
    removeFromFollowers(userId);
    removeFromFollowings(userId);
    decreaseFollowerCount(userId);
    decreaseFollowingCount();
  }

  void addToFollowings(String userId, String userName) async {
    await usersRef
        .doc(currentUserId)
        .collection("followings")
        .doc(userId)
        .set({"userId": userId, "userName": userName});
  }

  void addToFollowers(String userId, String userName) async {
    var currentUser = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserId)
        .get();
    var currentUserName = currentUser.data()!["userName"];
    await usersRef
        .doc(userId)
        .collection("followers")
        .doc(currentUserId)
        .set({"userId": currentUserId, "userName": currentUserName});
  }

  void increaseFollowingCount() async {
    await usersRef
        .doc(currentUserId)
        .update({"following": FieldValue.increment(1)});
  }

  void increaseFollowerCount(String userId) async {
    await usersRef.doc(userId).update({"followers": FieldValue.increment(1)});
  }

  void removeFromFollowings(String userId) async {
    await usersRef
        .doc(currentUserId)
        .collection("followings")
        .doc(userId)
        .delete();
  }

  void removeFromFollowers(String userId) async {
    var currentUser = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserId)
        .get();
    await usersRef
        .doc(userId)
        .collection("followers")
        .doc(currentUserId)
        .delete();
  }

  void decreaseFollowingCount() async {
    await usersRef
        .doc(currentUserId)
        .update({"following": FieldValue.increment(-1)});
  }

  void decreaseFollowerCount(String userId) async {
    await usersRef.doc(userId).update({"followers": FieldValue.increment(-1)});
  }

  Future<bool> amIFollowing(String userId) async {
    var myvar = await usersRef
        .doc(currentUserId)
        .collection("followings")
        .doc(userId)
        .get();
    return myvar.exists;
  }

  Stream<DocumentSnapshot> amIFollowingAsStreamSnapshot(String userId) {
    return usersRef
        .doc(currentUserId)
        .collection("followings")
        .doc(userId)
        .snapshots();
  }

  Future<List<RunModel>> getUsersRuns(String? userID) async {
    log("userID: $userID");

    bool isHomePageRuns = userID == null;

    List<RunModel> runs = [];
    final snapshot = await FirebaseFirestore.instance
        .collection("runs")
        .where("userId", isEqualTo: userID)
        .limit(isHomePageRuns ? 20 : 1000)
        .get();
    for (var doc in snapshot.docs) {
      runs.add(RunModel().fromMap(doc.data()));
    }

    log("runs: $runs");
    return runs;
  }
}
