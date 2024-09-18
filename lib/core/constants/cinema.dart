import 'package:mbooking/core/constants/assets_images.dart';

class Cinema {
  final String name;
  final String location;
  final String icon;

  Cinema({required this.name, required this.location, required this.icon});
}

List<Cinema> listCinema = [
  Cinema(
    name: 'Vincom Ocean Park CGV',
    location: '4.55 km  |  Da Ton, Gia Lam, Ha Noi',
    icon: AssetsImages.cgv,
  ),
  Cinema(
    name: 'Aeon Mall CGV',
    location: '9.32 km  |  27 Co Linh, Long Bien, Ha Noi',
    icon: AssetsImages.cgv,
  ),
  Cinema(
    name: 'Lotte Cinema Long Bien',
    location: '14.3 km  |  7-9 Nguyen Van Linh, Long Bien, Ha Noi',
    icon: AssetsImages.lotte,
  ),
];
