// ignore_for_file: deprecated_member_use

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tigasendok/presentation/screen/manage/edit/manage_edit_customer_screen.dart';

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
    'route': ManageEditCustomerScreen.routeName,
  },
  {
    'value': 'delete',
    'title': 'Hapus',
    'icon': FontAwesomeIcons.x,
    'route': ManageEditCustomerScreen.routeName,
  },
];

final List editCustomerLists = ['Nama', 'Jenis Kelamin', 'Telepon'];
final List genderLists = [
  {
    'value': 'pria',
    'title': 'Pria',
  },
  {
    'value': 'wanita',
    'title': 'Wanita',
  },
  {
    'value': 'lainnya',
    'title': 'Lainnya',
  },
];
