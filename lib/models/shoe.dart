import 'package:flutter/material.dart';
import 'package:nike_shoe/constants/strings.dart';

class Shoe {
  final List<String> image;
  final double price;
  final int id;
  final String name;
  final String longName;
  final String backgroundName;
  final List<Color> color;

  Shoe({
    required this.image,
    required this.price,
    required this.id,
    required this.name,
    required this.longName,
    required this.backgroundName,
    required this.color,
  });
}

final allShoes = [
  Shoe(
    image: [
      nike6a,
      nike6b,
      nike6c,
    ],
    price: 499.56,
    id: 0,
    name: "Nike Air",
    longName: 'Jordan 13 Retro',
    backgroundName: 'NIKE AIR FORCE',
    color: const [
      Color.fromRGBO(43, 51, 119, 1),
      Color.fromRGBO(22, 22, 23, 1),
      Color.fromRGBO(64, 61, 43, 1),
    ],
  ),
  Shoe(
    image: [
      nike7a,
      nike7b,
      nike7c,
      nike7d,
      nike7e,
    ],
    price: 499.56,
    id: 0,
    name: "Nike Air",
    longName: 'Nike Blazer Mid \'77',
    backgroundName: 'NIKE AIR FORCE',
    color: const [
      Color.fromRGBO(219, 179, 61, 1),
      Color.fromRGBO(233, 235, 237, 1),
      Color.fromRGBO(78, 134, 162, 1),
      Color.fromRGBO(220, 220, 222, 1),
      Color.fromRGBO(142, 117, 119, 1),
    ],
  ),
  Shoe(
      image: [nike1],
      price: 499.56,
      id: 0,
      name: "Nike Jordan",
      longName: 'Air Jordan 1 Mid SE',
      backgroundName: 'NIKE JORDAN FORCE',
      color: const [Color.fromRGBO(234, 85, 77, 1)]),
  Shoe(
      image: [nike2],
      price: 345.56,
      id: 0,
      name: "Nike Dunk",
      longName: 'Dunk High',
      backgroundName: 'NIKE DUNK',
      color: const [Color.fromRGBO(127, 24, 22, 1)]),
  Shoe(
      image: [nike3],
      price: 988.00,
      id: 0,
      name: "Nike Air",
      longName: 'Nike Air Force 1 \'07 LV8 1',
      backgroundName: 'NIKE AIR',
      color: const [Color.fromRGBO(237, 193, 66, 1)]),
  Shoe(
      image: [nike4],
      price: 499.56,
      id: 0,
      name: "Nike Vapormax",
      longName: 'Nike Air Vapormax Plus',
      backgroundName: 'NIKE VAPORMAX',
      color: const [Color.fromRGBO(204, 204, 204, 1)]),
  Shoe(
      image: [nike5],
      price: 340.00,
      id: 0,
      name: "Nike Air",
      longName: 'Nike Air Zoom Pegasus 38',
      backgroundName: 'AIR ZOOM',
      color: const [Color.fromRGBO(226, 226, 226, 1)]),
];
