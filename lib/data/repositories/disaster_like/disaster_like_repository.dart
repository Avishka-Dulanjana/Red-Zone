import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../features/disaster_main/models/disaster_model.dart';

class LikeRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> like(DisasterModel disaster, User currentUser) async {
    try {
      await _firestore.collection('likes').add({
        'userId': currentUser.uid,
        'postId': disaster.id,
        'likedAt': Timestamp.now(),
        'likedBy': currentUser.displayName,
        'likedByEmail': currentUser.email,
      });
    } catch (error) {
      print('Error liking disaster: $error');
      rethrow;
    }
  }

  Future<void> unlike(DisasterModel disaster, User currentUser) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> likedDocs = await _firestore.collection('likes').where('userId', isEqualTo: currentUser.uid).where('postId', isEqualTo: disaster.id).get();

      for (final doc in likedDocs.docs) {
        await doc.reference.delete();
      }
    } catch (error) {
      print('Error unliking disaster: $error');
      rethrow;
    }
  }

  Future<List<String>> fetchLikedPostIds() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore.collection('likes').get();

      return querySnapshot.docs.map((doc) => doc['postId'] as String).toList();
    } catch (error) {
      print('Error fetching liked post IDs: $error');
      return [];
    }
  }
}
