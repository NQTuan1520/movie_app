
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  Future<bool> setBool(String key, bool value) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(key);
  }

  // static const likedPostsKey = 'likedPosts';

  // Future<Set<String>> getUserLikedPosts() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final likedPostsJson = prefs.getString(likedPostsKey) ?? '[]';
  //   final List<dynamic> likedPostsList = json.decode(likedPostsJson);
  //   return likedPostsList.map((e) => e as String).toSet();
  // }

  // Future<void> saveUserLikedPosts(Set<String> likedPosts) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final likedPostsJson = json.encode(likedPosts.toList());
  //   await prefs.setString(likedPostsKey, likedPostsJson);
  // }

  // Future<void> addLike(String postId) async {
  //   final likedPosts = await getUserLikedPosts();
  //   likedPosts.add(postId);
  //   await saveUserLikedPosts(likedPosts);
  // }

  // Future<void> removeLike(String postId) async {
  //   final likedPosts = await getUserLikedPosts();
  //   likedPosts.remove(postId);
  //   await saveUserLikedPosts(likedPosts);
  // }
}
