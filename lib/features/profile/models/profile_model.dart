class ProfileModel {
  final int id;

  final String publicId;

  final String username;

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
    required this.publicId,
    required this.username,
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
      id: json["id"] ?? 0,

      publicId:
      json["public_id"]?.toString() ?? "",

      username:
      json["username"]?.toString() ?? "",

      displayName:
      json["display_name"]?.toString() ?? "",

      firstName:
      json["first_name"]?.toString() ?? "",

      lastName:
      json["last_name"]?.toString() ?? "",

      email:
      json["email"]?.toString() ?? "",

      phoneNumber:
      json["phone_number"]?.toString() ?? "",

      address:
      json["address"]?.toString() ?? "",

      city:
      json["city"]?.toString() ?? "",

      state:
      json["state"]?.toString() ?? "",

      fullAddress:
      json["full_address"]?.toString() ?? "",

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