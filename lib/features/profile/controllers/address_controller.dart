import '../data/address_repository.dart';

import '../models/address_model.dart';



class AddressController {


  final AddressRepository repository =
  AddressRepository();




  Future<List<AddressModel>>
  loadAddresses(){

    return repository.loadAddresses();

  }





  Future<AddressModel>
  createAddress(
      Map<String,dynamic> data,
      ){

    return repository.createAddress(
      data,
    );

  }




  Future<AddressModel>
  updateAddress({

    required int id,

    required Map<String,dynamic> data,

  }){

    return repository.updateAddress(

      id: id,

      data: data,

    );

  }






  Future<void>
  deleteAddress(
      int id,
      ){

    return repository.deleteAddress(
      id,
    );

  }

}