import 'dart:convert';
import 'package:http/http.dart';
import 'package:tigasendok/data/model/customer_model.dart';
import 'package:tigasendok/data/model/order_model.dart';
import 'package:tigasendok/data/model/product_model.dart';
import 'package:tigasendok/data/model/user_model.dart';

class Repository {
  final baseUrl = 'https://test.goldenmom.id/api';

  Future<UserResponse> userLogin(
      {required String email, required String password}) async {
    final header = {'Content-Type': 'application/json'};
    final body = {'email': email, 'password': password};
    final response = await post(
      Uri.parse('$baseUrl/login'),
      headers: header,
      body: jsonEncode(body),
    );

    final data = jsonDecode(response.body);
    final UserResponse user = UserResponse.fromJson(data);
    return user;
  }

  Future<UserResponse> userRegister({
    required String email,
    required String password,
    required String name,
  }) async {
    final header = {'Content-Type': 'application/json'};
    final body = {
      'email': email,
      'password': password,
      'name': name,
    };
    final response = await post(
      Uri.parse('$baseUrl/register'),
      headers: header,
      body: jsonEncode(body),
    );

    final data = jsonDecode(response.body);
    final UserResponse user = UserResponse.fromJson(data);
    return user;
  }

  Future<UserResponse> userLogOut({required accessToken}) async {
    final header = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
    final response = await post(Uri.parse('$baseUrl/logout'), headers: header);

    final data = jsonDecode(response.body);
    final UserResponse user = UserResponse.fromJson(data);
    return user;
  }

  Future<CustomerResponse> getCustomers({
    required accessToken,
    page = '1',
  }) async {
    final header = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
    final params = {'page': page};
    final response = await get(
      Uri.parse('$baseUrl/customers').replace(queryParameters: params),
      headers: header,
    );

    final data = jsonDecode(response.body);
    final CustomerResponse customer = CustomerResponse.fromJson(data);
    return customer;
  }

  Future<Customer> getCustomerById({
    required int id,
    required accessToken,
  }) async {
    final header = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
    final response = await get(
      Uri.parse('$baseUrl/customers/$id'),
      headers: header,
    );

    final data = jsonDecode(response.body);
    final Customer customer = Customer.fromJson(data);
    return customer;
  }

  Future<Customer> updateCustomerById({
    required int id,
    required accessToken,
    required name,
    required gender,
    required phone,
  }) async {
    final header = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
    final body = {
      'name': name,
      'gender': gender,
      'phone': phone,
    };
    final response = await put(
      Uri.parse('$baseUrl/customers/$id'),
      headers: header,
      body: jsonEncode(body),
    );

    final data = jsonDecode(response.body);
    final Customer customer = Customer.fromJson(data);
    return customer;
  }

  Future<Customer> deleteCustomerByID({
    required id,
    required accessToken,
  }) async {
    final header = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
    final response = await delete(
      Uri.parse('$baseUrl/customers/$id'),
      headers: header,
    );

    if (response.statusCode == 204) {
      final data = jsonDecode(response.body);
      final Customer customer = Customer.fromJson(data);
      return customer;
    } else {
      throw Exception('Failed to delete customer');
    }
  }

  Future<Customer> createCustomer({
    required name,
    required gender,
    required phone,
    required accessToken,
  }) async {
    final header = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
    final body = {
      'name': name,
      'gender': gender,
      'phone': phone,
    };
    final response = await post(
      Uri.parse('$baseUrl/customers'),
      headers: header,
      body: jsonEncode(body),
    );

    final data = jsonDecode(response.body);
    final Customer customer = Customer.fromJson(data);
    return customer;
  }

  Future<OrderResponse> getOrders({required accessToken}) async {
    final header = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
    final response = await get(
      Uri.parse('$baseUrl/orders'),
      headers: header,
    );

    final data = jsonDecode(response.body);
    final OrderResponse order = OrderResponse.fromJson(data);
    return order;
  }

  Future<Order> getOrderById({required accessToken, required id}) async {
    final header = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
    final response = await get(
      Uri.parse('$baseUrl/orders/$id'),
      headers: header,
    );

    final data = jsonDecode(response.body);
    final Order order = Order.fromJson(data);
    return order;
  }

  Future<ProductResponse> getProducts({required accessToken}) async {
    final header = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
    final response = await get(
      Uri.parse('$baseUrl/products'),
      headers: header,
    );

    final data = jsonDecode(response.body);
    final ProductResponse product = ProductResponse.fromJson(data);
    return product;
  }
}
