import '../models/address_model.dart';

import 'address_api.dart';



class AddressRepository {


  final AddressApi api =
  AddressApi();




  Future<List<AddressModel>>
  loadAddresses() async {


    final response =
    await api.getAddresses();



    final List data =
        response.data;



    return data
        .map(
          (item) =>
          AddressModel.fromJson(
            item,
          ),
    )
        .toList();

  }






  Future<AddressModel>
  createAddress(
      Map<String,dynamic> data,
      ) async {


    final response =
    await api.createAddress(
      data: data,
    );


    return AddressModel.fromJson(
      response.data,
    );

  }






  Future<AddressModel>
  updateAddress({

    required int id,

    required Map<String,dynamic> data,

  }) async {


    final response =
    await api.updateAddress(

      id: id,

      data: data,

    );


    return AddressModel.fromJson(
      response.data,
    );

  }






  Future<void>
  deleteAddress(
      int id,
      ) async {


    await api.deleteAddress(
      id,
    );

  }


}