import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';

class ProfileApi {

  Future<Response> getProfile() {

    return ApiClient.dio.get(
      "/customers/profile/",
    );

  }



  Future<Response> updateProfile({

    required String address,

    required String city,

    required String state,

  }) {


    return ApiClient.dio.patch(

      "/customers/profile/",

      data: {

        "address": address,

        "city": city,

        "state": state,

      },

    );

  }
  Future<Response> getAddresses() {

    return ApiClient.dio.get(
      "/customers/addresses/",
    );

  }



  Future<Response> createAddress({

    required String title,
    required String recipientName,
    required String phoneNumber,
    required String address,
    required String city,
    required String state,

  }) {


    return ApiClient.dio.post(

      "/customers/addresses/",

      data: {

        "title": title,

        "recipient_name": recipientName,

        "phone_number": phoneNumber,

        "address": address,

        "city": city,

        "state": state,

      },

    );

  }



  Future<Response> deleteAddress(
      int id,
      ) {


    return ApiClient.dio.delete(

      "/customers/addresses/$id/",

    );

  }


  Future<Response> changePassword({

    required String oldPassword,

    required String newPassword,

    required String confirmPassword,

  }) {

    return ApiClient.dio.post(

      "/customers/profile/change-password/",

      data: {

        "current_password": oldPassword,

        "new_password": newPassword,

        "confirm_password": confirmPassword,

      },

    );

  }

  Future<Response> getHelpSupport() {

    return ApiClient.dio.get(
      "/customers/help-support/",
    );

  }



  Future<Response> getAbout() {

    return ApiClient.dio.get(
      "/customers/about/",
    );

  }
}