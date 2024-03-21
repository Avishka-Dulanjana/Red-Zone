import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:red_zone/data/repositories/disaster_like/disaster_like_repository.dart';
import 'package:red_zone/features/disaster_main/models/disaster_model.dart';

class LikeController extends GetxController {
  final LikeRepository _likeRepository = Get.put(LikeRepository());
  late GetStorage _storage;
  late FirebaseFirestore _firestore;

  // Map to store like state for each post ID
  final Map<String, RxBool> _likeMap = {};

  // Reactive variable to store like count
  final RxInt likeCount = RxInt(0);

  @override
  void onInit() {
    super.onInit();
    _initializeStorage();
    _firestore = FirebaseFirestore.instance; // Initialize firestore
  }

  Future<void> _initializeStorage() async {
    _storage = GetStorage();
  }

  // Method to toggle like
  void toggleLike(DisasterModel disasters) async {
    final postId = disasters.id;

    // Check if like state exists for the post ID
    if (!_likeMap.containsKey(postId)) {
      _likeMap[postId] = false.obs; // Initialize like state for the post ID
    }

    final user = FirebaseAuth.instance.currentUser!;

    if (_likeMap[postId]!.value) {
      await _likeRepository.unlike(disasters, user);
    } else {
      await _likeRepository.like(disasters, user);
    }

    _likeMap[postId]!.toggle(); // Toggle like state for the post ID

    // Update like count after toggling like state
    await updateLikeCount(postId);
  }

  // Method to check if a post is liked
  bool isLiked(String postId) {
    return _likeMap[postId]?.value ?? (_storage.read(postId) ?? false);
  }

  // Method to get the observable like state for a post
  RxBool getLikeState(String postId) {
    return _likeMap.putIfAbsent(postId, () => false.obs);
  }

  // Method to fetch the like count for a specific disaster
  Future<int> fetchLikeCount(String postId) async {
    try {
      // Query the 'likes' collection to count the number of likes for the post ID
      final querySnapshot = await _firestore.collection('likes').where('postId', isEqualTo: postId).get();

      // Get the count directly using the .size property of the QuerySnapshot
      final count = querySnapshot.size;

      return count;
    } catch (error) {
      print('Error fetching like count: $error');
      return 0; // Return 0 in case of errors
    }
  }

  // Method to update the like count asynchronously
  Future<void> updateLikeCount(String postId) async {
    final count = await fetchLikeCount(postId); // Fetch the like count
    likeCount.value = count; // Update the like count in the reactive variable
  }
}
