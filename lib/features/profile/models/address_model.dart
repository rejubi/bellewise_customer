class AddressModel {

  final int id;

  final String title;

  final String recipientName;

  final String phoneNumber;

  final String address;

  final String city;

  final String state;

  final String landmark;

  final double? latitude;

  final double? longitude;

  final bool isDefault;

  final String fullAddress;



  AddressModel({

    required this.id,

    required this.title,

    required this.recipientName,

    required this.phoneNumber,

    required this.address,

    required this.city,

    required this.state,

    required this.landmark,

    required this.latitude,

    required this.longitude,

    required this.isDefault,

    required this.fullAddress,

  });




  factory AddressModel.fromJson(
      Map<String,dynamic> json,
      ){

    return AddressModel(

      id: json["id"],

      title:
      json["title"] ?? "",


      recipientName:
      json["recipient_name"] ?? "",


      phoneNumber:
      json["phone_number"] ?? "",


      address:
      json["address"] ?? "",


      city:
      json["city"] ?? "",


      state:
      json["state"] ?? "",


      landmark:
      json["landmark"] ?? "",


      latitude:
      json["latitude"]?.toDouble(),


      longitude:
      json["longitude"]?.toDouble(),


      isDefault:
      json["is_default"] ?? false,


      fullAddress:
      json["full_address"] ?? "",

    );

  }

}