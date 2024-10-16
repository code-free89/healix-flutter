import 'share_preference_provider.dart';

class SharedPreferenceRepository {
  final SharePreferenceProvider _sharePreferenceProvider;

  SharedPreferenceRepository({SharePreferenceProvider? secureStorageProvider})
      : _sharePreferenceProvider =
            secureStorageProvider ?? SharePreferenceProvider();

  Future<void> clearSharePreference() async {
    return await _sharePreferenceProvider.clearSharePreference();
  }

  Future<void> storeUserInfo({String? uid, String? email}) async {
    return await _sharePreferenceProvider.storeUserInfo(
      uid: uid,
      email: email,
    );
  }

  Future<String?> retrieveUserUid() async {
    return await _sharePreferenceProvider.retrieveUserUid();
  }

  Future<String?> retrieveUserEmail() async {
    return await _sharePreferenceProvider.retrieveUserEmail();
  }

  Future<void> storeFirstProfileShownStatus(bool isShown) async {
    return await _sharePreferenceProvider.storeFirstProfileShownStatus(isShown);
  }

  Future<bool?> retrieveFirstProfileShownStatus() async {
    return await _sharePreferenceProvider.retrieveFirstProfileShownStatus();
  }
}
