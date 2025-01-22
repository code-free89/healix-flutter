import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<bool> updateUserAddress(String userId, String newAddress) async {
    try {
      await fireStore.collection('UserProfile').doc(userId).update({
        'address': newAddress,
      });
      return true;
    } catch (e) {
      print("Error updating address in Firestore: $e");
      return false;
    }
  }
}
