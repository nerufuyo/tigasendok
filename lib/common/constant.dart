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
    'title': 'Kelola Pelanggan',
    'description': 'Kelola data pelanggan anda',
    'icon': FontAwesomeIcons.users,
    'route': '/customer-screen'
  },
  {
    'title': 'Kelola Pesanan',
    'description': 'Kelola data pesanan anda',
    'icon': FontAwesomeIcons.shoppingBag,
    'route': '/customer-screen'
  },
];
