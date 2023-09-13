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

  Future<OrderResponse> getOrdersByStatus(
      {required accessToken, required status}) async {
    final header = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
    final params = {'status': status};

    final response = await get(
      Uri.parse('$baseUrl/orders').replace(queryParameters: params),
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

  Future<CreateOrder> createOrder({
    required accessToken,
    required customerId,
    required productId,
    required quantity,
    required price,
  }) async {
    final header = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
    final body = {
      'customer_id': customerId,
      'product_id': productId,
      'qty': quantity,
      'price': price,
    };

    final response = await post(
      Uri.parse('$baseUrl/orders'),
      headers: header,
      body: jsonEncode(body),
    );

    final data = jsonDecode(response.body);
    final CreateOrder order = CreateOrder.fromJson(data);
    return order;
  }

  Future<UpdateOrder> updateOrderById({
    required accessToken,
    required id,
    required customerId,
    required productId,
    required quantity,
    required price,
  }) async {
    final header = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    final body = {
      'customer_id': customerId,
      'product_id': productId,
      'qty': quantity,
      'price': price,
    };

    final response = await put(
      Uri.parse('$baseUrl/orders/$id'),
      headers: header,
      body: jsonEncode(body),
    );

    final data = jsonDecode(response.body);
    final UpdateOrder order = UpdateOrder.fromJson(data);
    return order;
  }

  Future<Order> deleteOrder({required accessToken, required id}) async {
    final header = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    final response = await delete(
      Uri.parse('$baseUrl/orders/$id'),
      headers: header,
    );

    return Order.fromJson(jsonDecode(response.body));
  }

  Future<PayOrder> payOrderById({required accessToken, required id}) async {
    final header = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    final response = await put(
      Uri.parse('$baseUrl/orders/$id/pay'),
      headers: header,
    );

    final data = jsonDecode(response.body);
    final PayOrder order = PayOrder.fromJson(data);
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
