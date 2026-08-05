import '../data/profile_repository.dart';
import '../models/profile_model.dart';
import '../models/address_model.dart';

class ProfileController {

  final ProfileRepository repository =
  ProfileRepository();

  // ==============================
  // PROFILE
  // ==============================

  Future<ProfileModel> loadProfile() {
    return repository.loadProfile();
  }

  Future<ProfileModel> updateProfile({

    required String address,

    required String city,

    required String state,

  }) {

    return repository.updateProfile(

      address: address,

      city: city,

      state: state,

    );

  }

  // ==============================
  // CHANGE PASSWORD
  // ==============================

  Future<void> changePassword({

    required String oldPassword,

    required String newPassword,

    required String confirmPassword,

  }) {

    return repository.changePassword(

      oldPassword: oldPassword,

      newPassword: newPassword,

      confirmPassword: confirmPassword,

    );

  }

  // ==============================
  // ADDRESSES
  // ==============================

  Future<List<AddressModel>> loadAddresses() {

    return repository.loadAddresses();

  }

  Future<AddressModel> createAddress({

    required String title,

    required String recipientName,

    required String phoneNumber,

    required String address,

    required String city,

    required String state,

  }) {

    return repository.createAddress(

      title: title,

      recipientName: recipientName,

      phoneNumber: phoneNumber,

      address: address,

      city: city,

      state: state,

    );

  }

  Future<void> deleteAddress(
      int id,
      ) {

    return repository.deleteAddress(id);

  }

  // ==============================
  // HELP & SUPPORT
  // ==============================

  Future<Map<String, dynamic>> loadHelpSupport() {

    return repository.loadHelpSupport();

  }

  // ==============================
  // ABOUT BELLEWISE
  // ==============================

  Future<Map<String, dynamic>> loadAbout() {

    return repository.loadAbout();

  }

  // ==============================
  // LOGOUT
  // ==============================

  Future<void> logout() async {

    await repository.logout();

  }

}