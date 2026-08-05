import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';



class AddressApi {


  Future<Response> getAddresses(){

    return ApiClient.dio.get(
      "/customers/addresses/",
    );

  }





  Future<Response> createAddress({

    required Map<String,dynamic> data,

  }){


    return ApiClient.dio.post(

      "/customers/addresses/",

      data: data,

    );


  }





  Future<Response> updateAddress({

    required int id,

    required Map<String,dynamic> data,

  }){


    return ApiClient.dio.patch(

      "/customers/addresses/$id/",

      data: data,

    );


  }





  Future<Response> deleteAddress(
      int id,
      ){

    return ApiClient.dio.delete(

      "/customers/addresses/$id/",

    );

  }


}