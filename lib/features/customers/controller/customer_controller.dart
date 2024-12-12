

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/firebase_providers.dart';
import '../repository/customer_repository.dart';

final customerControllerProvider= Provider((ref) => CustomerController(customerRepository: ref.watch(CustomerRepositoryProvider), ref: ref));

class CustomerController{

  final CustomerRepository _customerRepository;
  final Ref _ref;
  CustomerController({required CustomerRepository customerRepository,required Ref ref}):
        _customerRepository=customerRepository,_ref=ref, super();

  List<dynamic>getActiveCustomers(){
    // ref.watch(productRepositoryProvider).getProducts();
    return _customerRepository.getActiveCustomers();

  }
  List<dynamic>getInActiveCustomers(){
    // ref.watch(productRepositoryProvider).getProducts();
    return _customerRepository.getInActiveCustomers();

  }
  List<dynamic>getCustomers(){
    // ref.watch(productRepositoryProvider).getProducts();
    return _customerRepository.getCustomers();

  }
}