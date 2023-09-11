// ignore_for_file: deprecated_member_use

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final List boardingLists = [
  {
    'title': 'Selamat Datang di Tiga Sendok',
    'description':
        'Tiga Sendok adalah aplikasi yang membantu anda dalam mengelola usaha kuliner anda',
    'image': 'lib/asset/lottie/lottieWelcome.json'
  },
  {
    'title': 'Mudah Digunakan',
    'description':
        'Tiga Sendok dibuat dengan antarmuka yang mudah digunakan sehingga anda dapat dengan mudah menggunakannya',
    'image': 'lib/asset/lottie/lottieStatistic.json'
  },
  {
    'title': 'Mulai Sekarang',
    'description':
        'Mulai gunakan Tiga Sendok sekarang juga untuk membantu anda dalam mengelola usaha kuliner anda',
    'image': 'lib/asset/lottie/lottiePhone.json'
  },
];

final List homeMenuLists = [
  {
    'category': 'customer',
    'title': 'Kelola Pelanggan',
    'description': 'Kelola data pelanggan anda',
    'icon': FontAwesomeIcons.solidUser,
  },
  {
    'category': 'order',
    'title': 'Kelola Pesanan',
    'description': 'Kelola data pesanan anda',
    'icon': FontAwesomeIcons.shoppingBag,
  },
];

final List popupMenuLists = [
  {
    'value': 'edit',
    'title': 'Edit',
    'icon': FontAwesomeIcons.edit,
  },
  {
    'value': 'delete',
    'title': 'Hapus',
    'icon': FontAwesomeIcons.x,
  },
];

final List editCustomerLists = ['Nama', 'Jenis Kelamin', 'Telepon'];
final List genderLists = [
  {
    'value': 'male',
    'title': 'Pria',
  },
  {
    'value': 'female',
    'title': 'Wanita',
  },
  {
    'value': 'other',
    'title': 'Lainnya',
  },
];

final List editOrderLists = [
  'Customer',
  'Product',
  'Price',
  'Quantity',
  'Total',
];
