class ProfileModel {

  final int id;

  final String displayName;

  final String firstName;

  final String lastName;

  final String email;

  final String phoneNumber;


  final String address;

  final String city;

  final String state;

  final String fullAddress;


  final double? latitude;

  final double? longitude;



  ProfileModel({

    required this.id,

    required this.displayName,

    required this.firstName,

    required this.lastName,

    required this.email,

    required this.phoneNumber,


    required this.address,

    required this.city,

    required this.state,

    required this.fullAddress,


    required this.latitude,

    required this.longitude,

  });



  factory ProfileModel.fromJson(
      Map<String, dynamic> json,
      ) {

    return ProfileModel(

      id:
      json["id"] ?? 0,


      displayName:
      json["display_name"] ?? "",



      firstName:
      json["first_name"] ?? "",



      lastName:
      json["last_name"] ?? "",



      email:
      json["email"] ?? "",



      phoneNumber:
      json["phone_number"] ?? "",




      address:
      json["address"] ?? "",



      city:
      json["city"] ?? "",



      state:
      json["state"] ?? "",



      fullAddress:
      json["full_address"] ?? "",




      latitude:
      json["latitude"] != null
          ? double.tryParse(
        json["latitude"].toString(),
      )
          : null,



      longitude:
      json["longitude"] != null
          ? double.tryParse(
        json["longitude"].toString(),
      )
          : null,

    );

  }

}