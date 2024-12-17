import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:helix_ai/util/internet_connetion.dart';



class FirestoreService {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> addUserDocument(String uid, String email) async {
    try {
      await fireStore.collection('healix_users').doc(uid).set({
        'email': email,
        'username': null,
        'height': null,
        'weight': null,
        'age': null,
      });
      print("User made");
    } catch (e) {
      print('Error adding user document: $e');
    }
  }

  Future<bool> getUserDetails(String uid, String? username, int? age,
      double? height, double? weight) async {
    try {
      bool isConnected = await InternetConnection.checkInternet();
      if (isConnected) {
        await fireStore.collection('healix_users').doc(uid).update({
          'username': username,
          'age': age,
          'height': height,
          'weight': weight
        });
        return true;
        print("Updated");
      } else {
        return false;
      }
      return false;
    } catch (e) {
      print('Error updating user document: $e');
      return false;
    }
  }

  Future<bool> updateUserAddress(String userId, String newAddress) async {
    try {
      // Update the address in Firestore
      await fireStore.collection('UserProfile').doc(userId).update({
        'address': newAddress,
      });
      return true;
    } catch (e) {
      print("Error updating address in Firestore: $e");
      return false;
    }
  }

  Future<bool> updateUserDetails(String uid, String? username, int? age,
      double? height, double? weight) async {
    try {
      bool isConnected = await InternetConnection.checkInternet();
      if (isConnected) {
        if (username != null) {
          await fireStore
              .collection('healix_users')
              .doc(uid)
              .update({'username': username}).catchError((e) {
            debugPrint('error $e');
          });
        }
        if (age != null) {
          await fireStore
              .collection('healix_users')
              .doc(uid)
              .update({'age': age});
        }
        if (height != null) {
          await fireStore
              .collection('healix_users')
              .doc(uid)
              .update({'height': height});
        }
        if (weight != null) {
          await fireStore
              .collection('healix_users')
              .doc(uid)
              .update({'weight': weight});
        }
        print("Profile Updated");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error updating user document: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> showUserDetails(String uid) async {
    try {
      DocumentSnapshot document =
          await fireStore.collection('healix_users').doc(uid).get();
      print('Fetched the details');
      return document.data() as Map<String, dynamic>?;
    } catch (e) {
      print('Error getting details : $e');
    }
    return null;
  }
}
