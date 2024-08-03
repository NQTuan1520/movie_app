import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../domain/auth/entity/user_entity.dart';
import '../../../domain/auth/repository/auth_reposiory.dart';

class FirebaseAuthRepository implements AuthRepository {
  final firebase_auth.FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;

  FirebaseAuthRepository({required this.firebaseAuth, required this.firestore, required this.firebaseStorage});

  @override
  Future<UserEntity> register(String email, String username, String password) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userId = userCredential.user!.uid;

      await firestore.collection('users').doc(userId).set({
        'email': email,
        'username': username,
        'generic': "",
        'avt_img': '',
      });

      return UserEntity(id: userId, email: email, username: username, image: '');
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('The email address is already in use by another account.');
      } else if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else {
        throw Exception('Failed to register: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userDoc = await firestore.collection('users').doc(userCredential.user!.uid).get();

      return UserEntity(
        id: userCredential.user!.uid,
        email: email,
        username: userDoc['username'],
        image: '',
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      } else {
        throw Exception('Failed to login: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  @override
  Future<UserEntity?> getCurrentUser() async {
    final currentUser = firebaseAuth.currentUser;

    if (currentUser != null) {
      final userDoc = await firestore.collection('users').doc(currentUser.uid).get();

      // Check if userDoc exists and handle anonymous users
      if (userDoc.exists) {
        final username = userDoc.data()?['username'] ?? 'Anonymous';
        final email = userDoc.data()?['email'] ?? '';
        final image = userDoc.data()?['avt_img'] ?? '';
        return UserEntity(
          id: currentUser.uid,
          email: email,
          username: username,
          image: image,
        );
      } else {
        // If the userDoc does not exist, handle the anonymous user scenario
        return UserEntity(
          id: currentUser.uid,
          email: '',
          username: 'Anonymous',
          image: '',
        );
      }
    } else {
      return null;
    }
  }

  @override
  Future<UserEntity> loginWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        throw Exception('Sign in aborted by user');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with the credential
      final userCredential = await firebaseAuth.signInWithCredential(credential);

      // Get user's information
      final user = userCredential.user;
      if (user == null) {
        throw Exception('Google sign in failed');
      }

      // Check if user already exists in Firestore
      final userDoc = await firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        // If user doesn't exist, create a new record
        await firestore.collection('users').doc(user.uid).set({
          'email': user.email,
          'username': user.displayName ?? 'Anonymous',
          'generic': "",
          'avt_img': user.photoURL ?? '',
        });
      }

      return UserEntity(
        id: user.uid,
        email: user.email!,
        username: user.displayName ?? 'Anonymous',
        image: user.photoURL ?? '',
      );
    } catch (e) {
      throw Exception('Failed to sign in with Google: $e');
    }
  }

  @override
  Future<UserEntity> signInAnonymously() async {
    try {
      final userCredential = await firebaseAuth.signInAnonymously();
      final user = userCredential.user;

      if (user == null) {
        throw Exception('Anonymous sign in failed');
      }

      return UserEntity(id: user.uid, email: '', username: 'Anonymous', image: "");
    } catch (e) {
      throw Exception('Failed to sign in anonymously: $e');
    }
  }

  @override
  Future<UserEntity> updateProfile(String username) async {
    try {
      final currentUser = firebaseAuth.currentUser;

      final userDoc = await firestore.collection('users').doc(currentUser!.uid).get();

      // Check if userDoc exists and handle anonymous users
      if (userDoc.exists) {
        final email = userDoc.data()?['email'] ?? '';
        final image = userDoc.data()?['avt_img'] ?? '';
        final userId = currentUser.uid;
        await firestore.collection('users').doc(userId).update({
          'username': username,
        });
        //using copy with to update only username
        return UserEntity(
          id: userId,
          email: email,
          username: username,
          image: image,
        );
      } else {
        throw Exception('No user is currently logged in.');
      }
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  @override
  Future<UserEntity> updateImage(Uint8List imageBytes) async {
    try {
      final currentUser = firebaseAuth.currentUser;

      if (currentUser == null) {
        throw Exception('No user is currently logged in.');
      }

      final userId = currentUser.uid;
      final storageReference = firebaseStorage.ref().child('user_avatars').child('$userId}');

      // Upload file
      await storageReference.putData(imageBytes);

      // Get download URL
      final downloadURL = await storageReference.getDownloadURL();

      // Update Firestore document
      await firestore.collection('users').doc(userId).update({
        'avt_img': downloadURL,
      });

      final userDoc = await firestore.collection('users').doc(userId).get();

      final email = userDoc.data()?['email'] ?? '';
      final username = userDoc.data()?['username'] ?? '';

      return UserEntity(
        id: userId,
        email: email,
        username: username,
        image: downloadURL,
      );
    } catch (e) {
      throw Exception('Failed to update image: $e');
    }
  }

  @override
  Future<void> forgotPassword(String email) {
    try {
      return firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Failed to send password reset email: $e');
    }
  }
}
