import 'package:flutter/material.dart';

import 'package:my_todo/modules/app/utils/colors/colors.dart';

const personIcon = 0xe491;
const workIcon = 0xe11c;
const movieIcon = 0xe40f;
const sportIcon = 0xe4dc;
const travelIcon = 0xe071;
const shopIcon = 0xe59c;

List<Icon> getIcons() {
  return [
    Icon(IconData(personIcon, fontFamily: 'Materialicons'),
        color: AppColor.purple),
    Icon(IconData(workIcon, fontFamily: 'Materialicons'), color: AppColor.pink),
    Icon(IconData(movieIcon, fontFamily: 'Materialicons'),
        color: AppColor.green),
    Icon(IconData(sportIcon, fontFamily: 'Materialicons'),
        color: AppColor.yellow),
    Icon(IconData(travelIcon, fontFamily: 'Materialicons'),
        color: AppColor.deepPink),
    Icon(IconData(shopIcon, fontFamily: 'Materialicons'),
        color: AppColor.lightBlue),
  ];
}
