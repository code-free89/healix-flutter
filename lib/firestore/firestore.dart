import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> addUserDocument(String uid , String email) async{
    try{
      await fireStore.collection('healix_users').doc(uid).set({
        'email' : email,
        'username' : null,
        'height': null,
        'weight': null,
        'age': null,
      }
      );
      print("User made");
    }catch(e){
      print('Error adding user document: $e');
    }
  }

  Future<void> getUserDetails(String uid ,String? username , int? age , double? height , double? weight) async{
    try{
      await fireStore.collection('healix_users').doc(uid).update({
        'username' : username,
        'age' : age,
        'height' : height,
        'weight' : weight
      });
      print("Updated");
    }catch(e){
      print('Error updating user document: $e');
    }
  }

  Future<void> updateUserDetails(String uid , String? username , int? age , double? height , double? weight) async{
    try{
      if(username!=null){
    await fireStore.collection('healix_users').doc(uid).update({
      'username' : username
    });
  }if(age!=null){
        await fireStore.collection('healix_users').doc(uid).update({
        'age' : age
        });
      }if(height!=null){
        await fireStore.collection('healix_users').doc(uid).update({
        'height' : height
        });
      }if(weight!=null){
        await fireStore.collection('healix_users').doc(uid).update({
        'weight' : weight
        });
      }
      print("Profile Updated");
    }catch(e){
    print('Error updating user document: $e');
    }
  }

  Future<Map<String,dynamic>?> showUserDetails(String uid) async{
    try{
      DocumentSnapshot document = await fireStore.collection('healix_users').doc(uid).get();
      print('Fetched the details');
      return document.data() as Map<String,dynamic>?;
    }catch(e){
      print('Error getting details : $e');
    }
    return null;
  }
}


