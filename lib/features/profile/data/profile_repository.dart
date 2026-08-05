import '../../../core/storage/secure_storage.dart';

import '../models/address_model.dart';
import '../models/profile_model.dart';

import 'address_api.dart';
import 'profile_api.dart';

class ProfileRepository {
  final ProfileApi profileApi = ProfileApi();

  final AddressApi addressApi = AddressApi();

  final SecureStorage secureStorage = SecureStorage();

  // ==============================
  // PROFILE
  // ==============================

  Future<ProfileModel> loadProfile() async {
    final response = await profileApi.getProfile();

    return ProfileModel.fromJson(
      response.data,
    );
  }

  Future<ProfileModel> updateProfile({
    required String address,
    required String city,
    required String state,
  }) async {
    final response = await profileApi.updateProfile(
      address: address,
      city: city,
      state: state,
    );

    return ProfileModel.fromJson(
      response.data,
    );
  }

  // ==============================
  // ADDRESSES
  // ==============================

  Future<List<AddressModel>> loadAddresses() async {
    final response = await addressApi.getAddresses();

    final List data = response.data;

    return data
        .map(
          (item) => AddressModel.fromJson(item),
    )
        .toList();
  }

  Future<AddressModel> createAddress({
    required String title,
    required String recipientName,
    required String phoneNumber,
    required String address,
    required String city,
    required String state,
  }) async {
    final response = await addressApi.createAddress(
      data: {
        "title": title,
        "recipient_name": recipientName,
        "phone_number": phoneNumber,
        "address": address,
        "city": city,
        "state": state,
      },
    );

    return AddressModel.fromJson(
      response.data,
    );
  }

  Future<void> deleteAddress(int id) async {
    await addressApi.deleteAddress(id);
  }

  // ==============================
  // HELP & SUPPORT
  // ==============================

  Future<Map<String, dynamic>> loadHelpSupport() async {
    final response = await profileApi.getHelpSupport();

    return response.data;
  }

  // ==============================
  // ABOUT BELLEWISE
  // ==============================

  Future<Map<String, dynamic>> loadAbout() async {
    final response = await profileApi.getAbout();

    return response.data;
  }

  // ==============================
  // CHANGE PASSWORD
  // ==============================

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await profileApi.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }

  // ==============================
  // LOGOUT
  // ==============================

  Future<void> logout() async {
    await secureStorage.clear();
  }
}